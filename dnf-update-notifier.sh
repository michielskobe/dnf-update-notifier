#!/bin/bash

# Run dnf check-update quietly and capture output
updates=$(dnf -q check-update)
exit_code=$?
action=""

if [ $exit_code -eq 100 ]; then
    # Updates available
    count=$(echo "$updates" | grep -E '^\S' | wc -l)
    if [ $count -eq 1 ]; then
	action=$(notify-send --action="update=Update now"  --app-name="DNF" --urgency=critical "DNF update available" "$count package can be updated.")
    else
	action=$(notify-send --action="update=Update now" --app-name="DNF" --urgency=critical "DNF updates available" "$count packages can be updated.")
    fi
elif [ $exit_code -eq 0 ]; then
    # No updates available
    notify-send --app-name="DNF" --urgency=normal "DNF updates" "Your system is up to date."
else
    # Some error occurred
    notify-send --app-name="DNF" --urgency=normal "DNF update check failed" "An error occurred while checking for updates."
fi

if [ "$action" = "update" ]; then
    ptyxis -- "$SHELL" -c "sudo dnf update; exec $SHELL"
fi
