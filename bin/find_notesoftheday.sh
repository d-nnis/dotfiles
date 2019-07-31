#!/usr/bin/env bash

host=`hostname`

found=$(locate -ie *owncloud*Documents*notesOfTheDay_$host.adoc)
exitcode=$?

# TODO: let vimscript read the return code
#echo $found

# workaround via setting an env var
#echo found $found
export foundnotes=$found
echo $found
