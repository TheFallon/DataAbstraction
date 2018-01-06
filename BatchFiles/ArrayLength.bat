@echo off

REM Create an array and initialize it ith some values
set Arr[0]=1
set Arr[1]=2
set Arr[2]=3
set Arr[3]=4
set "x=0"
:SymLoop

REM This is where the array elements are counted
if defined Arr[%x%] (
	call echo %%Arr[%x%]%%
	set /a "x+=1"
	GOTO :SymLoop
)
echo "The length of the array is" %x%