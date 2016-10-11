@echo off
title Index-Control-Panel
< config.txt (
	set /p version=
	set /p shares=
)


:top
echo Commands:
echo share(create/delete/edit)
echo system(shutdown/restart)

echo What would you like to do?
set /p cmd=
if "%cmd%"=="sharecreate" goto sharecreate
if "%cmd%"=="sharedelete goto sharedelete
if "%cmd%"=="shareedit" goto shareedit
if "%cmd%"=="systemshutdown" goto shutdown
if "%cmd%"=="systemrestart" goto restart



:sharecreate
::provisorische berechnung einer möglichen neuen ID:
set ID=1
:ID
if exist database\shares\%ID% (
	set /A ID=%ID%+1
	goto ID
) else (
	goto inputinfo
)
	
	
echo %ID%
goto ID


:inputinfo
::cd database\shares
echo Please enter all required information.

set /p start="starting value: "
set /p max="maximum+: "
set /p min="maximum-: "
set /p name="Name: "

:nameshare
echo.
echo --------------
echo.
echo Your share will be created with the following information:
echo.
echo starting Value: %start% +- %max%/%min%
echo name: %name%
echo ID: %ID%
echo.
echo Press any button to create it.
pause >nul
::create share-folder
md database\shares\%ID%

::create share-file from template
type database\shares\template.bat >> database\shares\%ID%\%ID%.bat

(
	echo %start%
	echo %max%
	echo %min%
	echo %name%
	echo %version%
	echo %ID%
) > database\shares\%ID%\config.txt

echo %start% >> database\values\%name%.yml
(
	echo %ID% 
	echo %name%
) > database\6kf049kfj46098v71089b7430k6b7984376b901374698017698073k9b61\81781512815650261158728\%name%.yml

set /a shares=%shares%+1
(
	echo %version%
	echo %shares%
) > config.txt

:sharedelete
echo Enter the name of the share you want to delete...


::List of all shares with their ID's


set /p delete="ID of the share: "
< database\shares\%ID%\config.txt (
	set /p start=
	set /p max=
	set /p min=
	set /p name=
	set /p ID=
)
del database\shares\%ID%
del database\values\%name%.yml
del logs\%date%\%name%.yml
del temp\%name%.yml
cls
echo.
echo --------------
echo.
echo Your share has been deleted.
pause >nul
goto top

