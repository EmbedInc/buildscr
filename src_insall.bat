@echo off
rem
rem   SRC_INSALL <src dir lnam> <.INSALL.PAS generic name>
rem
rem   Build the .INSALL.PAS file.  This produces the C .H include file and
rem   leaves it in the SRC directory.  It also puts public and private include
rem   files for the library into the SRC directory.
rem
call src_get %1 %2.ins.pas
call src_get %1 %22.ins.pas

if exist %2.h del %2.h
call src_get %1 %2.insall.pas
sst %2.insall.pas -show_unused 0 -local_ins -ins %2.ins.pas
rename %2.insall.c %2.h
