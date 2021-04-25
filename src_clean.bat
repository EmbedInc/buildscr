@echo off
rem
rem   SRC_CLEAN <src dir lnam>
rem
rem   Delete all the files in the indicated SRC directory that can be
rem   re-created.  This script can be run in a SRC directory to clean just that
rem   directory, on in the top level SRC directory to clean all SRC
rem   subdirectories.
rem
setlocal
call godir (cog)src
attrib -h -r /s
if not "%~1"=="" cd "%~1"

for /R %%a in (.vs) do (if exist "%%a" delt "%%a")

for /R %%a in (*.asm *.aspic *.lkr *.obj) do (echo Deleting %%a & del %%a)
for /R %%a in (*.pas *.cog *.c *.obj) do (echo Deleting %%a & del %%a)
for /R %%a in (*.cod *.inc *.O *.out *.lst) do (echo Deleting %%a & del %%a)
for /R %%a in (*.lib *.err *.exe *.linkpic) do (echo Deleting %%a & del %%a)
for /R %%a in (*.mlist *.msg *.pdb __*) do (echo Deleting %%a & del %%a)
for /R %%a in (*.ekbd *_font *.dspic *.linkp30) do (echo Deleting %%a & del %%a)
for /R %%a in (*.s *.as *.cof *.l30cmd) do (echo Deleting %%a & del %%a)
for /R %%a in (*.h *.env *.opt *.lnk) do (echo Deleting %%a & del %%a)
for /R %%a in (*.c18 *.h18 *.h30 *.c30 *.i) do (echo Deleting %%a & del %%a)
for /R %%a in (*.exp *.pdb *.dll *.gif) do (echo Deleting %%a & del %%a)
for /R %%a in (*.jpg *.picname *.sl *.csv) do (echo Deleting %%a & del %%a)
for /R %%a in (*.libp30 *.bat *.xc16 *.escr) do (echo Deleting %%a & del %%a)
for /R %%a in (*.suo *.gld *.escr *.es) do (echo Deleting %%a & del %%a)
for /R %%a in (*.elf *.txt *.seq *.sln) do (echo Deleting %%a & del %%a)
for /R %%a in (*.suo *.chp *.@) do (echo Deleting %%a & del %%a)
