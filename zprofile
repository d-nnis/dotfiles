#
# Executes commands at login pre-zshrc.
#
## path
#
# Editors
#

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# --> already done via fzf?
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $HOME/bin
  $HOME/dotfiles/bin
  $HOME/.local/bin/
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
## integrate with dotfiles/alias
# export LESS='-F -g -i -M -R -S -w -X -z-4'
# export LESS='-F -i -M -R -w -X -z-4 -j.1'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
#if (( $#commands[(i)lesspipe(|.sh)] )); then
#  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
#fi

## firefox-profile in ramdisk
#$HOME/dotfiles/bin/firefox-sync.sh

#
# Temporary Files
#
TMPPREFIX="$(mktemp -d)/zsh"
