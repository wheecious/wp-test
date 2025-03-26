#!/bin/bash

TARGET_DIR="/tmp/i-bench"
LIMIT_PERCENT=95

mkdir -p "$TARGET_DIR"

TOTAL_INODES=$(df -i / | awk 'NR==2 {print $2}')
USED_INODES=$(df -i "$TARGET_DIR" | awk 'NR==2 {print $3}')
THRESHOLD=$((TOTAL_INODES * LIMIT_PERCENT / 100))

echo "iTotal: $TOTAL_INODES"
echo "iUsed: $USED_INODES"
echo "iThreshold $THRESHOLD..."
read -p 'press enter to begin'
i=0
while (( USED_INODES < THRESHOLD )); do
    touch "$TARGET_DIR/file_$i" 2>/dev/null || break
    ((i++))

    # Renew info every 1k files
    if (( i % 10000 == 0 )); then
        USED_INODES=$(df -i "$TARGET_DIR" | awk 'NR==2 {print $3}')
        echo "Files created: $i, inodes used/total: $USED_INODES/$TOTAL_INODES"
    fi
done

echo "The $LIMIT_PERCENT% limit has been reached"
df -i "$TARGET_DIR"

read -p 'press enter to free up the inodes'
rm -rf "$TARGET_DIR" && echo success
df -i /
