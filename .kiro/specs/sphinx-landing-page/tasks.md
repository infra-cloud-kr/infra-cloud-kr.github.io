# 구현 계획: sphinx-landing-page

## 개요

infra-cloud-kr 커뮤니티 정적 랜딩 페이지를 Sphinx + RST로 구축한다. Sphinx 프로젝트 초기화, 콘텐츠 작성, furo 테마 적용, GitHub Actions CI/CD 파이프라인 구성, 테스트 작성 순서로 진행한다. 각 단계는 이전 단계의 결과물 위에 점진적으로 구축된다.

## Tasks

- [x] 1. Sphinx 프로젝트 구조 및 빌드 환경 설정
  - [x] 1.1 프로젝트 기본 파일 생성
    - `requirements.txt` 생성: `sphinx`, `furo`, `pytest`, `hypothesis`, `beautifulsoup4` 의존성 명시
    - `Makefile` 생성: `sphinx-build -b html source _build/html` 빌드 명령 정의
    - `make.bat` 생성: Windows 환경용 빌드 스크립트
    - `.gitignore` 생성: `_build/`, `__pycache__/`, `.venv/` 등 제외 패턴 추가
    - _Requirements: 1.3, 1.4, 6.1, 6.2_

  - [x] 1.2 Sphinx 설정 파일(`source/conf.py`) 작성
    - `project = 'infra-cloud-kr'`, `language = 'ko'` 설정
    - `html_theme = 'furo'` 테마 적용
    - `html_static_path = ['_static']`, `html_css_files = ['custom.css']` 설정
    - `html_title` 및 메타데이터 설정
    - _Requirements: 1.1, 3.1, 3.3, 7.1, 7.2_

  - [x] 1.3 커스텀 CSS 파일 생성
    - `source/_static/custom.css` 생성: 히어로 섹션, 섹션 간격, 링크 스타일 등 기본 커스텀 스타일 정의
    - _Requirements: 3.4_

- [x] 2. 랜딩 페이지 콘텐츠 작성
  - [x] 2.1 메인 페이지(`source/index.rst`) 작성
    - 히어로 섹션: 커뮤니티 이름("infra-cloud-kr")과 소개 문구
    - 미션 섹션: OpenInfra(OpenStack) × Cloud Native(Kubernetes/CNCF) 연결 미션 설명
    - Linux Foundation 섹션: LF 산하 프로젝트임을 명시
    - 참여 방법 섹션: GitHub 조직 링크, 소셜 미디어 등 안내
    - 시맨틱 헤딩 계층 준수 (`h1` → `h2` → `h3` 순서)
    - 모든 이미지에 `alt` 대체 텍스트 포함
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 7.3, 7.4_

  - [x] 2.2 네비게이션 구성
    - `index.rst`에 `.. contents::` 디렉티브 또는 furo 테마의 사이드바 네비게이션 활용
    - 각 섹션에 앵커 ID가 자동 생성되도록 RST 섹션 헤딩 구성
    - _Requirements: 4.1, 4.2, 4.3_

- [x] 3. 체크포인트 - 로컬 빌드 검증
  - `make html` 명령으로 로컬 빌드 성공 확인, 문제가 있으면 사용자에게 질문한다.

- [x] 4. GitHub Actions 배포 워크플로우 구성
  - [x] 4.1 배포 워크플로우 파일 생성
    - `.github/workflows/deploy.yml` 생성
    - `main` 브랜치 push 트리거 설정
    - Python 환경 설정, 의존성 설치, `make html` 빌드 단계 구성
    - `actions/deploy-pages@v4`를 사용한 GitHub Pages 배포 단계 구성
    - 빌드 실패 시 배포 중단 로직 (CI에서 `-W` 플래그 사용)
    - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [x] 5. README 및 개발 가이드 작성
  - [x] 5.1 README.md 작성
    - Python 가상 환경 설정 및 의존성 설치 절차
    - 로컬 빌드 및 미리보기 방법 (`make html`)
    - 프로젝트 구조 설명
    - 기여 방법 안내
    - _Requirements: 6.3, 6.4_

- [-] 6. 테스트 작성
  - [x] 6.1 테스트 환경 설정
    - `tests/` 디렉토리 생성, `tests/conftest.py`에 빌드된 HTML 파싱 픽스처 구성
    - BeautifulSoup4를 사용하여 `_build/html/index.html` 파싱하는 공통 픽스처 정의
    - _Requirements: 1.1, 1.2_

  - [ ]* 6.2 프로젝트 구조 단위 테스트 작성
    - 필수 파일 존재 확인: `source/conf.py`, `source/index.rst`, `requirements.txt`, `Makefile`
    - _Requirements: 1.1, 1.2, 1.3, 1.4_

  - [ ]* 6.3 conf.py 설정 단위 테스트 작성
    - `language='ko'`, `html_theme='furo'`, `html_css_files` 설정 검증
    - _Requirements: 3.1, 3.3, 7.1_

  - [ ]* 6.4 콘텐츠 및 SEO 단위 테스트 작성
    - 빌드된 HTML에서 히어로, 미션, 참여 방법, 푸터 섹션 존재 확인
    - `<title>` 태그, `lang="ko"` 속성, meta description 존재 확인
    - 커스텀 CSS 파일 링크 포함 확인
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.6, 7.1, 7.2_

  - [ ]* 6.5 GitHub Actions 워크플로우 단위 테스트 작성
    - `deploy.yml` 파일 존재 확인
    - main 브랜치 트리거 설정 확인
    - _Requirements: 5.1, 5.2_

  - [ ]* 6.6 Property 1 속성 기반 테스트: 네비게이션 앵커 무결성
    - **Property 1: 네비게이션 앵커 무결성**
    - 빌드된 HTML 내 모든 내부 앵커 링크(`href="#..."`)의 대상 ID가 페이지 내에 존재하는지 검증
    - Hypothesis를 사용하여 앵커 링크 샘플링 및 검증
    - **Validates: Requirements 4.2**

  - [ ]* 6.7 Property 2 속성 기반 테스트: 이미지 대체 텍스트 존재
    - **Property 2: 이미지 대체 텍스트 존재**
    - 빌드된 HTML 내 모든 `<img>` 태그에 비어있지 않은 `alt` 속성이 존재하는지 검증
    - **Validates: Requirements 7.3**

  - [ ]* 6.8 Property 3 속성 기반 테스트: 시맨틱 헤딩 계층 준수
    - **Property 3: 시맨틱 헤딩 계층 준수**
    - 빌드된 HTML 내 헤딩 태그 시퀀스(`h1`~`h6`)가 레벨을 1단계 이상 건너뛰지 않는지 검증
    - **Validates: Requirements 7.4**

- [x] 7. 최종 체크포인트 - 전체 테스트 통과 확인
  - `pytest tests/ -v` 실행하여 모든 테스트 통과 확인, 문제가 있으면 사용자에게 질문한다.

## 참고

- `*` 표시된 태스크는 선택 사항이며, 빠른 MVP를 위해 건너뛸 수 있다
- 각 태스크는 추적 가능성을 위해 특정 요구사항을 참조한다
- 체크포인트를 통해 점진적 검증을 수행한다
- 속성 기반 테스트는 보편적 정확성 속성을 검증한다
- 단위 테스트는 특정 예시와 엣지 케이스를 검증한다
