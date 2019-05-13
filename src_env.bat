@echo off
rem
rem   SRC_ENV <src dir lnam> <environment file name>
rem
rem   Install the indicated environment file as part of a build.  The first
rem   argument is the leafname of the source directory.  The second is the
rem   name of the environment file to install.
rem
call src_get %1 %2

if "%dbg_promote%"=="true" goto cp_global
if not defined dbg_source goto cp_global

rem   Debug build.
rem
copya %2 ~/env_dbg/%2
goto alldone

rem   Global build.
rem
:cp_global
copya %2 (cog)env/%2

rem   Common code after specific build type case.
rem
:alldone
if exist %2 del %2
