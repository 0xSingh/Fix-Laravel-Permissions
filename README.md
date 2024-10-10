# Fix Laravel Permissions

## Group Ownership:
It changes the group ownership to www-data, assuming the user can still be the local user.

## Permissions Setup:
- **755 for Directories:** Ensures directories are accessible but not writable by others.
- **644 for Files:** Ensures files are readable but not writable by others.
- **775 for storage and bootstrap/cache:** Allows these directories to be writable by the server.


## Usage Instructions
You can run it remotely:
```bash
sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/0xSingh/Fix-Laravel-Permissions/main/run.sh)"
```
