@echo off
< config.txt (
	set /p version=
	set /p shares=
)
if NOT exist database\6kf049kfj46098v71089b7430k6b7984376b901374698017698073k9b61\819125354215702406417218\started.log goto accountcreation
goto success
::goto login
:accountcreation
echo. >> database\6kf049kfj46098v71089b7430k6b7984376b901374698017698073k9b61\819125354215702406417218\started.log
cd database\6kf049kfj46098v71089b7430k6b7984376b901374698017698073k9b61\818814606370616904\122332551782971361322884\12814172725580320065865\9520946520035214133628
::Generiere username
set user=%username%%Random%

(
	echo %random%
) > %user%.user
echo.
echo This is the first time you are using this program. It automatically generates your accountdata:
echo.
echo --------------
echo username: %user%
< %user%.user (
	set /p password=
)
echo password: %password%
echo --------------
echo.
echo Please write down your data. Press any button to continue.
pause >Nul
ping /N 1,5 localhost >NUL
echo Auto-login...
for %%n in (1, 1, 6) DO 
(
cd..
)
goto main



:login
cls
set /p user="Username: "
set /p password="Password: "
cd database\6kf049kfj46098v71089b7430k6b7984376b901374698017698073k9b61\818814606370616904\122332551782971361322884\12814172725580320065865\9520946520035214133628
IF exist %user%.user goto passwordcheck
echo unknown Username. Please try it again.
goto login
:passwordcheck
< %user%.user (
	set /p pw=
)
if "%pw%"=="%password%" goto success
echo Wrong User or Password. Please try it again.
goto login

:success
echo Succesfully logged in.

:launch
::for %%n in (1, 1, 6) DO (
::	cd..
::)
echo Starting system.
ping /n 2,5 localhost >nul
echo loading shares...

cd database\shares
::custom loop
set a=0
:customloop
if NOT "%a%"=="%shares%" set /a a=%a%+1
if "%a%"=="%shares%" goto endcustomloop
echo loading shares (%a% of %shares%)
ping /N 1,3 localhost >nul
goto customloop
:endcustomloop
echo loaded all shares.
echo loading share-values
echo loading latest index
echo launching system
cd..
cd..
start panel.bat

:main






