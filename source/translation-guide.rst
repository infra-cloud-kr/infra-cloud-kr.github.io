.. _translation-guide:

==========================
Weblate 번역 가이드
==========================

이 문서는 **멘토링 참가자(멘티)** 가 번역 플랫폼 `Weblate <https://translate.openinfra.kr>`_ 에서
계정을 발급받고 문서를 번역하는 전체 과정을 안내합니다.

infra-cloud-kr 문서는 **한국어가 원문**\이며, Weblate를 통해 **영어로 번역**\됩니다.
여러분이 Weblate에서 번역한 내용은 자동으로 GitHub Pull Request로 만들어지고,
검토 후 병합되면 영어 문서 사이트(``/en/``)에 반영됩니다.

.. contents:: 목차
   :local:
   :depth: 2

한눈에 보는 전체 흐름
=====================

.. code-block:: text

   계정 생성 → 이메일 인증 → 로그인
        → 프로젝트(infra-cloud-kr) → 컴포넌트(docs) → English 선택
        → 번역 편집기에서 한 문장씩 번역 & 저장
        → (Weblate가 자동으로) GitHub PR 생성
        → 멘토 검토 후 병합 → 영어 사이트에 반영

- 번역 사이트: https://translate.openinfra.kr
- 대상 프로젝트: **infra-cloud-kr / docs**
- 번역 언어: 한국어(원문) → **English(영어)**


1. 계정 만들기
==============

#. 브라우저에서 https://translate.openinfra.kr/accounts/register/ 에 접속합니다.
#. 다음 정보를 입력합니다.

   - **E-mail**: 인증 메일을 받을 수 있는 본인 이메일 주소
   - **Username**: 로그인에 사용할 사용자 이름(영문)
   - **Full name**: 표시될 이름 (기여자 이름으로 기록됩니다)
   - **I'm not a robot**: 사람 확인(캡차)을 완료합니다.

#. **Register** 버튼을 누릅니다.

.. figure:: /_static/img/weblate/01-register.png
   :alt: Weblate 회원가입 화면
   :width: 100%

   회원가입 화면. 이메일, 사용자 이름, 실명을 입력하고 사람 확인 후 *Register* 를 누릅니다.

.. note::

   가입 직후 입력한 이메일로 **인증 메일**\이 발송됩니다. 메일에 포함된 링크를 클릭해야
   계정이 활성화됩니다. 메일이 보이지 않으면 스팸함도 확인해 주세요.

.. tip::

   GitHub 계정이 있다면, 회원가입 대신 로그인 화면의 **소셜 로그인**\을 사용할 수도 있습니다
   (멘토가 안내한 경우).


2. 로그인
=========

이메일 인증을 마쳤다면 https://translate.openinfra.kr/accounts/login/ 에서 로그인합니다.

.. figure:: /_static/img/weblate/02-login.png
   :alt: Weblate 로그인 화면
   :width: 100%

   로그인 화면. 가입할 때 만든 사용자 이름(또는 이메일)과 비밀번호를 입력합니다.


3. 번역할 문서 찾기
===================

