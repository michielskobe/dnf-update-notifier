# DNF Update Notifier

A lightweight Bash script to notify you of available DNF package updates at login on Fedora systems. It integrates with the desktop environment using `notify-send` and allows you to update packages directly via a terminal prompt.

## Features

- Runs `dnf check-update` silently at login
- Sends a notification if updates are available
- Optional action to open a terminal and run `dnf update`
- Automatically launches via a `.desktop` autostart entry

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

## Customization
If you want to use a different terminal emulator, edit the line near the bottom of `~/.dnf-update-notifier.sh`:
```bash
ptyxis -- "$SHELL" -c "sudo dnf update; exec $SHELL"
```
Replace `ptyxis` with your preferred terminal command.

## Uninstall

To remove the notifier:
```bash
$ rm ~/.dnf-update-notifier.sh
$ rm ~/.config/autostart/dnf-update-notifier.desktop
```
