#!/bin/bash

# URL of the latest version of the script
SCRIPT_URL="https://raw.githubusercontent.com/robertneed20k/betang/main/betang.sh"

# Path to the current script
SCRIPT_PATH="$PREFIX/bin/betang"

# Function to check internet connection
check_internet() {
    echo "Checking for internet connection..."
    if wget -q --spider http://google.com; then
        echo -e "\e[1;32mInternet connection available.\e[0m"
        return 0
    else
        echo -e "\e[1;31mNo internet connection. Cannot check for updates.\e[0m"
        return 1
    fi
}

# Function to update the script
update_script() {
    echo "Checking for updates..."
    # Create a temporary file for the latest script
    TMPFILE=$(mktemp /tmp/betang_latest.XXXXXX.sh)
    
    if curl -s -o "$TMPFILE" "$SCRIPT_URL"; then
        # Check if the downloaded script is different
        if ! cmp -s "$TMPFILE" "$SCRIPT_PATH"; then
            echo -e "\e[1;32mNew version found. Updating...\e[0m"
            # Move the temporary file to SCRIPT_PATH
            mv "$TMPFILE" "$SCRIPT_PATH"
            chmod +x "$SCRIPT_PATH"
            echo -e "\e[1;32mUpdate complete!\e[0m"
        else
            echo -e "\e[1;32mYou are already using the latest version.\e[0m"
        fi
    else
        echo -e "\e[1;31mFailed to download the latest version.\e[0m"
    fi
    
    # Clean up the temporary file
    rm -f "$TMPFILE"
}

# Call the functions
if check_internet; then
    update_script
fi
