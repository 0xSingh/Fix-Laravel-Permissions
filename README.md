## Group Ownership:
It changes the group ownership to www-data, assuming the user can still be the local user.

## Permissions Setup:
- **755 for Directories:** Ensures directories are accessible but not writable by others.
- **644 for Files:** Ensures files are readable but not writable by others.
- **775 for storage and bootstrap/cache:** Allows these directories to be writable by the server.


## Usage Instructions
Make the Script Executable:

```bash
chmod +x laravel-permissions-setup.sh
```
Run the Script with Sudo:

```bash
sudo ./laravel-permissions-setup.sh
```
