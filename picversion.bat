@echo off
rem
rem   PICVERSION
rem
rem   Uses the files from the latest built version of specific PIC firmware
rem   to make the named HEX and MAP files.
rem
rem   The environment must be set up for a particular PIC project, such as is
rem   done by the SOURCE_DIR script.  In that case the latest HEX file built for
rem   that PIC project is made the official version, and the version is
rem   incremented so that subsequent builds are for the new version.
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

call treename_var "(cog)source/%srcdir%/%buildname%/doc.txt" tnam
if not "%buildname%"=="" (
  copya -list -s "Promoting doc.txt --> fw_%fwname%.txt"
  copya "%tnam%" "(cog)doc/fw_%fwname%.txt"
  )

call progout_var "escr (cog)bat/src_seqname.escr" seq
call progout_var "sequence %seq%" fwver
call progout_var "sequence %seq%%fwver% -incr 0 -start 2" fwseq
call progout_var "sum %fwseq% -1" fwseq
if %fwver% leq 9 set fwver=0%fwver%

echo Firmware %fwname%
if "%fwseq%"=="" (
  echo Version %fwver%
  ) else (
  echo Version %fwver% sequence %fwseq%
  )
copya -s "" -list

if not exist "%fwname%.hex" (
  echo No HEX file.
  exit /b 3
  )
if not exist "%fwname%.map" (
  echo No MAP file.
  exit /b 3
  )

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

if not "%fwname%"=="man" goto done_man
hex_recv %fwname%%fwver%.hex
dir %fwname%*.mch /w /o-gn
:done_man

call godir "(cog)source/%srcdir%"
if not "%buildname%"=="" cd "%buildname%"

rem   Copy the HEX and MAP files into the HEX subdirectory, if it exists.  All
rem   older versions will be delted.
rem
if not exist hex goto :done_hexdir
copya (cog)src/%srcdir%/%fwname%%fwver%.hex hex/%fwname%%fwver%.hex
cd ..
:done_hexdir
