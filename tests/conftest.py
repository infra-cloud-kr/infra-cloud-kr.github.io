"""공통 테스트 픽스처: 빌드된 HTML 파싱."""

import pathlib

import pytest
from bs4 import BeautifulSoup

BUILD_HTML_DIR = pathlib.Path(__file__).resolve().parent.parent / "_build" / "html"
INDEX_HTML = BUILD_HTML_DIR / "index.html"


@pytest.fixture(scope="session")
def built_index_html() -> BeautifulSoup:
    """빌드된 index.html을 BeautifulSoup으로 파싱하여 반환한다.

    세션 스코프로 한 번만 파싱하여 모든 테스트에서 재사용한다.
    빌드가 되어 있지 않으면 테스트를 건너뛴다.
    """
    if not INDEX_HTML.exists():
        pytest.skip(
            f"빌드된 HTML이 없습니다. 먼저 'make html'을 실행하세요: {INDEX_HTML}"
        )

    html_content = INDEX_HTML.read_text(encoding="utf-8")
    return BeautifulSoup(html_content, "html.parser")
