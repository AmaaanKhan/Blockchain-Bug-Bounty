@echo off
setlocal
cd /d "%~dp0"
title BugShield Local Server

echo ========================================
echo          BugShield Local Server
echo ========================================
echo.
echo Project: %CD%
echo.

for /f "delims=" %%A in ('py set_contract.py --current') do set "CURRENT=%%A"
echo Current contract: %CURRENT%
echo.
echo Paste a new address + Enter,
echo or press Enter to keep the current one.
echo.

set "ADDR=%~1"
set "TRIES=0"
:ASKADDR
set /a TRIES+=1
if %TRIES% gtr 10 (
  echo Too many attempts. Exiting.
  pause
  exit /b 1
)
if not defined ADDR set /p ADDR="Contract address (Enter = keep current): "
if not defined ADDR goto START
py set_contract.py %ADDR%
if %errorlevel% equ 0 goto START
echo.
echo Please try again with a valid address.
echo.
set "ADDR="
goto ASKADDR

:START
set "PORT=8000"

where py >nul 2>&1
if %errorlevel%==0 goto PYTHON
where python >nul 2>&1
if %errorlevel%==0 goto PYTHON
where node >nul 2>&1
if %errorlevel%==0 goto NODE

echo Python and Node.js were not found in PATH.
echo Install Python from https://www.python.org/downloads/ or Node.js from https://nodejs.org/
echo Then run this file again.
pause
exit /b 1

:PYTHON
echo Starting Python server on port %PORT%...
echo Open: http://localhost:%PORT%/
echo Press Ctrl+C to stop.
echo.
start "BugShield Browser" http://localhost:%PORT%/
where py >nul 2>&1
if %errorlevel%==0 (
  py -m http.server %PORT%
) else (
  python -m http.server %PORT%
)
goto END

:NODE
echo Starting Node.js server on port %PORT%...
echo Open: http://localhost:%PORT%/
echo Press Ctrl+C to stop.
echo.
start "BugShield Browser" http://localhost:%PORT%/
npx --yes http-server . -p %PORT%

goto END

:END
echo.
echo BugShield server stopped.
pause
endlocal
