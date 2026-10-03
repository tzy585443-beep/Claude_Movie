@echo off
setlocal
cd /d "%~dp0"
set "PAGE=%~dp0index.html"
set "PROFILE=%TEMP%\ReasoningMovieProfile"
set "BROWSER="

rem Prefer Chrome, then Edge: launched with a private profile so autoplay + fullscreen work
for %%B in (
  "%ProgramFiles%\Google\Chrome\Application\chrome.exe"
  "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
  "%LocalAppData%\Google\Chrome\Application\chrome.exe"
  "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
  "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
) do if not defined BROWSER if exist %%B set "BROWSER=%%~B"

if defined BROWSER goto launch
rem No Chrome/Edge found: open with the default browser (click the start button to play)
start "" "%PAGE%"
goto :eof

:launch
start "" "%BROWSER%" --user-data-dir="%PROFILE%" --no-first-run --no-default-browser-check --autoplay-policy=no-user-gesture-required --start-fullscreen --new-window "%PAGE%"
