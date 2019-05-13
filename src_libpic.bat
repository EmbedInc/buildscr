@echo off
rem
rem   SRC_LIBPIC <src dir lnam> <PIC library name>
rem
rem   Build a PIC linkable library.  The first argument is the leafname
rem   of the source directory.  The second is the generic name of the
rem   PIC library file.  The library file will be built in the appropriate
rem   SRC directory.
rem

call src_get %1 %2.mlist
if exist %2.lib del %2.lib
if exist %2.libpic del %2.libpic

copya -out %2.libpic -s "/c"
copya -out %2.libpic -append -s "%2.lib"
copya -out %2.libpic -append -in %2.mlist
libpic %2.libpic
