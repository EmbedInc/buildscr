@echo off
rem
rem   SRC_GETFROM <src dir lname> [<subdir>] <source file name> [tab1 ... tabN]
rem
rem   Copy the source file from its SOURCE directory to the current directory.
rem   The first argument is the generic leafname of the specific SOURCE and
rem   SRC directory.  The second argument is the full leafname of the source
rem   file.
rem
rem   If the environment variable BUILDNAME exists and is not the empty string,
rem   then source file is assumed to be in a subdirectory within the source
rem   directory.  The BUILDNAME environment variable value is the name of the
rem   subdirectory.
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
rem   If the indicated source file does not exist, then a copy of it is
rem   guaranteed not to exist in the current directory when this script
rem   returns.
rem
escr (cog)bat/src_getfrom.escr %1 %2 %3 %4 %5 %6 %7 %8 %9
