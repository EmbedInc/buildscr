@echo off
rem
rem   SRC_GETBASE
rem
rem   Get all the source files required to access the minimum base libraries.
rem   All Pascal source code using the Embed software requires the base
rem   libraries.
rem
rem   This script is usually called from the BUILD_PASINIT script for the
rem   particular library.  It assumes that BUILD_VARS for the particular library
rem   has already been called.
rem
call src_go %srcdir%
call src_getfrom sys base.ins.pas
call src_getfrom sys sys.ins.pas
call src_getfrom sys sys_sys.ins.pas
call src_getfrom util util.ins.pas
call src_getfrom string string.ins.pas
call src_getfrom file file.ins.pas
