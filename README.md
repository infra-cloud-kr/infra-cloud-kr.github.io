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

## 라이선스

Apache License 2.0 — 자세한 내용은 [LICENSE](LICENSE) 파일을 참고하세요.
