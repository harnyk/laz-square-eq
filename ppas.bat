@echo off
SET THEFILE=C:\Users\markh\Documents\Lazarus\SqureEq\SqEqSolver.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.2.2\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o C:\Users\markh\Documents\Lazarus\SqureEq\SqEqSolver.exe C:\Users\markh\Documents\Lazarus\SqureEq\link12804.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
