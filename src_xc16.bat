@echo off
rem
rem   SRC_XC16 <src dir lnam> <.XC16 file gnam>
rem
rem   Build a dsPIC C source file using the XC16 compiler.  The first argument
rem   is the leafname of the source directory.  The second is the generic name
rem   of the ource file.  The file will be copied into the approriate SRC
rem   directory and compiled.
rem
rem   The relocatable binary output file will have a "_c" added to its name
rem   before the ".o" suffix.  This allows having XC16 and ASM30 modules with
rem   the same names.  For example the input file "mctrl_pwm.xc16" will result
rem   in the output file "mctrl_pwm_c.o".
rem
setlocal
call extpath_var mplab/ccomp16.exe ccomp

echo %2.xc16
call src_get_c "%~1" %2.xc16
if exist %2.c del %2.c
rename %2.xc16 %2.c
if exist %2_c.o del %2_c.o

set comargs=-c
set comargs=%comargs% -mcpu=%pictype%
set comargs=%comargs% -omf=elf
set comargs=%comargs% -fomit-frame-pointer
set comargs=%comargs% -mlarge-code -mlarge-data
set comargs=%comargs% -mtext=.c_%2
set comargs=%comargs% -Wall
set comargs=%comargs% -mno-eds-warn
set comargs=%comargs% -no-legacy-libc

if "%debug_icd%"=="true" goto :debugging

rem
rem   Production build.
rem
"%ccomp%" %comargs% -O3 -Os %2.c -o %2_c.o
goto :done_compile

rem
rem   Debug build
rem
:debugging
"%ccomp%" %comargs% -g %2.c -o %2_c.o

:done_compile
