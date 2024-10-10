#!/bin/bash

# Function to display a fancy title
function display_title() {
  echo "========================================"
  echo "   Laravel Production Permissions Setup  "
  echo "========================================"
}

# Function to ask for confirmation
function confirm_action() {
  read -p "Are you sure you want to proceed? (yes/no): " confirmation
  if [[ "$confirmation" != "yes" ]]; then
    echo "Action cancelled by the user."
    exit 1
  fi
}

# Check if the script is run as root (SUDO)
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as sudo or root. Please run it with sudo."
  exit 1
fi

# Display the title
display_title

# Ask the user for the Laravel project directory path
read -p "Enter the full path to your Laravel project directory (e.g., /var/www/html/laravel): " LARAVEL_PATH

# Check if the Laravel path exists
if [ ! -d "$LARAVEL_PATH" ]; then
  echo "Error: Laravel directory not found at $LARAVEL_PATH."
  exit 1
fi

# Ask the user to confirm before proceeding
echo "The script will set the following permissions:"
echo "1. Directory permissions: 755"
echo "2. File permissions: 644"
echo "3. Group ownership changed to 'www-data'"
echo "4. Special permissions for 'storage' and 'bootstrap/cache'"
confirm_action

# Set the group ownership to www-data without changing the user ownership
echo "Setting group ownership to www-data..."
chown -R :www-data "$LARAVEL_PATH"

# Set directory permissions to 755
echo "Setting directory permissions to 755..."
find "$LARAVEL_PATH" -type d -exec chmod 755 {} \;

# Set file permissions to 644
echo "Setting file permissions to 644..."
find "$LARAVEL_PATH" -type f -exec chmod 644 {} \;

# Set permissions for storage and cache directories to be writable
echo "Setting permissions for storage and bootstrap cache directories to 775..."
chmod -R 775 "$LARAVEL_PATH/storage"
chmod -R 775 "$LARAVEL_PATH/bootstrap/cache"

# Provide a summary of the changes
echo "Permissions have been successfully set for your Laravel project at: $LARAVEL_PATH."
echo "Make sure to verify that everything is functioning as expected."

echo "Done! Laravel is now ready for production."
