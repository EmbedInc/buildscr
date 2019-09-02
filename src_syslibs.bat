@echo off
rem
rem   SRC_SYSLIBS lnkfile
rem
rem   Add commands to the linker command file LNKFILE to include all the system
rem   libraries.  This set of libraries must be able to satisfy missing
rem   externals to all system calls and C runtime resources.
rem
echo AdvAPI32.Lib >>"%~1"
echo Ws2_32.lib >>"%~1"
echo Ole32.lib >>"%~1"
echo Setupapi.lib >>"%~1"
echo User32.lib >>"%~1"
echo Shell32.lib >>"%~1"
echo LIBCMT.LIB >>"%~1"
echo DnsAPI.LIB >>"%~1"
echo Gdi32.Lib >>"%~1"
