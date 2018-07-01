# This script will install docker (the latest version) on to your system.
# This script assumes you are running on ubuntu

echo "Updating the apt package index"
sudo apt-get update

echo "Installing packages to allow apt to use a repository over HTTPS"
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

echo "Adding docker's official GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Adding docker repository"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Install Docker CE"
sudo apt-get install docker-ce
