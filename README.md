# infra-cloud-kr

OpenInfra(OpenStack)와 Cloud Native(Kubernetes/CNCF) 생태계를 잇는 한국 커뮤니티 랜딩 페이지입니다.

Sphinx + reStructuredText(RST)로 빌드되며, GitHub Pages를 통해 호스팅됩니다.

## 프로젝트 구조

```
infra-cloud-kr.github.io/
├── source/
│   ├── conf.py            # Sphinx 설정 파일
│   ├── index.rst           # 메인 랜딩 페이지
│   └── _static/
│       └── custom.css      # 커스텀 스타일시트
├── tests/                  # 테스트 코드
├── .github/
│   └── workflows/
│       └── deploy.yml      # GitHub Pages 배포 워크플로우
├── Makefile                # Linux/macOS 빌드 명령
├── make.bat                # Windows 빌드 명령
├── requirements.txt        # Python 의존성
└── LICENSE                 # Apache License 2.0
```

## 로컬 개발 환경 설정

### 사전 요구사항

- Python 3.10 이상

### 설치

```bash
# 저장소 클론
git clone https://github.com/infra-cloud-kr/infra-cloud-kr.github.io.git
cd infra-cloud-kr.github.io

# 가상 환경 생성 및 활성화
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate

# 의존성 설치
pip install -r requirements.txt
```

### 빌드 및 미리보기

```bash
# HTML 빌드
make html

# Windows 환경
make.bat html

# 빌드 결과물 확인
# _build/html/index.html 파일을 브라우저에서 열어 확인합니다.
```

빌드 결과물은 `_build/html/` 디렉토리에 생성됩니다.

### 빌드 초기화

```bash
make clean
```

## 배포

`main` 브랜치에 push하면 GitHub Actions가 자동으로 빌드 및 배포를 수행합니다.

- 빌드: `sphinx-build -W -b html source _build/html` (`-W` 플래그로 경고를 오류로 처리)
- 배포: GitHub Pages (`infra-cloud-kr.github.io`)

## 기여 방법

1. 이 저장소를 Fork합니다.
2. 새 브랜치를 생성합니다: `git checkout -b feature/my-change`
3. 변경 사항을 커밋합니다: `git commit -m "설명"`
4. 브랜치에 Push합니다: `git push origin feature/my-change`
5. Pull Request를 생성합니다.

### 콘텐츠 수정

랜딩 페이지 콘텐츠는 `source/index.rst` 파일을 편집하여 수정합니다. RST 문법에 대한 자세한 내용은 [Sphinx reStructuredText Primer](https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html)를 참고하세요.

### 스타일 수정

커스텀 스타일은 `source/_static/custom.css` 파일에서 관리합니다.

## 번역 (i18n)

이 문서는 한국어가 원문이며, Weblate([translate.openinfra.kr](https://translate.openinfra.kr))를 통해 영어로 번역됩니다.

- 원문 언어: 한국어(`ko`)
- 번역 언어: 영어(`en`)
- 번역 파일: `source/locales/<lang>/LC_MESSAGES/*.po` (gettext 형식, Weblate가 읽고 씁니다)

### 번역 워크플로우

1. 번역가는 [translate.openinfra.kr](https://translate.openinfra.kr)에서 문장을 번역합니다.
2. Weblate가 번역된 `.po` 파일을 Pull Request로 이 저장소에 제출합니다.
3. PR이 `main`에 머지되면 GitHub Actions가 한국어/영어 사이트를 함께 빌드·배포합니다.
   - 한국어: `https://infra-cloud-kr.github.io/`
   - 영어: `https://infra-cloud-kr.github.io/en/`

번역되지 않은 문장은 원문(한국어)으로 표시됩니다.

### 원문 수정 시 번역 파일 동기화

`source/*.rst` 원문을 수정한 뒤에는 번역 대상 문자열(`.po`)을 갱신해야 합니다.

```bash
# .pot 추출 + .po 갱신 (en)
make update-po

# 변경된 .po 파일을 커밋
git add source/locales
git commit -m "i18n: update translation catalogs"
```

이후 Weblate가 새로 추가된 문장을 자동으로 인식합니다.

### 영어 빌드 미리보기

```bash
make html-en
# _build/html/en/index.html 을 브라우저에서 확인
```

## 라이선스

Apache License 2.0 — 자세한 내용은 [LICENSE](LICENSE) 파일을 참고하세요.
