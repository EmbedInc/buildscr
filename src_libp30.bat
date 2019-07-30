@echo off
rem
rem   SRC_LIBP30 <src dir lnam> <dsPIC library name>
rem
rem   Build a dsPIC linkable library.  The first argument is the leafname
rem   of the source directory.  The second is the generic name of the
rem   dsPIC library file.  The library file will be built in the appropriate
rem   SRC directory.
rem
setlocal

call src_get %1 %2.mlist
if exist %2.libp30 del %2.libp30
if exist %2.l30cmd del %2.l30cmd

copya -out %2.l30cmd -s "CREATE %2.libp30"
copya -out %2.l30cmd -append -in %2.mlist
copya -out %2.l30cmd -append -s "SAVE"
copya -out %2.l30cmd -append -s "END"

call extpath_var mplab/lib16.exe tnam
"%tnam%" -omf=elf -M <%2.l30cmd

call extpath_var mplab/index16.exe tnam
"%tnam%" -omf=elf %2.libp30
