@echo off
rem
rem   SRC_MSG <src dir lnam> <message file name>
rem
rem   Install the indicated message file as part of a build.  The first
rem   argument is the leafname of the source directory.  The second is the
rem   generic name of the message file to install.
rem

call src_get %1 %2.msg

if "%dbg_promote%"=="true" goto cp_global
if not defined dbg_source goto cp_global

copya %2.msg ~/env_dbg/%2.msg
goto alldone

:cp_global
copya %2.msg (cog)env/%2.msg

:alldone
if exist %2.msg del %2.msg
