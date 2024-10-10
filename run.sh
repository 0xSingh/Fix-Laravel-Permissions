#!/bin/bash

# Function to display a fancy title
function display_title() {
  echo -e "\e[1;32m========================================\e[0m"
  echo -e "\e[1;36m   Laravel Production Permissions Setup  \e[0m"
  echo -e "\e[1;32m========================================\e[0m"
}

# Function to ask for confirmation
function confirm_action() {
  read -p "$(echo -e "\e[1;33mAre you sure you want to proceed? (yes/no): \e[0m")" confirmation
  if [[ "$confirmation" != "yes" ]]; then
    echo -e "\e[1;31mAction cancelled by the user.\e[0m"
    exit 1
  fi
}

# Check if the script is run as root (SUDO)
if [[ $EUID -ne 0 ]]; then
  echo -e "\e[1;31mThis script must be run as sudo or root. Please run it with sudo.\e[0m"
  exit 1
fi

# Display the title
display_title

# Ask the user for the Laravel project directory path
read -p "$(echo -e "\e[1;34mEnter the full path to your Laravel project directory (e.g., /var/www/html/laravel): \e[0m")" LARAVEL_PATH

# Check if the Laravel path exists
if [ ! -d "$LARAVEL_PATH" ]; then
  echo -e "\e[1;31mError: Laravel directory not found at $LARAVEL_PATH.\e[0m"
  exit 1
fi

# Ask the user to confirm before proceeding
echo -e "\e[1;36mThe script will set the following permissions:\e[0m"
echo -e "\e[1;32m1. Directory permissions: \e[1;34m755\e[0m"
echo -e "\e[1;32m2. File permissions: \e[1;34m644\e[0m"
echo -e "\e[1;32m3. Group ownership changed to \e[1;34m'www-data'\e[0m"
echo -e "\e[1;32m4. Special permissions for \e[1;34m'storage'\e[0m and \e[1;34m'bootstrap/cache'\e[0m"

confirm_action

# Set the group ownership to www-data without changing the user ownership
echo -e "\e[1;33mSetting group ownership to www-data...\e[0m"
chown -R :www-data "$LARAVEL_PATH"

# Set directory permissions to 755
echo -e "\e[1;33mSetting directory permissions to 755...\e[0m"
find "$LARAVEL_PATH" -type d -exec chmod 755 {} \;

# Set file permissions to 644
echo -e "\e[1;33mSetting file permissions to 644...\e[0m"
find "$LARAVEL_PATH" -type f -exec chmod 644 {} \;

# Set permissions for storage and cache directories to be writable
echo -e "\e[1;33mSetting permissions for storage and bootstrap cache directories to 775...\e[0m"
chmod -R 775 "$LARAVEL_PATH/storage"
chmod -R 775 "$LARAVEL_PATH/bootstrap/cache"

# Provide a summary of the changes
echo -e "\e[1;32mPermissions have been successfully set for your Laravel project at: \e[1;34m$LARAVEL_PATH\e[0m."
echo -e "\e[1;36mMake sure to verify that everything is functioning as expected.\e[0m"

echo -e "\e[1;32mDone! Laravel is now ready for production.\e[0m"
