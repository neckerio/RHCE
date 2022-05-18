#!/bin/bash

echo give me a directory 

read DIREC 

case $DIREC in 

	monkey) 

		echo simian minion 

		exit 3
	
		;;

	tiger)

		echo big ass cat

		exit 4

		;;

	dog)

		echo a useless ass animal 

		exit 5

		;;

	*)

		echo is that even a directory man?

		exit 6

		;;

		
esac
