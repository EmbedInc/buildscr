@echo off
rem
rem   SRC_BUILDDATE <src dir lnam>
rem
rem   Creates the Pascal BUILDDATE.INS.PAS file that contains constants
rem   indicating the current time.  This can be included by programs to know
rem   their build date and time.
rem
call src_go "%~1"
call src_getfrom sys makedate.escr
escr makedate
