@ECHO OFF

pushd %~dp0

set SPHINXBUILD=sphinx-build
set SOURCEDIR=source
set BUILDDIR=_build

if "%1" == "" goto help
if "%1" == "help" goto help
if "%1" == "html" goto html
if "%1" == "clean" goto clean

goto help

:help
echo Usage:
echo   make html    Build HTML documentation
echo   make clean   Remove build output
goto end

:html
%SPHINXBUILD% -b html %SOURCEDIR% %BUILDDIR%/html
goto end

:clean
rmdir /s /q %BUILDDIR%
goto end

:end
popd
