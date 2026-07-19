# Minimal makefile for Sphinx documentation

SPHINXBUILD   = sphinx-build
SOURCEDIR     = source
BUILDDIR      = _build

LANGUAGES     = en

.PHONY: help html html-en clean gettext update-po

help:
	@echo "Usage:"
	@echo "  make html        Build HTML documentation (Korean)"
	@echo "  make html-en     Build HTML documentation (English)"
	@echo "  make gettext     Extract translatable strings to .pot templates"
	@echo "  make update-po   Update .po files from .pot (run after editing source)"
	@echo "  make clean       Remove build output"

html:
	$(SPHINXBUILD) -b html $(SOURCEDIR) $(BUILDDIR)/html

html-en:
	$(SPHINXBUILD) -b html -D language=en $(SOURCEDIR) $(BUILDDIR)/html/en

gettext:
	$(SPHINXBUILD) -b gettext $(SOURCEDIR) $(BUILDDIR)/gettext

update-po: gettext
	sphinx-intl update -p $(BUILDDIR)/gettext -d $(SOURCEDIR)/locales $(foreach lang,$(LANGUAGES),-l $(lang))

clean:
	rm -rf $(BUILDDIR)
