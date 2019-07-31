#
# Executes commands at logout.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
#$HOME/dotfiles/bin/firefox-sync.sh

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 ]] && {
# Print the message.
cat <<-EOF
See ya again, at ${HOST}'s, ${USER}!
EOF

} >&2
