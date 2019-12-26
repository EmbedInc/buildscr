@echo off
rem
rem   SRC_INSALL <src dir lnam> <.INSALL.PAS generic name>
rem
rem   Build the .INSALL.PAS file.  This produces the C .H include file and
rem   leaves it in the SRC directory.
rem
rem   For the <name>.INSALL.PAS file, the contents of the <name>.INS.PAS file
rem   will be exported to the <name>.H file.
rem
if exist %2.h del %2.h
call src_get %1 %2.insall.pas
call src_get %1 %2.ins.pas
sst %2.insall.pas -show_unused 0 -ins %2.ins.pas
rename %2.insall.c %2.h
