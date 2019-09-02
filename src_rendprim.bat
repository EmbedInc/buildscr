@echo off
rem
rem   SRC_RENDPRIM <src dir lnam> <.PAS file name> [-dbg]
rem
rem   Build the RENDlib graphics primitive from its Pascal source file.  RENDlib
rem   graphics primitives require a custom include file be created, which is
rem   then referenced by the source module of the primitive.
rem
call src_get "%~1" "%~2.pas" 3 5 7 9 11 40 41
make_rend_prim_ins "%~2.pas"
call src_pas_raw %~2 %~3
