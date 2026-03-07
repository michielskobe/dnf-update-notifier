#!/bin/bash

# Check whether the script has been executed in the last 24 hours.
STAMP="$HOME/.cache/dnf-update-notifier.last"
INTERVAL=$((24*60*60))  # 24 hours

if [ -f "$STAMP" ]; then
    LAST=$(stat -c %Y "$STAMP")
    NOW=$(date +%s)

    if (( NOW - LAST < INTERVAL )); then
        exit 0
    fi
fi

touch "$STAMP"

# Run dnf check-update quietly and capture output
updates=$(dnf -q check-update 2>&1)
exit_code=$?
action=""

if [ $exit_code -eq 100 ]; then
    # Updates available
    count=$(echo "$updates" | grep -E '^\S' | wc -l)
    if [ $count -eq 1 ]; then
		action=$(notify-send --action="update=Update now" --app-name="DNF" --urgency=critical "DNF update available" "$count package can be updated.")
    else
		action=$(notify-send --action="update=Update now" --app-name="DNF" --urgency=critical "DNF updates available" "$count packages can be updated.")
    fi
elif [ $exit_code -eq 0 ]; then
    # No updates available
    notify-send --app-name="DNF" --urgency=normal "DNF updates" "Your system is up to date."
else
    # Some error occurred
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] DNF update check failed:" >> ~/dnf-update-notifier.log
    echo "$updates" >> ~/dnf-update-notifier.log
    echo "----------------------------------------------------------------------------------------------------" >> ~/dnf-update-notifier.log
    action=$(notify-send --action="retry=Retry" --action="log=Inspect log" --app-name="DNF" --urgency=critical "DNF update check failed" "An error occurred while checking for updates.")
fi

if [ "$action" = "update" ]; then 
	ptyxis -- "$SHELL" -c "sudo dnf update; exec $SHELL" 
elif [ "$action" = "retry" ]; then 
	nohup sh ~/dnf-update-notifier.sh >/dev/null 2>&1 & 
elif [ "$action" = "log" ]; then 
	gnome-text-editor ~/dnf-update-notifier.log 
fi
