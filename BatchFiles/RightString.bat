@echo off
set str=This message needs changed
echo %str%

set str=%str:~-7%
echo %str%