#!/bin/bash

# URL of the latest version of the script
SCRIPT_URL="https://raw.githubusercontent.com/robertneed20k/betang/main/betang.sh"

# Path to the current script
SCRIPT_PATH="$PREFIX/bin/betang"

# Function to update the script
update_script() {
    echo "Checking for updates..."
    curl -s -o ~/betang_latest.sh "$SCRIPT_URL"
    
    if ! cmp -s ~/betang_latest.sh "$SCRIPT_PATH"; then
        echo "New version found. Updating..."
        mv ~/betang_latest.sh "$SCRIPT_PATH"
        chmod +x "$SCRIPT_PATH"
        echo "Update complete!"
    else
        echo "You are already using the latest version."
        rm ~/betang_latest.sh
    fi
}

# Call the update function
update_script
