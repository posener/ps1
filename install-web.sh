#! /usr/bin/env bash

# Run this script using:
#	curl -sSL https://raw.githubusercontent.com/posener/ps1/master/install-web.sh | bash

if ! ls ${HOME}/.bashrc 2> /dev/null
then
	echo "This script needs ~/.bashrc file"
	exit 1
fi

curl -sSL https://raw.githubusercontent.com/posener/ps1/master/ps1.sh > ${HOME}/.ps1.sh
echo "source ${HOME}/.ps1.sh" >> "${HOME}/.bashrc"
