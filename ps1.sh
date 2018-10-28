#! /usr/bin/env bash

# customize things that you don't want to show
__hide_user="eyal"
__hide_location="${HOME}"

function __ps1_user_host {
	# Hide not interesting username and hostname
	
	local text=""
	
	# Add user if it is not __hide_user
	if [ "${USER}" != "${__hide_user}" ]
	then
		local text="${USER}"
	fi
	
	# Set host only if connected from a remote machine
	if env | grep SSH_CONNECTION &>/dev/null
	then
		local text="${text}@$(hostname --short)"
	fi

	printf "${text}"

	return $1 # return exit code so it could be used in following functionss
}

function __ps1_location {

	if [ "$(pwd)" != "${__hide_location}" ]
	then
		printf "$(pwd) "
	fi

	return $1 # return exit code so it could be used in following functions
}

function __ps1_git {

	# git coloring
	if git status &> /dev/null
	then
		printf "("
		printf "$(git branch --no-color 2> /dev/null | grep -e '^*' | sed 's/^* //')"
		if ! git diff --quiet --exit-code &> /dev/null || ! git diff --quiet --staged --exit-code &> /dev/null
		then
			printf ' +'
		fi
		printf ") "
	fi

	return $1 # return exit code so it could be used in following functions
}

c_red="\[$(tput setaf 1)\]"
c_green="\[$(tput setaf 2)\]"
c_yellow="\[$(tput setaf 3)\]"
c_blue="\[$(tput setaf 4)\]"
c_magenta="\[$(tput setaf 5)\]"
c_reset="\[$(tput sgr0)\]"

# Color according to exit code
exit_code_coloring='$( if [ "$?" == "0" ] ; then printf '"${c_green}"'; else printf '"${c_red}"' ; fi )'\

# Define PS1
# The colors should be defined in this scope since echo does not know
# to handle the '\[' and '\]' characters.

export PS1=\
"${c_magenta}"'$(__ps1_user_host $?)'\
"${c_blue}"'$(__ps1_location $?)'\
"${c_yellow}"'$(__ps1_git $?)'\
"${exit_code_coloring}$"\
"${c_reset} "

# Erase variables that should not be exported
unset c_blue c_yellow c_green c_red c_magenta c_reset exit_code_coloring
