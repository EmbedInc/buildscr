@echo off
rem
rem   SRC_DOC srcdir fnam
rem
setlocal
call src_get "%~1" "%~2"
copya -in "%~2" -out "(cog)doc/%~2" -tabs 3
