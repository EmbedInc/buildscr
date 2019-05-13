@echo off
rem
rem   SRC_EXP30 <src dir lnam> <dsPIC exeuctable gnam>
rem
rem   Build a dsPIC executable.  The first argument is the leafname
rem   of the source directory.  The second is the generic name of the
rem   dsPIC executable.  The executable will be built in the appropriate
rem   SRC directory.
rem
setlocal

echo Building project library
call src_libp30 %1 %2

if exist %2.hex del %2.hex
if exist %2.map del %2.map
if exist %2.cof del %2.cof
if exist %2.elf del %2.elf
call src_get %1 %2.linkp30

call treename_var (cog)src/%1/%2.libp30 libs
set comargs=-omf=elf -o %2.elf
set comargs=%comargs% -T %2.linkp30

if "%using_c30%"=="true" goto :c30libs
if "%using_xc16%"=="true" goto :xc16libs
rem
rem   Not using C.
rem
set comargs=%comargs% %2_strt.o
goto :done_c
rem
rem   Using C30
rem
:c30libs
set libs=%libs% "%C30Dir%\lib\libpic30-elf.a"
set libs=%libs% "%C30Dir%\lib\libc-elf.a"
set libs=%libs% "%C30Dir%\lib\libm-elf.a"
goto :done_c
rem
rem   Using XC16
rem
:xc16libs
set libs=%libs% "%XC16Dir%\lib\libpic30-elf.a"
set libs=%libs% "%XC16Dir%\lib\libc-elf.a"
set libs=%libs% "%XC16Dir%\lib\libfastm-elf.a"
:done_c

set comargs=%comargs% -Map %2.map --stackguard=0

echo Linking
rem echo "%dspicdir%\bin\xc16-ld" %comargs% -( %libs% -)
"%dspicdir%\bin\xc16-ld" %comargs% -( %libs% -)
if exist %2.elf "%dspicdir%\bin\xc16-bin2hex" -omf=elf %2.elf
if not exist %2.hex prepic -in "(cog)source/pic/unseq.aspic" -out /temp/unseq -s srcdir %1 -s fwname %2
if not exist %2.hex exit /b 3
