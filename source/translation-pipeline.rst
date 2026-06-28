.. _translation-pipeline:

==================================================
번역 파이프라인 동작 원리 (GitHub ↔ Weblate)
==================================================

이 문서는 infra-cloud-kr 문서가 **어떻게 자동으로 번역·동기화되는지** 그 구조를 설명합니다.
실제 번역 방법은 :ref:`translation-guide` 를, 여기서는 **시스템이 어떻게 맞물려 돌아가는지**\를
학습합니다. (멘토·메인테이너, 그리고 i18n 인프라가 궁금한 분을 위한 문서입니다.)

.. contents:: 목차
   :local:
   :depth: 2

전체 그림
=========

.. figure:: /_static/img/weblate/pipeline.svg
   :alt: GitHub와 Weblate 사이의 양방향 번역 파이프라인 다이어그램
   :width: 100%

   원문/문자열은 **GitHub → Weblate**\(①)로, 번역 결과는 **Weblate → GitHub**\(②)로 흐릅니다.

구성 요소는 다음과 같습니다.

- **GitHub 저장소** : ``infra-cloud-kr/infra-cloud-kr.github.io`` — 원문(RST)과 번역(.po)의 원본
- **Weblate** : https://translate.openinfra.kr — 번역 작업 플랫폼
- **GitHub Actions** : 빌드·배포 및 번역 카탈로그 자동 생성
- **GitHub Pages** : 최종 문서 사이트 (한국어 ``/`` · 영어 ``/en/``)


핵심 개념: Weblate는 ``.po``\를 읽고 씁니다
============================================

가장 먼저 이해해야 할 점은, **Weblate가 RST 원문을 직접 다루지 않는다**\는 것입니다.
Sphinx 문서는 gettext 방식으로 번역되며, 번역의 단위는 ``.po`` 파일입니다.

.. code-block:: text

   index.rst (한국어 원문)
        │  Sphinx로 추출 (make update-po)
        ▼
   source/locales/en/LC_MESSAGES/docs.po   ← Weblate가 읽고/쓰는 파일
        │  Sphinx 빌드 (-D language=en)
        ▼
   영어 HTML (/en/)

- 번역 **대상 문자열**\은 원문 RST에서 추출되어 ``docs.po``\의 ``msgid``\가 됩니다.
- 번역 **결과**\는 ``docs.po``\의 ``msgstr``\에 저장됩니다.
- 그래서 **원문이 바뀌면 ``.po``\를 다시 생성**\해야 새 문장이 Weblate에 나타납니다.
  이 재생성을 자동화한 것이 아래 ①의 GitHub Actions입니다.

.. note::

   이 프로젝트는 ``conf.py``\에서 ``gettext_compact = 'docs'`` 로 설정해
   **모든 문서를 하나의 ``docs.po`` 카탈로그로 합칩니다.** 덕분에 새 ``.rst`` 문서를
   추가해도 그 문장들이 같은 카탈로그에 들어가, Weblate 컴포넌트 하나가 자동으로 포착합니다.


① GitHub → Weblate : 원문/문자열 반영
=====================================

저장소의 원문이 바뀌면 그 변화가 Weblate에 반영되는 흐름입니다. **두 단계**\로 이루어집니다.

1단계 — 카탈로그 자동 재생성 (GitHub Actions)
---------------------------------------------

