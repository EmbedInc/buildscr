@echo off
rem
rem   PICVERSION
rem
rem   Uses the files from the latest built version of specific PIC firmware
rem   to make the named HEX and MAP files.  This releases the current version.
rem   Future builds will be of the next sequential version.
rem
rem   This script must be run in the source directory where the firmware is
rem   built from.
rem
setlocal

if not "%1"=="" (
  PICVERSION no longer supports command line options.
  exit /b 3
  )

if exist build_vars.bat call build_vars.bat

if "%srcdir%"=="" (
  echo Environment not set for PIC firmware.
  exit /b 3
  )
if "%fwname%"=="" (
  echo Environment not set for PIC firmware.
  exit /b 3
  )
call treename_var "(cog)src/%srcdir%" tnam
if not exist "%tnam%" (
  echo Environment not set for PIC firmware.
  exit /b 3
  )
cd /d "%tnam%"
if not exist "%fwname%.hex" (
  echo No HEX file.
  exit /b 3
  )
if not exist "%fwname%.map" (
  echo No MAP file.
  exit /b 3
  )

call treename_var "%sourcedir%/doc.txt" tnam
if not exist "%tnam%" (
  echo No DOC.TXT file
  exit /b 3
  )

cd /d "%sourcedir%"
if not exist seq (
  echo No SEQ subdirectory
  exit /b 3
  )
cd seq

call progout_var "sequence -seq %fwname%" fwver
call progout_var "sequence -seq %fwname%%fwver% -incr 0 -start 2" fwseq
call progout_var "sum %fwseq% -1" fwseq
if %fwver% leq 9 set fwver=0%fwver%

echo Firmware %fwname%
if "%fwseq%"=="" (
  echo Version %fwver%
  ) else (
  echo Version %fwver% sequence %fwseq%
  )
copya -s "" -list

call treename_var "(cog)src/%srcdir%" tnam
cd /d "%tnam%"

copya %fwname%.hex %fwname%%fwver%.hex
copya %fwname%.map %fwname%%fwver%.map
if exist %fwname% (
  copyt %fwname% %fwname%%fwver%
  del %fwname%
  )
del %fwname%.hex
del %fwname%.map

dir %fwname%*.hex /w /o-gn
dir %fwname%*.map /w /o-gn

cd /d "%sourcedir%"

rem   Copy the HEX and MAP files into the HEX subdirectory, if it exists.  All
rem   older versions will be delted.
rem
if not exist hex goto :done_hexdir
copya (cog)src/%srcdir%/%fwname%%fwver%.hex hex/%fwname%%fwver%.hex
cd ..
:done_hexdir

cd /d "%sourcedir%"
copya -s "" -list
copya -list -s "Promoting doc.txt --> fw_%fwname%.txt"
copya doc.txt "(cog)doc/fw_%fwname%.txt"
