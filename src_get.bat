@echo off
rem
rem   SRC_GET <src dir lname> [<subdir>] <source file name> [tab1 ... tabN]
rem
rem   Copy the source file from its SOURCE directory to its SRC directory.
rem   The first argument is the generic leafname of the specific SOURCE and
rem   SRC directory.  The second argument is the full leafname of the source
rem   file.  The current directory will be left as the specific SRC directory.
rem
rem   The following environment variables can effect the operation of this
rem   script:
rem
rem     DBG_SOURCE  -  Debug source directory name
rem
rem       If this variable exists, source files will be taken from that
rem       directory, if present, instead of the official source directory
rem       identified by the first command line argument.
rem
rem     DBG_PROMOTE  -  Set "true"
rem
rem       If DBG_SOURCE exists and this variable is "true", any source files
rem       taken from the debug source directory will be moved to the official
rem       source directory identified by the first command line argument.
rem       The source files will be removed from the debug source directory.
rem       This variable has no effect unless DBG_SOURCE exists.
rem
call treename_var "(cog)src/%~1" tempdir
cd /d "%tempdir%"
if "%2"=="" goto :eof

call src_getfrom %1 %2 %3 %4 %5 %6 %7 %8 %9
