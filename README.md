# DNF Update Notifier

A lightweight Bash script to notify you of available DNF package updates at login on Fedora systems. It integrates with the desktop environment using `notify-send` and allows you to update packages directly via a terminal prompt.

## Features

- Runs `dnf check-update` silently at login
- Sends a notification if updates are available
- Optional action to open a terminal and run `dnf update`
- Automatically launches via a `.desktop` autostart entry
- Retry option included in case of update check errors
- Logs error details for troubleshooting
  
## Notification Preview

Here’s how the desktop notifications look in different scenarios: when updates are available, when the system is up to date, and when an error occurs during the update check.

Updates available          |  System up-to-date        |  Error
:-------------------------:|:-------------------------:|:-------------------------:
![Screenshot of DNF update notification (Available updates scenario)](https://github.com/user-attachments/assets/40d7e7f1-b6f4-4639-a00e-2745e47d4b88) |  ![Screenshot of DNF update notification (Up-to-date scenario)](https://github.com/user-attachments/assets/0333c914-ec84-4fdc-a2d4-4b8ac31c7edb) | ![Screenshot of DNF update notification (Error scenario)](https://github.com/user-attachments/assets/ff270f1e-c397-4220-b5a2-c0985c75eccd)

## Installation

1. **Clone the repository:**
   
   ```bash
   $ git clone https://github.com/michielskobe/dnf-update-notifier.git
   $ cd dnf-update-notifier
   ```
2. **Copy the script and desktop entry to the correct location:**

   ```bash
   $ cp dnf-update-notifier.sh ~/dnf-update-notifier.sh
   $ mkdir -p ~/.config/autostart
   $ cp dnf-update-notifier.desktop ~/.config/autostart/dnf-update-notifier.desktop
   $ chmod +x ~/dnf-update-notifier.sh
   ```
3. **Verify the Exec path (optional):**

   The `.desktop` file uses:
   ```desktop
   Exec=sh -c '$HOME/dnf-update-notifier.sh'
   ```
   This makes it portable across user accounts. No changes needed unless you renamed the script or placed it elsewhere.

## Customizations
- If you want to use a different terminal emulator, edit the line near the bottom of `~/.dnf-update-notifier.sh`:
   ```bash
   ptyxis -- "$SHELL" -c "sudo dnf update; exec $SHELL"
   ```
   Replace `ptyxis` with your preferred terminal command.

- If you want to use a different text editor to inspect the error log, edit the line near the bottom of `~/.dnf-update-notifier.sh`:
   ```bash
   gnome-text-editor ~/dnf-update-notifier.log
   ```
   Replace `gnome-text-editor` with your preferred text editor command.

## Uninstall

To remove the notifier:
```bash
$ rm ~/.dnf-update-notifier.sh
$ rm ~/.config/autostart/dnf-update-notifier.desktop
```
