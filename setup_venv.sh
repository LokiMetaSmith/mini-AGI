#!/bin/bash

# mini-AGI Virtual Environment Setup (Linux/macOS)
# Creates a Python virtual environment and installs dependencies.

VENV_DIR="venv"

# Check if python3 is installed
if ! command -v python3 &> /dev/null
then
    echo "Python 3 could not be found. Please install Python 3.10 or newer."
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment in '$VENV_DIR'..."
    python3 -m venv "$VENV_DIR"
else
    echo "Virtual environment '$VENV_DIR' already exists."
fi

# Activate virtual environment
echo "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Update pip
echo "Updating pip..."
python3 -m pip install --upgrade pip

# Install dependencies
echo "Installing dependencies..."
pip install torch numpy pyyaml matplotlib flask tokenizers chess zstandard scipy

echo ""
echo "Setup complete! To activate the environment, run:"
echo "source $VENV_DIR/bin/activate"
