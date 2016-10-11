< config.txt (
	set /p start=
	set /p max=
	set /p min=
	set /p name=
	set /p ID=
)
@echo off
set /a Imax=%start%+%max% 
set /a Imin=%start%-%min% 
::set I=0
cd..
cd..
cd..
:top
cls

::Erzeugung der Veränderung (Zufallszahl zwischen 0 und 1)

::x-Wert für den Log (wird noch nicht genutzt)
::set /a y=%y%+1

::Veränderung wird eingerechnet (Differenz zum Startwert wird kontrolliert)
::if %rand% EQU 1 set /a I=%I%+1
::if %rand% EQU 0 set /a I=%I%-1

::Startwert
::set start=%start%

::Obere Grenze
::set max=%max%

::Untere Grenze
::set min=%min%

::Einhaltung des Integrals
::if %I% GTR %max% set I=%max%
::if not %I% GTR %min% set I=%min%

::Berechnung des Gesamtwertes

if not exist database\values\%name%.yml echo %start% >> database\values\%name%.yml
if exist database\values\%name%.yml goto calc
SET /a a=%RANDOM%*2/32768
if %a% EQU 1 set /a value=%start%+1
if %a% EQU 0 set /a value=%start%-1
goto set

:calc
< database\values\%name%.yml (
	set /p value=
)


SET /a a=%RANDOM%*2/32768
if %a% EQU 1 (
	if not %value%+1 GTR %Imax% (
		set /a value=%value%+1
	)
)
if %a% EQU 0 (
	if %value% GTR %Imin%-1 (
		set /a value=%value%-1
	)
)
:set
echo %name%, %date%, %time:~0,8%
echo Points: %value%


::Write data into temporary log for displaying it

del temp\%name%.yml
echo %name%, %date%, %time:~0,8% >> temp\%name%.yml
echo Points: %value% >> temp\%name%.yml


::Writing data into real log
if not exist logs\%date% mkdir logs\%date%
echo %value%, %time:~0,8% >> logs\%date%\%name%.log
del database\values\%name%.yml
echo %value% >> database\values\%name%.yml
ping /n 2 localhost >Nul
::echo %x8%, %y%
::echo %x8%, %y% >> values.log
::if %y% EQU 200 goto end
goto top

:end
exit