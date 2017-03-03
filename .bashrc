# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


## Dodlazs .bashrc file

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


#Set different terminal colors for different computers
case "$HOSTNAME" in
        "Hugin")
            dir_color=006
            host_color=004
            ;;
        "Oden")
            dir_color=009
            host_color=004
            ;;
        "dns")
            dir_color=190
            host_color=178
            ;;
        *)
            dir_color=013
            host_color=004
esac


# Ask to install if not installd. 
#export COMMAND_NOT_FOUND_INSTALL_PROMPT=1

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
export HISTTIMEFORMAT="| %Y-%M-%d %H:%M:%S | "

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
export HISTIGNORE="&:[ ]*"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=ye

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=no
    fi
fi


if [ "$color_prompt" = yes ]; then
    #http://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        PS1="${debian_chroot:+($debian_chroot)}\[\033[38;5;${host_color}m\]\h\[\033[0m\]:\[\033[38;5;${dir_color}m\]\w\[\033[0m\]\$ "
    else
        PS1="\[\033[38;5;${dir_color}m\]\w\[\033[0m\]\$ "
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -CF --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi



# define color to additional file types
export LS_COLORS=$LS_COLORS:"*.h=01;35":"*.cc=01;35":"*.txt=01;33":"*.pdf=01;31"




# ===== FUN =====
alias starwars='telnet towel.blinkenlights.nl'
alias starwars_ip='telnet 94.142.241.111'
alias random-facts='wget randomfunfacts.com -O - 2>/dev/null | grep \<strong\> | sed "s;^.*<i>\(.*\)</i>.*$;\1;"'

# Currency 
currency-conv() {
    declare -A cur
    cur["gbp"]="GBP"
    cur["pund"]="GBP"
    cur["£"]="GBP"

    cur["sek"]="SEK"
    cur["kr"]="SEK"

    cur["usd"]="USD"
    cur["dollar"]="USD"
    cur["$"]="USD"

    cur["eur"]="EUR"
    cur["euro"]="EUR"
    cur["€"]="EUR"
    
    cur["btc"]="BTC"
    cur["bitcoin"]="BTC"
    cur["฿"]="BTC"
    
    if [[ $1 = *[[:digit:]]* && $2 != "" && $3 != "" ]]; then
        for i in $2
        do
            wget -qO- "http://www.google.com/finance/converter?a=$1&from=${cur[${i,,}]}&to=${cur[${3,,}]}" |  sed '/res/!d;s/<[^>]*>//g';
        done
    elif [[ $1 = *[[:digit:]]* ]]; then
        currency-conv $1 "USD EUR GBP BTC" SEK            
    elif [[ $1 == "" ]]; then
        currency-conv 1 "USD EUR GBP BTC" SEK
    elif [[ $1 == "-l" ]]; then
        echo -e "Swedish Krona: \t SEK (kr)"
        echo -e "USE Dollar: \t USD ($)"
        echo -e "British Pound: \t GBP (£)"
        echo -e "European Euro: \t EUR (€)"
        echo -e "Bitcoin: \t BTC (฿)"
    fi
}    
   
# Weather
weather() {
    if [ -z "$1" ]; then
        curl -k "https://wttr.in/ryd"
    else
        curl -k "https://wttr.in/$1"
    fi
}

# Calculator
= () { echo "$*" | bc -l; }


# ===== Tools =====
alias clean='rm -f *\~ *\.bak *\.dvi *\.aux *\.log *\.out *\.o *\.pyc \#*\#'
alias update-bashrc='. ~/.bashrc'
alias network-scan='nmap -sn'
alias network-scan-192.168.0.1='nmap -sn 192.168.0.1/24'
alias network-scan-192.168.1.1='nmap -sn 192.168.1.1/24'

# Commands
alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'
alias ll='ls -alhF'
alias utop='top -u $USER'
alias print-ram='sudo dd if=/dev/mem | cat | strings'
alias mount='mount |column -t'

