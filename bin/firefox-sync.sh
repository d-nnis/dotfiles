#!/bin/sh

profile=$1

static=static_$1
volatile=/dev/shm/firefox-$profile

show_profiles() {
  profiles=`ls --ignore="Crash\ Reports" --ignore="profiles.ini" --ignore="console.log"`
  if [ -z "$profiles" ]; then
    echo "  no profiles found in `pwd`"
  else
    echo "  profiles found in `pwd`"
    echo "  ---"
    echo "  "$profiles
    echo "  ---"
  fi
}

#IFS=
set -efu

echo $(basename $0):

cd ~/.mozilla/firefox

if [ -z $profile ]; then
  echo "  no profile given"
  show_profiles
  exit 2
fi

if [ ! -d $profile ] && [ ! -d $static ]; then
  echo "  no such ff-profile: `pwd`/$profile"
  echo "  or $static"
  show_profiles
  exit 1
fi

echo "  targeting ff-profile: `pwd`/$profile"

if [ ! -r $volatile ]; then
  echo "  create volatile dir in dev-shm: $volatile"
  mkdir -m0700 $volatile
fi

if [ "$(readlink $profile)" != "$volatile" ]; then
  echo "  static ff-profile (backup): `pwd`/$static"
  echo "  creating symprofile $profile to dev-shm: $volatile"

  mv $profile $static
  ln -s $volatile $profile
fi

timestamp=`date`

if [ -e $profile/.unpacked ]; then
  echo "  syncing ff-profile to hdd (static profile) `pwd`/$static"
  rsync -a --delete --exclude .unpacked ./$profile/ ./$static/
  echo $timestamp > `pwd`/$profile.timestamp
else
  echo "  syncing ff-profile to ramdisk $volatile"
  rsync -a ./$static/ ./$profile/
  touch $profile/.unpacked
  echo $timestamp > $volatile.timestamp
fi

