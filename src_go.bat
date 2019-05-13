@echo off
rem
rem   SRC_GO lib
rem
rem   Go to (set the current directory to) the SRC directory for the indicated
rem   library.
rem
call treename_var "(cog)src/%~1" src_dir
cd /d "%src_dir%"
