@echo off
rem
rem   SRC_INS_ASPIC <src dir lnam> <.INS.ASPIC file gnam> [arg ... arg]
rem
rem   Build a PIC assembler include file.  The first argument is the
rem   leafname of the source directory.  The second is the generic name
rem   of the source file.  The file will be copied into the approriate
rem   SRC directory and preprocessed.
rem
rem   The optional ARG arguments are passed directly to PREPIC after the
rem   input file name.
rem

call src_get_ins_aspic %1 %2
prepic %2.ins.aspic %3 %4 %5 %6 %7 %8 %9
