# Betang - Wine and Emulator Manager for Termux

## Description

Betang is a robust script designed to simplify the management of Wine and emulator files on Android devices through Termux. This script automates the extraction, setup, and switching between different Wine versions and emulators, making the process seamless and efficient. 


## Installation

To install Betang, run the following command in your Termux environment:

```bash
curl -s -o ~/install_betang.sh https://raw.githubusercontent.com/robertneed20k/betang/main/install && clear && . ~/install_betang.sh
```

### Key Features

- **Automated File Extraction**: Easily extract files with simple commands.
- **Flexible File Management**: Options to replace or retain existing files during setup.
- **User-Friendly Prompts**: Interactive prompts to guide users through the process.
- **Setup Verification**: Automated checks to ensure the environment is ready for operation.

## Usage Instructions

### Main Menu

Upon running the script, you will be presented with the following options:

- **Emulator**: Manage and extract emulator files.
- **Wine**: Manage and extract Wine files.
- **Exit**: Exit the script.

### Extracting Emulator Files

1. Select the `Emulator` option from the main menu.
2. Choose a `.tar.gz` file from the list of available files in the `EMULATOR` folder.
3. Choose whether to replace existing files or not.
4. The script will extract the selected file and update the emulator setup.

### Extracting Wine Files

1. Select the `Wine` option from the main menu.
2. Choose a Wine `.tar.xz` file from the list of available files in the `WINE` folder.
3. The script will remove the old Wine files and extract the new ones.

## Keywords

- Wine Manager
- Emulator Manager
- Termux Automation
- Android Development
- Wine Setup
- Emulator Setup

## Contribution

Contributions are welcome! Please fork this repository and submit pull requests.

## License

This project is licensed under the MIT License.
