@echo off
rem
rem   SRC_EXPIC <src dir lnam> <PIC exeuctable gnam>
rem
rem   Build a PIC executable.  The first argument is the leafname of the source
rem   directory.  The second is the generic name of the PIC executable.  The
rem   executable will be built in the appropriate SRC directory.
rem
setlocal
if "%C18Dir%"=="" (
  call treename_var "%MPLABDir%/../c18" C18Dir
  )

call src_get %1 %2.linkpic
copya %2.linkpic %2.lkr

copya -out %2.lkr -append -s "LIBPATH ."
if exist %2.o      copya -out %2.lkr -append -s "FILES %2.o"
if exist %2_strt.o copya -out %2.lkr -append -s "FILES %2_strt.o"
if exist %2.lib    copya -out %2.lkr -append -s "FILES %2.lib"

if not "%clibpic18%"=="" (
  call godir "(cog)src/%1"
  if not exist %2_c018i.o (
    call src_get pic c018i.c18
    call godir "(cog)src/%1"
    copya "(cog)src/pic/c018i.c18" %2_c018i.c18
    "%C18Dir%\bin\mcc18" %2_c018i.c18 -I="%C18Dir%\h" -fo=%2_c018i.o
    if not exist %2_c018i.o exit /b 3
    )
  copya -out %2.lkr -append -s "FILES %2_c018i.o"
  copya -out %2.lkr -append -s "FILES %C18Dir%\lib\p%clibpic18%.lib"
  copya -out %2.lkr -append -s "FILES %C18Dir%\lib\clib.lib"
  )

if exist %2.out del %2.out
if exist %2.cof del %2.cof
if exist %2.map del %2.map
if exist %2.hex del %2.hex
if exist %2.cod del %2.cod
linkpic %2

if not exist %2.hex prepic -in "(cog)source/pic/unseq.aspic" -out /temp/unseq -s srcdir %1 -s fwname %2
copyt %2.out %2.cof
