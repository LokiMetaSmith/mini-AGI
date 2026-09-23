@echo off
REM mini-AGI Virtual Environment Setup (Windows)
REM Creates a Python virtual environment and installs dependencies.

SET "VENV_DIR=venv"

REM Check if python is installed
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python could not be found. Please install Python 3.10 or newer and add it to your PATH.
    pause
    exit /b 1
)

REM Create virtual environment if it doesn't exist
IF NOT EXIST "%VENV_DIR%" (
    echo Creating virtual environment in '%VENV_DIR%'...
    python -m venv "%VENV_DIR%"
) ELSE (
    echo Virtual environment '%VENV_DIR%' already exists.
)

REM Activate virtual environment
echo Activating virtual environment...
call "%VENV_DIR%\Scripts\activate.bat"

REM Update pip
echo Updating pip...
python -m pip install --upgrade pip

REM Install dependencies
echo Installing dependencies...
pip install torch numpy pyyaml matplotlib flask tokenizers chess zstandard scipy

REM Option to install torch-directml for AMD GPUs on Windows
echo If you have an AMD GPU and want to use DirectML, run:
echo pip install torch-directml

echo.
echo Setup complete! To activate the environment, run:
echo %VENV_DIR%\Scripts\activate
pause
