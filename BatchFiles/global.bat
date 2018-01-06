@echo off
set /A globalvar = 5
SETLOCAL
set /A var = 13145
set /A var = %var% + 5
echo %var%
ENDLOCAL
echo %globalvar%