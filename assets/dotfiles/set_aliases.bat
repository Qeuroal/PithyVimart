@echo off
setlocal EnableDelayedExpansion

:: ==========================================
:: 1. Set Target Path
:: ==========================================
set "KEY_PATH=HKCU\Software\Microsoft\Command Processor"
set "VAL_NAME=AutoRun"
:: Using %USERPROFILE% variable, which automatically resolves to your actual path (e.g., C:\Users\xxx)
set "TARGET_FILE=%USERPROFILE%\pithyvimart\assets\dotfiles\.aliases.bat"

echo.
echo [1/3] Checking file...
if not exist "%TARGET_FILE%" (
    echo [ERROR] File not found!
    echo Target path: "%TARGET_FILE%"
    echo Please check if the path is correct.
    pause
    exit /b 1
)
echo      - File exists, preparing configuration.

:: ==========================================
:: 2. Read and Process Existing AutoRun
:: ==========================================
echo [2/3] Reading existing registry configuration...
set "CURRENT_VAL="
for /f "tokens=2,*" %%A in ('reg query "%KEY_PATH%" /v "%VAL_NAME%" 2^>nul') do (
    set "CURRENT_VAL=%%B"
)

if not defined CURRENT_VAL (
    echo      - AutoRun is empty, creating new value directly.
    reg add "%KEY_PATH%" /v "%VAL_NAME%" /t REG_SZ /d "\"!TARGET_FILE!\"" /f
    goto :Success
)

echo      - Found existing value: !CURRENT_VAL!

:: Check for duplicates
echo "!CURRENT_VAL!" | find /i "dotfiles\.aliases.bat" >nul
if %errorlevel% equ 0 (
    echo [INFO] Configuration already exists, no need to add again.
    goto :End
)

:: ==========================================
:: 3. Critical Fix: Handle Quotes and Concatenate
:: ==========================================
echo [3/3] Appending to existing configuration...

:: [Critical Step]
:: If your existing config (e.g., Clink) has quotes (e.g., "E:\...\clink.bat")
:: You must escape these quotes to \" otherwise the 'reg add' command will fail with "Syntax error"
set "SAFE_VAL=!CURRENT_VAL:"=\"!"

:: Concatenate string: Escaped old value & Escaped new file path
set "FINAL_CMD=!SAFE_VAL! & \"!TARGET_FILE!\""

:: Write to registry
reg add "%KEY_PATH%" /v "%VAL_NAME%" /t REG_SZ /d "!FINAL_CMD!" /f

:Success
echo.
echo [SUCCESS] Configuration completed!
echo ---------------------------------------------------
echo Current AutoRun registry value:
reg query "%KEY_PATH%" /v "%VAL_NAME%"
echo ---------------------------------------------------

:End
pause
