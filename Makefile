# Minimal makefile for Sphinx documentation

SPHINXBUILD   = sphinx-build
SOURCEDIR     = source
BUILDDIR      = _build

.PHONY: help html clean

help:
	@echo "Usage:"
	@echo "  make html    Build HTML documentation"
	@echo "  make clean   Remove build output"

html:
	$(SPHINXBUILD) -b html $(SOURCEDIR) $(BUILDDIR)/html

clean:
	rm -rf $(BUILDDIR)
