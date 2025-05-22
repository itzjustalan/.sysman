#!/bin/bash

declare -A apps=(
["aap"]="app-admin-api"
["aau"]="app-admin-ui"
["asp"]="app-salesman-api"
["asx"]="app-sales-executive-api"
["acp"]="app-customer-api"
)
declare -A ports=(
["aap"]="3000:8000"
["aau"]="80:80"
["asp"]="3003:3003"
["asx"]="3001:5000"
["acp"]="3002:3002"
)

testContainers() {
	echo "test_"
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

spinup() {
	app=$1;
	echo "updating ${apps[$app]}"
	cd "$HOME/apps/${apps[$app]}/" || return

	# fetch changes on testing beranch
	git pull origin testing

	# stop docker container
	containerId=$(sudo docker ps | grep "${apps[$app]}" | cut -d' ' -f1)
	if [ -n "$containerId" ]; then
		sudo docker stop "$containerId"
	fi

	# stop customer api to free up space
	containerId=$(sudo docker ps | grep app-customer-api | cut -d' ' -f1)
	if [ -n "$containerId" ]; then
		sudo docker stop "$containerId"
	fi

	# clean unused containers to free up space
	sudo docker system prune -af

	sudo docker images
	sudo docker ps

	# build docker container
	sudo docker build -t "${apps[$app]}" "$HOME/apps/${apps[$app]}/ -q"

	# run docker container
	sudo docker run -p "${ports[$app]}" -d "${apps[$app]}"

}

spinAll() {
	echo "spinAll"
	for app in "${!apps[@]}"; do
		echo "$app"
	done
}

showHelpAndExit() {
	echo ""
	echo "	app not specified!"
	echo ""
	echo "	registered apps: ${!apps[*]} --all test"
	echo ""
	exit 1;
}

if [ -z "$1" ]; then
	showHelpAndExit
elif [ $# -gt 1 ]; then
	echo ""
	echo "	more than one argument specified!"
	echo ""
	exit 1;
else
	if [ "$1" = "test" ]; then
		testContainers
	elif [ "$1" = "--all" ]; then
		# stop all containers
		sudo docker kill "$(sudo docker ps -q)"

		# spinup all containers
		for app in "${!apps[@]}"; do
			echo "=================================================================="
			echo "	${apps[$app]}"
			echo "=================================================================="
			spinup "$app"
		done
	elif [ -z "${apps[$1]}" ]; then
		showHelpAndExit
	else
		echo "spinup"
		spinup "$1"
		testContainers
	fi
fi


#testContainers
#spinup aaa
#cd ~/wp