# SSH
alias ssh-log-last='sudo grep sshd /var/log/auth.log | grep '\''Failed password'\'' | tail -n 5'

# Info
alias bit-system='getconf LONG_BIT'
alias myip='curl icanhazip.com'

# Internet
alias internet-conection='lsof -P -i -n'
alias header='curl -I'
alias headerc='curl -I --compress'
alias trace='mtr --report-wide --curses 8,56 '
alias usage="ifconfig eth0 | grep 'bytes'"
alias connections='sudo lsof -n -P -i +c 15'

# Database
alias mysql='mysql -u root -p'

# C/C++
alias g++11='g++ -Wall -Wextra -pedantic -g -std=c++11'
alias g++14='g++ -Wall -Wextra -pedantic -g -std=c++14'
alias gcc='gcc -Wall -Wextra -std=c99 -pedantic -g'

# Wifi controler
alias Wifi-on='sudo service network-manager start'
alias Wifi-off='sudo service network-manager stop'
alias Wifi-signal='wavemon'
alias Wifi-scan='sudo iwlist wlan2 scan'
alias Network-savde='nmcli con'
alias Network-connect='nmcli con up id'
alias Network-connected='nmcli device status'
alias Network-networking='nmcli eneral'

# Bluetooth
alias Bluetooth-on="rfkill unblock bluetooth"
alias Bluetooth-off="rfkill block bluetooth"
alias Bluetooth-scan="hcitool scan"
alias Bluetooth-hardware-info="hciconfig;hciconfig -a hci0;lsmod |grep bt;dmesg | grep tooth"
#Bluetooth-off

# Sound controler
alias Sound-volume='amixer -D pulse sset Master '
alias Sound-none='amixer -D pulse sset Master 0%'
alias Sound-min='amixer -D pulse sset Master 1%'
alias Sound-max='amixer -D pulse sset Master 100%'
alias Sound-inc='amixer -D pulse sset Master 5%+'
alias Sound-dec='amixer -D pulse sset Master 5%-'

# Screen brightness controler
alias Screen-brightness='xbacklight -set'
alias Screen-off='xset dpms force standby'
alias Screen-min='xbacklight -set 1'
alias Screen-max='xbacklight -set 100'
alias Screen-inc='xbacklight -inc 10'
alias Screen-dec='xbacklight -dec 10'

# ===== Graphics Software =====
alias dopen='gnome-open'
alias temacs='emacs -nw'
alias android-studio='~/android-studio/bin/studio.sh'
alias web-storm='~/WebStorm-135.1063/bin/webstorm.sh'


# prevent braking the computer
alias rm='rm -I --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# ===== GIT =====
git-uncommit(){
    git fetch --all; git --hard HEAD~$1
}
alias git-force='git fetch --all; git reset --hard'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias ga='git add'
alias gd='git diff'
alias gb='git branch'
alias git-branch="git branch -a"
alias gsb='git show-branch'
alias gco='git checkout'
alias gg='git grep'
alias gk='gitk --all'
alias gr='git rebase'
alias gri='git rebase --interactive'
alias gcp='git cherry-pick'
alias gitlog='git log'
alias gl='git log --graph --date-order -C -M --pretty=format:"%C(yellow)%h%C(reset) - %C(bold green)%ad%C(reset) - %C(dim yellow)%an%C(reset) %C(bold red)>%C(reset) %C(white)%s%C(reset) %C(bold red)%d%C(reset) " --abbrev-commit --date=short'

# ===== CD =====
alias cd..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias la='cd "$OLDPWD"'
..() {
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++)) do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}
# don't nead to write cd
shopt -s autocd





#-------------------------------------------------------------
# Tailoring 'less'
#-------------------------------------------------------------

#alias more='less'
#export PAGER=less
#export LESSCHARSET='utf-8'
#export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
                # Use this if lesspipe.sh exists.
#export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
#:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'


# man page color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$($1)" "Terminal"'
#alias alert='notify-send --urgency=low -i "Här ska det stå text." "Rubrik:"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

