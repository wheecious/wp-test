#!/usr/bin/bash
TESTDIR=~
FILENAME=TREMENDOUSLYBIGFILE

echo are you ready to create the one and only ENORMOUS $FILENAME?

read -r -p "y/n: " response
case "$response" in
  [y])
          dd if=/dev/zero of=$TESTDIR/$FILENAME bs=1024M
    ;;
  *)
    exit
    ;;
esac

df -h /
echo the file will be deleted
read -p 'press enter to continue'
rm $FILENAME && echo success
