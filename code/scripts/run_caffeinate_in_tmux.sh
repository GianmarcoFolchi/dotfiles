#!/bin/bash

export PATH="/opt/homebrew/bin:$PATH"
SESSION="dev"
WINDOW="Utilities"
MAX_RETRIES=5
RETRY_INTERVAL_SECONDS=2
NUM_SECONDS_TO_CAFFEINATE=28800
LOG_FILE="/Users/gfolchi/code/scripts/run_caffeinate_in_tmux_logs"
# Clear the Log File
>"$LOG_FILE"

attempt=1
while [ $attempt -le $MAX_RETRIES ]; do
  if tmux has-session -t "$SESSION" 2>/dev/null; then
    break
  else
    attempt=$((attempt + 1))
    sleep "$RETRY_INTERVAL_SECONDS"
  fi
done

if [ $attempt -gt $MAX_RETRIES ]; then
  echo "Failed to find tmux session '$SESSION' after $MAX_RETRIES attempts. Exiting." >>"$LOG_FILE"
  exit 1
fi

PANE_ID=$(tmux list-panes -t "$SESSION:$WINDOW" -F "#{pane_index} #{pane_id}" | sort -n | awk 'NR==1 {print $2}')
if [ -n "$PANE_ID" ]; then
  tmux send-keys -t "$PANE_ID" "caffeinate -d -t $NUM_SECONDS_TO_CAFFEINATE" C-m
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Success" >>"$LOG_FILE"
else
  echo "Could not find the top pane in '$WINDOW'." >>"$LOG_FILE"
fi
