# Docker Deployment script
This script creates docker containers for the develop, master, and release branches of Giraf Rest Web-API named nightly, production and release.

## Expected Output
The docker deployment script deletes the currently existing version of the image and creates a docker image and a docker container corresponding to either nightly, production or release.

## Information About Output
The script will clone from this repository:
```
http://git.giraf.cs.aau.dk/Giraf-Rest/web-api.git
```
To
```
/tmp/web-api_/ 
```
However, it will remove the folder after use. For each version (nightly, production or release) it will clone from a different branch (develop, master and release).

The docker container will have autorestart enabled, meaning it will restart itself if it crashes, unless its explicitly stopped by a docker command. They all use internal port 5000. External ports are: 5050 (nightly), 5000 (master) and 5100 (release).

### Log
The script outputs to a deploy.log file (located in its folder) and notes the time, version, branch and result of the execution. 

## Required Input
When calling the script the following input is required:
./script.sh <version> <name of git branch>

These conditions must be met before calling the script: 

### Appsettings
To create a nightly version of the web-api, an appsetings.nightly.json file must comply with the template (this can be found in the web-API repo under the name of appsettings.template.json) and be stored in the same directory as the script. Similarly deploying a production container requires an appsetings.production.json and release requires an appsettings.release.json file.

### Dockerfile
A Dockerfille must be located in the same directory as the script, which will be used when creating the image.

## Notes
The script is executed by a webhook from Gogs every time someone pushes to one of the branches nightly, production or release. See the deploy folder on the web server.

## Changes
If changes occur, be sure to update the readme file to reflect the updates.
