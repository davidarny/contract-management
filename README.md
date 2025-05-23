## Uninstallation

### Complete Removal

To completely remove the cloaking service and revert all changes made by the deployment:

1. **Run the shutdown script**:

   ```bash
   sudo ./shutdown.sh
   ```

2. **Confirm removal**: The script will ask for confirmation before proceeding

3. **Optional reboot**: The script will offer to reboot the system after cleanup

### What the Shutdown Script Removes:

- ✅ **Services**: Stops and removes Next.js, Nginx, and PHP-FPM services
- ✅ **Packages**: Removes PHP packages, Nginx, and related components
- ✅ **Node.js**: Completely removes fnm and Node.js 22 installation
- ✅ **Configuration**: Removes all Nginx configs and systemd service files
- ✅ **Project Files**: Deletes the entire project directory (`/var/www/html`)
- ✅ **Firewall Rules**: Removes web traffic firewall rules
- ✅ **Log Files**: Cleans up cloaking-related log files
- ✅ **System Profile**: Removes fnm from system PATH

### What is Preserved:

- ✅ **PHP Repository**: Left intact to avoid affecting other projects
- ✅ **Basic Packages**: System dependencies and basic tools remain
- ✅ **SSH Access**: SSH configuration and firewall rules preserved
- ✅ **User Data**: System users and basic configuration untouched

**Note**: The shutdown script is designed to be safe and will not break your system or affect other applications.

## Quick Reference
