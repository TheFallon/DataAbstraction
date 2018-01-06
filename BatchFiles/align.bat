@echo off
set x=1000
set y=1
set y=%y%
echo %x%

set y=%y:~-4%
echo %y%