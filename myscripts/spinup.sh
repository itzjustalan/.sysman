#!/bin/bash

declare -A apps=(
["aap"]="app-admin-api"
["aau"]="app-admin-ui"
["asp"]="app-salesman-api"
["axp"]="app-sales-executive-api"
["acp"]="app-customer-api"
)
declare -A ports=(
["aap"]="8001:8000"
["aau"]="8000:80"
["asp"]="8004:3003"
["axp"]="8003:5000"
["acp"]="8002:3002"
)

# options

DRYRUN=false				# build image from scratch



# curl them down
testcontainers() {
	echo "test:"
	sudo docker images
	echo ""
	sudo docker ps
	echo ""
	for app in "${!apps[@]}"; do
		port=$(echo "${ports[$app]}" | cut -d':' -f1)
		conn=$(curl -s "http://localhost:$port/")
		if [ -n "$conn" ]; then
			echo "	up - ok	${apps[$app]}"
		else
			echo "	_down !	${apps[$app]}"
		fi
	done
	echo ""
}


# startcontainer or build if no image
startcontainer() {
	app="$1";
	if $DRYRUN ; then
		buildcontainer "$app"
	else
		# check if image exists
		image=$(sudo docker images | grep "${apps[$app]}")
		if [ -z "$image" ]; then
			buildcontainer "$app"
		else
			echo ""
			echo "image found: $image"
			echo ""
			sudo docker run -p "${ports[$app]}" -d "${apps[$app]}"
		fi
	fi
}

# update code and generate build
buildcontainer() {
	app=$1;
	echo "updating ${apps[$app]}"
	cd "$HOME/apps/${apps[$app]}/" || return

	# fetch changes on testing beranch
	git pull origin staging

	# stop docker container
	containerId=$(sudo docker ps | grep "${apps[$app]}" | cut -d' ' -f1)
	if [ -n "$containerId" ]; then
		sudo docker stop "$containerId"
	fi

	# stop customer api to free up space
	#containerId=$(sudo docker ps | grep app-customer-api | cut -d' ' -f1)
	#if [ -n "$containerId" ]; then
	#	sudo docker stop "$containerId"
	#fi

	# copy custom staging files for aau

	# clean unused containers to free up space
	sudo docker system prune -af

	# build docker container
	sudo docker build -t "${apps[$app]}" "$HOME/apps/${apps[$app]}/"

	# run docker container
	sudo docker run -p "${ports[$app]}" -d "${apps[$app]}"

}

spinAll() {
	echo "spinAll"
	for app in "${!apps[@]}"; do
		echo "$app"
	done
}

showhelp() {
	echo ""
	echo "	app not specified!"
	echo ""
	echo "	registered apps: ${!apps[*]} --all --test"
	echo ""
}

#if [ -z "$1" ]; then
#	showhelp
#	exit 1;
#elif [ $# -gt 1 ]; then
#	echo ""
#	echo "	more than one argument specified!"
#	echo ""
#	exit 1;
#else
#	if [ "$1" = "test" ]; then
#		testcontainers
#	elif [ "$1" = "--all" ]; then
#		# stop all containers
#		sudo docker kill "$(sudo docker ps -q)"
#
#		# start all containers
#		for app in "${!apps[@]}"; do
#			echo "=================================================================="
#			echo "	${apps[$app]}"
#			echo "=================================================================="
#			buildcontainer "$app"
#		done
#	elif [ -z "${apps[$1]}" ]; then
#		showhelp
#	else
#		echo "buildcontainer"
#		buildcontainer "$1"
#		testcontainers
#	fi
#fi


#testcontainers
#buildcontainer aaa
#cd ~/wp

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

if [ -z "$1" ]; then
	showhelp
else
	# initialise options
	for arg in "$@"; do
		case "$arg" in
			-d|--dry)
				DRYRUN=true
				;;
		esac
	done

	# handle arguments
	for arg in "$@"; do
		case "$arg" in
			-t|--test)
				#testcontainers
				;;
			-a|--all)
				if "$DRYRUN" ; then
					# stop all containers
					sudo docker kill "$(sudo docker ps -q)"
				fi

				# start all containers
				for app in "${!apps[@]}"; do
					echo "=================================================================="
					echo "	${apps[$app]}"
					echo "=================================================================="
					startcontainer "$app"
				done
				;;
			-d|--dry)
				# skip flag
				;;
			*)
				if [ -z "${apps[$arg]}" ]; then
					echo "$arg not found"
					showhelp
				else
					startcontainer "$arg"
				fi
		esac
	done

	# test all containers
	testcontainers
fi

