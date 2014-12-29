# only customize if terminal shell (not something like Python's `subprocess`)
if [[ $- == *i* ]]
then

  #########
  # $PATH #
  #########

  export PATH=/usr/local/bin:$HOME/bin:/usr/local/sbin:$PATH

  ## Put brew's ruby in front
  export PATH=/usr/local/opt/ruby/bin:$PATH

  ## Use gnu tools instead
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

  ##########
  # COLORS #
  ##########

  color_bold="\[$(tput bold)\]"
  color_reset="\[$(tput sgr0)\]"
  color_red="\[$(tput setaf 1)\]"
  color_green="\[$(tput setaf 2)\]"
  color_yellow="\[$(tput setaf 3)\]"
  color_blue="\[$(tput setaf 4)\]"
  color_purple="\[$(tput setaf 5)\]"
  color_teal="\[$(tput setaf 6)\]"
  color_white="\[$(tput setaf 7)\]"
  color_black="\[$(tput setaf 8)\]"

  ############
  # TERMINAL #
  ############

  ## Customize the terminal input line
  prompt() {
    PS1="$color_purple.spm $color_blue\W$color_reset: "
  }

  PROMPT_COMMAND=prompt

  # Use sublime for Ctrl+x+e
  EDITOR="subl -w"

  # Default cd path for interactive shells
  if test “${PS1+set}”; then
    CDPATH=:"..:~:~/Projects";
  fi

  # Add bash completion (for git and others)
  if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
  fi

  # Set architecture flags
  export ARCHFLAGS="-arch x86_64"

  ################
  # VIRTUAL ENVS #
  ################

  # pip should only run if there is a virtualenv currently activated
  export PIP_REQUIRE_VIRTUALENV=true

  # cache pip-installed packages to avoid re-downloading
  export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

  # Install a module into global Python
  gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
  }

  # Variables for `virtualenvwrapper`
  export WORKON_HOME=~/Envs
  source /usr/local/bin/virtualenvwrapper.sh

  ###########
  # Aliases #
  ###########

  ## Color ls
  alias ls='ls --color=auto -hF'

  ## Display as a list, sorting by time modified
  alias ll='ls -1t'

  ## Display the insides of a particular directory
  alias lv='ls -R'

  ## subl
  alias s="subl -a"

  ## gopen - open to own github
  function gopen() {
    open "https://github.com/smargh/${1}";
  }
fi