``source/**.rst`` 또는 ``conf.py`` 가 ``main``\에 push되면
워크플로우 ``.github/workflows/i18n-sync.yml`` 이 실행됩니다.

.. code-block:: text

   sphinx-build -b gettext source _build/gettext      # 원문에서 .pot 추출
   sphinx-intl update -p _build/gettext -l en         # docs.po 갱신(기존 번역 보존)
   → 변경이 있으면 docs.po 를 자동 커밋

- ``sphinx-intl update`` 는 내부적으로 ``msgmerge``\를 수행하여 **기존 번역은 유지**\하면서
  새 문장 추가 / 사라진 문장 정리 / 변경된 문장 표시(fuzzy)를 처리합니다.
- 커밋은 GitHub 기본 ``GITHUB_TOKEN``\으로 이뤄지며, 별도 시크릿이 필요 없습니다.

2단계 — Weblate가 변경을 받아옴 (Webhook)
------------------------------------------

GitHub 저장소의 **Webhook**\이 push 때마다 Weblate의 알림 엔드포인트로 신호를 보냅니다.

.. code-block:: text

   GitHub (push)  ──POST──▶  https://translate.openinfra.kr/hooks/github/
                              → Weblate가 해당 저장소를 pull → 새 문자열 노출

- 이 엔드포인트는 **인증이 필요 없습니다.** Weblate는 payload의 저장소를 기존 컴포넌트와
  대조한 뒤, **컴포넌트에 등록된 신뢰된 URL에서만** pull합니다(payload 내용을 받아오지 않음).
- 저장소가 **공개(public)**\라 Weblate는 익명으로 읽으므로 읽기용 자격증명도 불필요합니다.

.. tip::

   Webhook이 없거나 즉시 반영이 안 될 때를 대비해, Weblate는 주기적으로도 저장소를
   확인하도록 설정할 수 있습니다. 또한 관리자는 Weblate UI의 *Manage → Repository* 에서
   수동으로 pull할 수 있습니다.


② Weblate → GitHub : 번역 결과 반영
===================================

번역가가 Weblate에서 저장한 번역이 다시 저장소로 돌아가는 흐름입니다.

.. code-block:: text

   번역가가 Weblate에서 번역 저장
        ▼
   Weblate가 docs.po 에 커밋 (지연 커밋: 일정 시간/분량마다 묶음)
        ▼
   weblate-translations 브랜치로 push   ── 인증: GitHub PAT
        ▼
   Pull Request 자동 생성/갱신 (컴포넌트당 PR 1개)
        ▼
   멘토(메인테이너) 리뷰 후 머지
        ▼
   GitHub Actions가 영어 문서 빌드 → GitHub Pages 배포 (/en/)

- Weblate가 GitHub로 **push / PR 생성**\을 하려면 **쓰기 권한이 있는 인증**\이 필요합니다.
  이 프로젝트는 서버 환경변수에 등록한 **개인 액세스 토큰(PAT)**\을 사용합니다.
- 번역은 곧바로 한 건씩 push되지 않고, Weblate가 **묶어서(지연 커밋)** 처리하므로
  하나의 PR이 점진적으로 갱신됩니다.
- PR이 머지되기 전에는 사이트에 반영되지 않습니다(리뷰 단계).


인증 정리 (방향별)
==================

.. list-table::
   :header-rows: 1
   :widths: 50 28 22

   * - 동작
     - 인증
     - 비고
   * - GitHub → Weblate (Webhook 통보)
     - 불필요
     - 공개 엔드포인트
   * - Weblate가 저장소 읽기(pull)
     - 불필요
     - 저장소가 공개
   * - Weblate → GitHub (push / PR 생성)
     - **PAT 필요**
     - 서버 환경변수에 설정
   * - GitHub Actions의 카탈로그 커밋
     - 기본 ``GITHUB_TOKEN``
     - 별도 시크릿 없음


컴포넌트 설정 요약
==================

Weblate 컴포넌트(``infra-cloud-kr / docs``)의 핵심 설정입니다.

.. list-table::
   :header-rows: 1
   :widths: 35 65

   * - 항목
     - 값
   * - 원문 언어
     - 한국어 (``ko``)
   * - 번역 언어
     - 영어 (``en``)
   * - 파일 형식
     - gettext PO (bilingual)
   * - File mask
     - ``source/locales/*/LC_MESSAGES/docs.po``
   * - 버전 관리
     - ``github`` (PR 방식), merge style: rebase
   * - Push 브랜치
     - ``weblate-translations``


메인테이너 메모 (문제 해결)
===========================

.. note::

   - **원문을 바꿨는데 Weblate에 안 보일 때** : ①의 카탈로그 재생성(Action)이 돌아
     ``docs.po``\가 갱신됐는지, Webhook이 전달됐는지 확인합니다. 필요하면 Weblate UI에서
     수동 pull을 합니다.
   - **filemask 등을 바꾼 뒤 재스캔이 안 될 때** : Weblate가 "already parsed, skipping"
     으로 건너뛸 수 있습니다. 서버에서
     ``weblate loadpo --force --foreground infra-cloud-kr/docs`` 로 강제 재로딩합니다.
   - **rebase 충돌** : Weblate 로컬에 남은 커밋과 원격이 어긋나면 *Repository* 의
     ``reset`` 으로 원격 상태에 맞춥니다(로컬의 미반영 변경은 사라지므로 주의).


함께 보기
=========

- :ref:`translation-guide` — 실제 번역 방법(멘티용)
- `Weblate 연속 현지화 문서 <https://docs.weblate.org/en/latest/admin/continuous.html>`_
- `Sphinx 국제화 문서 <https://www.sphinx-doc.org/en/master/usage/advanced/intl.html>`_
