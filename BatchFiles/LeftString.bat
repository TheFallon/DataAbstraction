@echo off
set str=HelloWorld
echo %str%

set str=%str:~5,10%
echo %str%