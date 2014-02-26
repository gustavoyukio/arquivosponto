# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

#########################################################################################
# User Defined
# RVM
#########################################################################################
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
source /home/bigode/.rvm/scripts/rvm
alias abraditsimaree="rvm use ree & rvm use ree@sima2"

#########################################################################################
# Directories
#########################################################################################
alias www="cd /home/bigode/Desktop/www"
alias ebash="sudo gedit ~/.bashrc"

#########################################################################################
# SSHs
#########################################################################################
alias ssh_homo="echo AgHoSer@107; ssh homologacao.agence.com.br@homologacao.agence.com.br"
alias ssh_newik_cetip="www; cd cetip; ssh -i agence.pem agence@107.22.246.87"
alias ssh_koyama="echo ayumi!1982; ssh koyama1@koyama.com.br"

#########################################################################################
# Git
#########################################################################################
alias gbr='git branch'
alias gst='git status'
alias gpl='git pull'
alias gps='git push'
alias gca="git commit -am 'send by alias' "
alias gcall="git commit -am 'send By Alias' & git pull & git push"
alias gaall="git add .; git commit -m 'send By Alias'; git pull; git push"
	#################################################################################
	# Git Functions
	#################################################################################
	gchk() {
		git checkout $1
	}	
	gcommitall() {
		git commit -am '$1'
	}
	#################################################################################
	# Git Functions
	#################################################################################
	hotfix() {
		branch="hotfix-$1"
		read -p "Quer criar o branch $branch? y/n" resp
		case "$resp" in
			y*)
				git checkout dev 
				git checkout -b $branch 
				git push origin $branch ;;
			n*)
				echo "Tenha um bom dia!" ;;
		esac
	}
	lazyclone() {
		read -p "Nome do Repositorio (git or bit)? " rep
		read -p "Nome do Projeto do Git: " projeto
		read -p "Nome do Dono: " dono
		read -p "Nome da pasta de destino: " pasta
		read -p "Framework( cake, zend, yeoman ): " framework
		echo $projeto;
		echo $dono;
		echo $pasta;
		echo $framework;
		www
		if [ $rep == "git" ]; then
		        sudo git clone https://gustavoyukio:1234qwer@github.com/$dono/$projeto $pasta
			echo "Clonado com Sucess do GIT \n"
		else
		        sudo git clone https://bigodeaoki:123@bitbucket.org/$dono/$projeto $pasta
			echo "Clonado com Sucess do BIT \n"
		fi
        echo "
<VirtualHost *:80>
    ServerName $pasta.local
    ServerAlias $pasta.local
    ServerAdmin gustavoyukio@gmail.com

    # Document Root
    DocumentRoot /home/bigode/Desktop/www/$pasta

    <Directory /home/bigode/Desktop/www/$pasta>
        Options Indexes FollowSymLinks
        AllowOverride All
        Order allow,deny
        Require all granted
        Allow From All
    </Directory>

</VirtualHost>
" >> /etc/apache2/sites-available/vhosts.conf;
        echo "127.0.0.1      $pasta.local" >> /etc/hosts
        sudo /etc/init.d/apache2 restart
	#####################################################
	# FRAMEWORK USADO 
	#####################################################
		cd $pasta
	if [ $framework == "cake" ]; then
		sudo mkdir -p app/tmp/cache/persistent
		sudo mkdir -p app/tmp/cache/models
		sudo mkdir -p app/tmp/cache/controllers
		sudo mkdir -p app/tmp/cache/views
		sudo mkdir -p app/tmp/cache/css
		sudo mkdir -p app/tmp/cache/js
		sudo mkdir -p app/tmp/logs
		sudo chmod 777 -R app/tmp
	fi
	}
	lazymerge() {
		read -p "Branch de Origem: " org
		read -p "Branch do Merge: " mrg
		read -p "Pasta a ser ignorado:" fol
		git checkout $mrg
		git merge --no-commit origin $org
		git reset $fol
		git commit -m "Send By LazyMerge"
		git push origin $mrg
		git status
		sudo rm -Rf $fol
	}
#########################################################################################
# Sass
#########################################################################################
sass_p() {
    www
    cd $1/css
    sass --watch sass/main.scss:main.css
}
#########################################################################################
# Ajustes
#########################################################################################
makedir() {
	www
	read -p "nome do repositorio" rep
	read -p "nome do framework" frame
	if [ $frame == "cake" ]; then
		cd $rep
		sudo mkdir -p app/tmp/cache/persistent
		sudo mkdir -p app/tmp/cache/models
		sudo mkdir -p app/tmp/cache/views
		sudo mkdir -p app/tmp/cache/controllers
		sudo mkdir -p app/tmp/cache/js
		sudo mkdir -p app/tmp/cache/css
		sudo mkdir -p app/tmp/logs
		sudo chmod 777 -R app/tmp
	fi
}

#########################################################################################
# Project Start
#########################################################################################
projectStart() {
	read -p "Nome do Projeto: " projeto
	www
	sudo mkdir -p $projeto

	# Write permission
	sudo chmod 777 -R $projeto
	cd $projeto

	# folders creations
	mkdir -p app/js/plugins
	mkdir -p app/js/base
	mkdir -p app/js/main
	mkdir -p app/css/sass/fonts
	mkdir -p app/css/sass/main
	mkdir -p app/css/sass/header
	mkdir -p app/css/sass/footer
	mkdir -p app/images
	mkdir -p dist

	# initial Files
	sudo npm init
	sudo npm install grunt --save-dev
	sudo npm install grunt-contrib-sass --save-dev
	sudo npm install grunt-contrib-concat --save-dev
	sudo npm install grunt-contrib-uglify --save-dev

	wget -c https://raw2.github.com/gruntjs/grunt-init-gruntfile/master/root/Gruntfile.js
	touch app/index.html
	touch app/js/.empty
	touch app/js/base/.empty
	touch app/js/main/.empty
	touch app/css/.empty
	touch app/css/sass/.empty
	touch app/css/sass/fonts/.empty
	touch app/css/sass/main/.empty
	touch app/css/sass/header/.empty
	touch app/css/sass/footer/.empty
	touch app/images/.empty
	touch app/dist/.empty

}

#########################################################################################
# Project Start
#########################################################################################
startProject() {
	read -p "Cloning? y/n" clone
	case "$clone" in
		y*)
			lazyclone ;;
		n*)
			projectStart ;;
	esac

	echo $abacate;
}