#. 상단 메뉴 **Projects** → **infra-cloud-kr** 를 선택합니다.
   (바로가기: https://translate.openinfra.kr/projects/infra-cloud-kr/)

   .. figure:: /_static/img/weblate/03-project.png
      :alt: infra-cloud-kr 프로젝트 화면
      :width: 100%

      infra-cloud-kr 프로젝트 화면.

#. 프로젝트 안의 **docs** 컴포넌트를 선택합니다.

   .. figure:: /_static/img/weblate/04-component.png
      :alt: docs 컴포넌트 화면
      :width: 100%

      docs 컴포넌트. 언어 목록에서 번역할 언어를 고릅니다.

#. 언어 목록에서 **English** 를 선택하면 번역 현황이 나타납니다.
   여기서 진행률과 "아직 번역되지 않은 문자열" 수를 볼 수 있습니다.

   .. figure:: /_static/img/weblate/05-language.png
      :alt: English 번역 현황 화면
      :width: 100%

      English 번역 현황. **Translate** 버튼을 누르면 편집기로 이동합니다.
      *Unfinished strings* 를 누르면 아직 번역이 필요한 문장만 모아서 볼 수 있습니다.

.. tip::

   처음 시작할 때는 **Unfinished strings**\(미완료 문자열)의 **Translate** 를 누르는 것을
   추천합니다. 번역이 필요한 문장만 순서대로 보여 줍니다.


4. 번역 편집기 사용법
=====================

**Translate** 를 누르면 아래와 같은 번역 편집기가 열립니다.

.. figure:: /_static/img/weblate/06-editor.png
   :alt: Weblate 번역 편집기
   :width: 100%

   번역 편집기 화면. 위쪽에 한국어 원문, 아래쪽에 영어 입력칸이 있습니다.

편집기의 주요 영역은 다음과 같습니다.

- **Korean** (위) : 번역해야 할 **원문(한국어)** 입니다.
- **English** (아래) : 여기에 **영어 번역**\을 입력합니다.
- **상단 화살표/페이지(1 / 23)** : 문장 사이를 이동합니다.
- **Glossary** (오른쪽) : 용어집. 일관된 번역어가 등록되어 있으면 여기에 표시됩니다.
- **Nearby strings** (아래) : 앞뒤 문맥의 문장들. 흐름을 파악하는 데 도움이 됩니다.
- **Other languages / History** : 다른 언어 번역과 수정 이력을 볼 수 있습니다.

번역을 입력한 뒤, 아래 버튼으로 저장합니다.

- **Save and continue** : 저장하고 다음 문장으로 이동합니다. (가장 많이 사용)
- **Save and stay** : 저장하고 현재 문장에 머무릅니다.
- **Suggest** : 바로 확정하지 않고 **제안**\만 남깁니다. (검토가 필요할 때)
- **Skip** : 저장하지 않고 건너뜁니다.

.. important::

   번역을 **저장하려면 로그인**\이 되어 있어야 합니다. 로그인하지 않으면 편집기 아래에
   "Sign in to save translations." 라는 안내가 보이며 저장 버튼이 동작하지 않습니다.


5. 번역할 때 꼭 지켜 주세요 (마크업 보존)
==========================================

원문에는 reStructuredText(RST) 서식이 섞여 있습니다. **서식 기호는 그대로 두고
글자만 번역**\해야 문서가 깨지지 않습니다.

**예시 1 — 굵게 표시(별표 두 개)는 유지합니다.**

.. code-block:: rst

   원문 :  **OpenInfra** 와 Cloud Native
   번역 :  **OpenInfra** and Cloud Native

**예시 2 — 링크 문법과 URL은 그대로 두고, 보이는 텍스트만 번역합니다.**

.. code-block:: rst

   원문 :  `Linux Foundation <https://www.linuxfoundation.org/>`_ 산하 프로젝트
   번역 :  Projects under the `Linux Foundation <https://www.linuxfoundation.org/>`_

**예시 3 — 제품명은 번역하지 않고, 조사/접속사만 번역합니다.**

.. code-block:: rst

   원문 :  OpenStack과 Kubernetes
   번역 :  OpenStack and Kubernetes

.. warning::

   - 별표(``*``), 백틱, 밑줄(``_``) 같은 **서식 기호를 지우거나 추가하지 마세요.**
   - URL, 제품명(OpenStack, Kubernetes, CNCF 등)은 **번역하지 않습니다.**
   - 문제가 있으면 Weblate가 빨간색 **Checks(검사)** 경고로 알려 줍니다. 경고가 뜨면
     원문과 기호가 같은지 다시 확인해 주세요.


6. 알아두면 좋은 기능
=====================

- **Filters / 검색** : 특정 단어가 들어간 문장, 미번역 문장 등으로 걸러서 볼 수 있습니다.
- **Zen 모드** : 여러 문장을 한 화면에서 빠르게 번역하는 모드입니다.
- **Automatic suggestions** : 기계 번역/번역 메모리 제안을 참고용으로 볼 수 있습니다
   (그대로 쓰지 말고 반드시 다듬어 주세요).
- **History** : 누가 언제 어떻게 번역했는지 이력을 확인할 수 있습니다.
- **UI 언어 변경** : 오른쪽 위 메뉴에서 Weblate 화면 자체의 언어를 한국어로 바꿀 수 있습니다.


7. 내 번역은 어떻게 사이트에 반영되나요?
=========================================

여러분이 저장한 번역은 다음 과정을 거쳐 문서 사이트에 반영됩니다. **이 과정은 자동**\이므로
번역가가 직접 Git을 다룰 필요는 없습니다.

#. 번역을 저장하면 Weblate가 내부적으로 변경 내용을 모읍니다.
#. Weblate가 GitHub 저장소로 **Pull Request(PR)** 를 자동 생성/갱신합니다.
#. **멘토(메인테이너)** 가 PR을 검토하고 병합합니다.
#. 병합되면 GitHub Actions가 영어 문서를 빌드하여 배포합니다.

   - 한국어 원문: https://infra-cloud-kr.github.io/
   - 영어 번역: https://infra-cloud-kr.github.io/en/

.. note::

   번역이 아직 안 된 문장은 영어 사이트에서 **원문(한국어)** 그대로 표시됩니다.
   번역이 쌓일수록 영어 사이트가 점점 영어로 채워집니다.


8. 자주 묻는 질문
=================

**Q. 번역을 잘못 저장했어요.**
   다시 그 문장으로 이동해 올바른 내용으로 저장하면 됩니다. 이전 내용은 *History* 에
   남아 있어 언제든 확인할 수 있습니다.

**Q. 어떤 문장부터 번역해야 하나요?**
   English 현황 화면에서 **Unfinished strings → Translate** 로 시작하세요.
   순서대로 번역하면 누락 없이 진행할 수 있습니다.

**Q. 번역 용어가 헷갈려요.**
   오른쪽 **Glossary**\(용어집)를 참고하고, 멘토와 상의해 통일된 용어를 사용하세요.

**Q. 내 번역이 사이트에 바로 안 보여요.**
   번역 → PR → 검토/병합 → 배포 단계를 거치기 때문에 시간이 걸립니다.
   병합 전까지는 사이트에 반영되지 않습니다.


도움이 필요하면
===============

- 번역 중 막히는 부분은 **멘토에게 문의**\하세요.
- Weblate 사용법은 공식 문서도 참고할 수 있습니다:
  `Translating using Weblate <https://docs.weblate.org/en/latest/user/translating.html>`_
