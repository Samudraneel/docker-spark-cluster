# If the system is turned off for some reason, then this script can be used to start up the containers
# Script assumes that the images already exist
# Only one worker will be created

bash createContainers.sh datastore
bash createContainers.sh master
bash createContainers.sh worker
