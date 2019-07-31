#!/usr/bin/env bash

echo testhier
set -g status-right "#(echo \\\\(test\\\\))"

#(echo itestdort)

if [ "$1" = "-on" ]; then
  echo -e "\033]710;xft:DejaVu Sans Mono:style=Regular:size=15\033\\"
  echo -e "\033]711;xft:DejaVu Sans Mono:style=Bold:size=15\033\\"
  echo -e "\033]712;xft:DejaVu Sans Mono:style=Oblique:size=15\033\\"
  echo -e "\033]713;xft:DejaVu Sans Mono:style=Bold Oblique:size=15\033\\"
elif [ "$1" = "-off" ]; then
  echo -e "\033]710;xft:DejaVu Sans Mono:style=Regular:size=10\033\\"
  echo -e "\033]711;xft:DejaVu Sans Mono:style=Bold:size=10\033\\"
  echo -e "\033]712;xft:DejaVu Sans Mono:style=Oblique:size=10\033\\"
  echo -e "\033]713;xft:DejaVu Sans Mono:style=Bold Oblique:size=10\033\\"
fi

#When using the #(command) construction to include the output from a command in
#the status line, the command will be parsed twice. First, when it's read by the
#configuration file or the command-prompt parser, and second when the status
#line is being drawn and the command is passed to the shell. For example, to
#echo the string "(test)" to the status line, either single or double quotes
#could be used:
#
#	set -g status-right "#(echo \\\\(test\\\\))"
#	set -g status-right '#(echo \\\(test\\\))'
#
#In both cases, the status-right option will be set to the string "#(echo
#\\(test\\))" and the command executed will be "echo \(test\)".
