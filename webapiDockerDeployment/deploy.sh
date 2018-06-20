#!/bin/bash

# Web-API Deployment Script
# deploys a docker container that builds a branch from the web-api git repository
# Run with: ./deploy.sh <container version> <name of git branch>
# Example:  ./deploy.sh nightly develop

# definitions
base_dockerfile_ver="2.0.5-2.1.4-jessie"
port_internal=5000
port_nightly=5050
port_production=5000
port_release=5100

version_nightly='nightly'
version_production='production'
version_release='release'

path="/tmp/web-api_"
url_git='https://gitlab.giraf.cs.aau.dk/Server/web-api.git'
log="deploy.log"

mode=$1
branch=$2

# Function
function deploy_container 
{
	# parameters
	path=$1 		# path for the temporary git repository location
	version=$2		# version of the docker container: nightly, production, release, etc.
	branch=$3		# develop, nightly, release-*, etc.
	port=$4			# port for the container
	log=$5			# path to logfile

	# setup
	echo "$(date +"[%F %T %Z]") Version: $version | Branch: $branch | Deployment started" >> $log
	container_name="web-api_$version"
	image_name="web-api_$version:$base_dockerfile_ver"

	# deletion
	rm -rf $path
	docker stop $container_name
	docker rm $container_name
	docker image rm $image_name

	# setup new container
	git clone -b "$branch" $url_git $path
	cp Dockerfile "$path"Dockerfile
	cp appsettings."$version".json "$path"GirafRest/appsettings.json
	docker build -t $image_name $path
	outcome="$(docker run --name $container_name -d --restart unless-stopped -p $port:$port_internal $image_name)"	

	# log result
	gitinfo="$(git --git-dir="$path".git --work-tree="$path" rev-parse --short HEAD | sed "s/\(.*\)/@\1/")"
	if [[ "$outcome" > 0 ]]; then
	        echo "$(date +"[%F %T %Z]") | Version: $version | Branch: $branch | Deployment success (commit $gitinfo)" >> $log
	else
	        echo "$(date +"[%F %T %Z]") | Version: $version | Branch: $branch | Deployment failed (commit $gitinfo)" >> $log
	fi

	# cleanup temporary git repository
	rm -rf $path
}


# execution
if   [[ $mode == "$version_nightly" ]]; then
	deploy_container "$path$version_nightly/" $version_nightly $branch $port_nightly $log

elif [[ $mode == "$version_production" ]]; then
	deploy_container "$path$version_production/" $version_production $branch $port_production $log

elif [[ $mode == "$version_release" ]]; then
	deploy_container "$path$version_release/" $version_release $branch $port_release $log

else 
	echo "$(date +"[%F %T %Z]") | Version: $mode | Branch: $branch | Unrecognized input" >> $log	
fi
