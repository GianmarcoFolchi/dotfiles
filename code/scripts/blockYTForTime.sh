#!/bin/bash

# Function to add YouTube to /etc/hosts
block_youtube() {
    echo "Blocking YouTube..."
    echo "127.0.0.1 youtube.com" | sudo tee -a /etc/hosts
    echo "127.0.0.1 www.youtube.com" | sudo tee -a /etc/hosts
    echo "YouTube is now blocked."
}

# Function to remove YouTube from /etc/hosts
unblock_youtube() {
    echo "Unblocking YouTube..."
    echo "YouTube is now unblocked."
}

# Check if the correct number of arguments is given
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number_of_hours_to_block>"
    exit 1
fi

# Get the number of hours from the command line argument
NUM_HOURS=$1

# Call the function to block YouTube
block_youtube

# Sleep for the given number of hours
echo "YouTube will be blocked for $NUM_HOURS hour(s)."
sleep "${NUM_HOURS}h"

# Call the function to unblock YouTube
unblock_youtube
