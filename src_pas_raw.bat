@echo off
rem
rem   SRC_PAS_RAW <source file name> [-dbg]
rem
rem   Compile the Pascal language source file to produce an object file.
rem   The source file name argument must not contain the .PAS suffix.
rem
rem   The -dbg option causes the source file to be compiled for debugging.
rem   Otherwise, the source file is compiled with full optimization.
rem
setlocal

if exist %1.obj del %1.obj
if exist %1.c del %1.c

set dbglev=0
set arg2=
set dbg=
if "%2"=="-dbg" set dbglev=1
if "%2"=="-dbg" set dbg=-dbg
if not "%2"=="-dbg" set arg2=%2

sst %1.pas -out %1 -local_ins -debug %dbglev% %arg2% %3 %4 %5 %6 %7 %8 %9
if errorlevel 1 goto :eof
call src_c_raw %1 %dbg%
if errorlevel 1 goto :eof

if "%2"=="-dbg" goto :dbg
if not "%dbg_source%"=="" goto :dbg
if exist %1.c del %1.c
:dbg
