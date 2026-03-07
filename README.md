# DNF Update Notifier

A lightweight Bash script to notify you of available DNF package updates at login on Fedora systems. It integrates with the desktop environment using `notify-send` and allows you to update packages directly via a terminal prompt.

## Features

- Runs `dnf check-update` silently in the background
- Sends a desktop notification if updates are available
- Optional action to open a terminal and run `dnf update`
- Automatically executed periodically using a cron job.
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
2. **Move the script to the correct location and make it executable:**

   ```bash
   $ mv dnf-update-notifier.sh /path/to/dnf-update-notifier.sh
   $ chmod +x /path/to/dnf-update-notifier.sh
   ```

3. **Add a cron job to run the script automatically:**


   1. Open your user crontab:
      ```bash
      $ crontab -e
      ```

   2. Add the following line to run the script every minute:
      ```bash
      * * * * * /path/to/dnf-update-notifier.sh
      ```
   
   3. Save and exit the editor. The script will now run automatically at the specified interval.

   4. Verify that the cron job was added successfully:
      ```bash
      $ crontab -l
      ```

## Customizations
- **Cron interval vs script execution:**

   The example cron job runs the script every minute (every minute of every hour, every day). Inside the script, a check ensures that the update check executes only once every 24 hours. This approach has two advantages:

   1. **No missed checks** - if the system is powered off when a scheduled cron execution would occur, the script will still run the next time the system is on, so updates are never skipped.

   2. **Avoids unnecessary notifications** - even though the cron job may trigger frequently, the script itself enforces the interval, preventing repeated notifications within the same 24-hour period.

   You can adjust the frequency by modifying the `INTERVAL` variable inside `dnf-update-notifier.sh`, allowing you to balance timely update checks with minimal notification noise.

- **Custom terminal emulator:**

   If you want to use a different terminal emulator, edit the line near the bottom of `dnf-update-notifier.sh`:
   ```bash
   ptyxis -- "$SHELL" -c "sudo dnf update; exec $SHELL"
   ```
   Replace `ptyxis` with your preferred terminal command.

- **Custom text editor for logs:**

   If you want to use a different text editor to inspect the error log, edit the line near the bottom of `dnf-update-notifier.sh`:
   ```bash
   gnome-text-editor /path/to/dnf-update-notifier.log
   ```
   Replace `gnome-text-editor` with your preferred editor.

## Uninstall

1. Remove the script:

   ```bash
   $ rm /path/to/.dnf-update-notifier.sh
   ```

2. Remove the cron job by editing your crontab and deleting the corresponding line:

   ```bash
   $ crontab -e
   ```
