#!/bin/bash

pacinstall () {
	sudo pacman --noconfirm --needed -Sv "$1"
}

paruinstall () {
	paru --noconfirm --needed -Sv "$1"
}



if [[ -f "natpac.txt" ]]; then 
	NATPAC="natpac.txt" && NATPACnum="$(wc $NATPAC | cut -d ' ' -f 2)"
	echo "Ready to install $NATPACnum from $NATPAC. Would you like to Proceed?"

	read -p "(y/n):" NATCON

	NATRECON="$(echo $NATCON | sed 's/[A-Z]/\L&/g')"

	if [[ $NATRECON == yes ]] || [[ $NATRECON == y ]]; then 
		echo "Let's get started!"
		sleep 2
		while read -r NATPKG; do
			echo "installing $NATPKG"
			sleep 1
			pacinstall $NATPKG

		done < $NATPAC

	else
		echo "Whenever you're ready then."
	fi

else
	echo "natpac.txt not found. Skipping"
	sleep 2
fi





if [[ -f "forpac.txt" ]]; then 
	FORPAC="forpac.txt" && FORPACnum="$(wc $FORPAC | cut -d ' ' -f 2)"
	echo "Ready to install $FORPACnum from $FORPAC. Would you like to Proceed?"

	read -p "(y/n):" FORCON

	FORRECON="$(echo $FORCON | sed 's/[A-Z]/\L&/g')"

	if [[ $FORRECON == yes ]] || [[ $FORRECON == y ]]; then 
		echo "Let's get started!"
		sleep 2
		while read -r FORPKG; do
			echo "installing $FORPKG"
			sleep 1
			paruinstall $FORPKG

		done < $FORPAC

	else
		echo "Whenever you're ready then."
	fi

else
	echo "forpac.txt not found. Skipping"
	sleep 2
fi
