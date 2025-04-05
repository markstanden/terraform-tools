#!/bin/bash
# Terraform Tools installer

# Get the path to the script itself
SCRIPT_PATH="${BASH_SOURCE[0]}"

# Get the directory containing the script
TOOLS_DIR="$(dirname "$SCRIPT_PATH")"

# Change to that directory (silently)
cd "$TOOLS_DIR" &> /dev/null

# Get the absolute path
TOOLS_DIR_ABSOLUTE="$(pwd)"

# Set the bin directory path
BIN_DIR="$TOOLS_DIR_ABSOLUTE/bin"

# Make sure all scripts are executable
chmod +x "$BIN_DIR"/*

# Determine shell configuration file
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        SHELL_CONFIG="$HOME/.bash_profile"
    else
        SHELL_CONFIG="$HOME/.bashrc"
    fi
else
    echo "Unsupported shell: $SHELL"
    echo "Please manually add $BIN_DIR to your PATH"
    exit 1
fi

# Check if already in PATH
if grep -q "$BIN_DIR" "$SHELL_CONFIG"; then
    echo "Terraform Tools are already in your PATH"
else
    echo "# Terraform Tools" >> "$SHELL_CONFIG"
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$SHELL_CONFIG"
    echo "Terraform Tools added to PATH in $SHELL_CONFIG"
    echo "Please run 'source $SHELL_CONFIG' to update your current session"
fi

echo "Installation complete!"
