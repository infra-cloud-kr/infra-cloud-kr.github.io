# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------

project = 'infra-cloud-kr'
author = 'infra-cloud-kr community'
copyright = '2025, infra-cloud-kr community'

# -- General configuration ---------------------------------------------------

extensions = []

language = 'ko'

exclude_patterns = []

# -- Options for HTML output -------------------------------------------------

html_theme = 'furo'

html_title = 'infra-cloud-kr - 한국 인프라 클라우드 커뮤니티'
html_short_title = 'infra-cloud-kr'

html_static_path = ['_static']
html_css_files = ['custom.css']

# -- SEO and meta description ------------------------------------------------

html_meta = {
    'description': 'infra-cloud-kr은 Linux Foundation 산하 OpenInfra(OpenStack)와 Cloud Native(Kubernetes/CNCF) 생태계를 잇는 한국 커뮤니티입니다.',
    'keywords': 'infra-cloud-kr, OpenStack, Kubernetes, CNCF, OpenInfra, Cloud Native, Linux Foundation, 한국 클라우드 커뮤니티',
}
