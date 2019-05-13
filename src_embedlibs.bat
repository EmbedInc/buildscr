@echo off
rem
rem   SRC_EMBEDLIBS lnkfile
rem
rem   Add commands to the linker command file LNKFILE to include all the Embed
rem   Inc libraries for static linking.
rem
rem   By default, all the .LIB files in (cog)lib will be listed.  When
rem   the environment variable USE_DLLS is "true", then all the .LIB files in
rem   (cog)dll will be listed.
rem
setlocal
call treename_var "%~1" linkf
if "%use_dlls%"=="true" (
    call treename_var "(cog)dll" libdir
  ) else (
    call treename_var "(cog)lib" libdir
  )
echo /libpath:%libdir% >>"%linkf%"
cd /d "%libdir%"
for %%a in (*.lib) do echo %%~a >>"%linkf%"
