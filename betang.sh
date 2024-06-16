#!/bin/bash

# Call the update script
$PREFIX/bin/update_betang

# Define a function to check initial setup requirements
check_setup() {
    if [ ! -d "/sdcard/Download/wine" ]; then
        echo "Please create a 'wine' folder in the Download directory."
        return 1
    fi
    if [ ! -d "/sdcard/Download/Emulator" ]; then
        echo "Please create an 'Emulator' folder in the Download directory."
        return 1
    fi
    return 0
}

# Define a function to extract from emulator files
extract_emulator() {
    while true; do
        clear
        echo "Please select a .tar.gz file to extract from the list below or type 'back' to return to the previous menu:"

        # Get the list of .tar.gz files in the emulator directory
        emulator_dir="/sdcard/Download/Emulator"
        files=("$emulator_dir"/*.tar.gz)

        # Check if there are any files
        if [ ${#files[@]} -eq 0 ] || [ ! -e "${files[0]}" ]; then
            echo "No .tar.gz files found in $emulator_dir"
            echo "Please ensure you have placed .tar.gz files in the 'Emulator' folder under 'Download'."
            read -p "Press Enter to return to the main menu..."
            return
        fi

        # Display only file names without the full path
        file_names=("back")
        for file in "${files[@]}"; do
            file_names+=("$(basename "$file")")
        done

        # Use the select command to provide a menu for file selection
        select file_name in "${file_names[@]}"; do
            if [ "$file_name" == "back" ]; then
                return
            elif [ -n "$file_name" ]; then
                selected_file="$emulator_dir/$file_name"
                echo "You selected $selected_file"

                # Prompt the user to choose between "Replace" and "No Replace"
                echo "Choose an option or type 'back' to return:"
                PS3="Enter option: "
                options=("Replace" "No Replace" "back")
                select opt in "${options[@]}"; do
                    case $opt in
                        "Replace")
                            tar -zxf "$selected_file" -C /data/data/com.termux/files/ --recursive-unlink --preserve-permissions && \
                            (echo "QmFja3VwIHN1Y2Nlc3NmdWxseSByZXN0b3JlZAo=" | base64 -d && echo "Q3JlZGl0czogUm9iZXJ0IER1cXVlCg==" | base64 -d) || \
                            (echo "RmFpbGVkIHRvIHJlc3RvcmUgYmFja3VwCg==" | base64 -d)
                            return
                            ;;
                        "No Replace")
                            tar -zxf "$selected_file" -C /data/data/com.termux/files/ --preserve-permissions && \
                            (echo "QmFja3VwIHN1Y2Nlc3NmdWxseSByZXN0b3JlZAo=" | base64 -d && echo "Q3JlZGl0czogUm9iZXJ0IER1cXVlCg==" | base64 -d) || \
                            (echo "RmFpbGVkIHRvIHJlc3RvcmUgYmFja3VwCg==" | base64 -d)
                            return
                            ;;
                        "back")
                            break
                            ;;
                        *) 
                            echo "Invalid option. Please try again."
                            ;;
                    esac
                done
            else
                echo "Invalid selection. Please try again."
            fi
        done
    done
}

# Define a function to extract from wine files
extract_wine() {
    while true; do
        clear
        echo "Please select a wine file to extract from the list below or type 'back' to return to the previous menu:"

        # Get the list of .tar.xz files containing "wine" in their name in the wine directory
        wine_dir="/sdcard/Download/wine"
        files=("$wine_dir"/wine*.tar.xz)

        # Check if there are any files
        if [ ${#files[@]} -eq 0 ] || [ ! -e "${files[0]}" ]; then
            echo "No wine files found in $wine_dir"
            echo "Please ensure you have placed wine .tar.xz files in the 'wine' folder under 'Download'."
            read -p "Press Enter to return to the main menu..."
            return
        fi

        # Display only file names without the full path
        file_names=("back")
        for file in "${files[@]}"; do
            file_names+=("$(basename "$file")")
        done

        # Use the select command to provide a menu for file selection
        select file_name in "${file_names[@]}"; do
            if [ "$file_name" == "back" ]; then
                return
            elif [ -n "$file_name" ]; then
                selected_file="$wine_dir/$file_name"
                echo "You selected $selected_file"
                rm -rf /data/data/com.termux/files/usr/glibc/wine-9.3-vanilla-wow64/share \
                       /data/data/com.termux/files/usr/glibc/wine-9.3-vanilla-wow64/bin \
                       /data/data/com.termux/files/usr/glibc/wine-9.3-vanilla-wow64/lib \
                && tar xf "$selected_file" -C $PREFIX/glibc/wine-9.3-vanilla-wow64 --strip-components=1 --wildcards '*/bin/*' '*/share/*' '*/lib/*' \
                && mv $PREFIX/glibc/wine-9.3-vanilla-wow64/wine-git-655de4b-staging-exp-wow64-amd64/* $PREFIX/glibc/wine-9.3-vanilla-wow64/ \
                && rm -rf $PREFIX/glibc/wine-9.3-vanilla-wow64/wine-git-655de4b-staging-exp-wow64-amd64 \
                && (echo "QmFja3VwIHN1Y2Nlc3NmdWxseSByZXN0b3JlZAo=" | base64 -d && echo "Q3JlZGl0czogUm9iZXJ0IER1cXVlCg==" | base64 -d) \
                || (echo "RmFpbGVkIHRvIHJlc3RvcmUgYmFja3VwCg==" | base64 -d)
                return
            else
                echo "Invalid selection. Please try again."
            fi
        done
    done
}

# Main menu
while true; do
    clear

    # Check setup requirements
    check_setup
    if [ $? -ne 0 ]; then
        echo "Please complete the setup steps above and run the script again."
        exit 1
    fi

    echo "Please select an option:"
    PS3="Enter option: "
    options=("Emulator" "Wine" "Exit")
    select opt in "${options[@]}"; do
        case $opt in
            "Emulator")
                # Execute the emulator function
                extract_emulator
                break
                ;;
            "Wine")
                # Execute the wine function
                extract_wine
                break
                ;;
            "Exit")
                echo "Exiting..."
                exit 1
                ;;
            *) 
                echo "Invalid option. Please try again."
                ;;
        esac
    done
done
