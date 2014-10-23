# setup.sh
# description: Install necessary infrastructure to run linguine in a production enviornment on Ubuntu.
# author: peter mikitsh

# install nginx
sudo apt-get install nginx

# install mongo
# from http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# install node
# from https://github.com/joyent/node/wiki/installing-node.js-via-package-manager
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# install global node modules
npm install gulp -g
npm install bower -g

# install git
sudo apt-get install git

# checkout linguine-node to /var/www/linguine-node
# copy linguine-node.conf to /etc/init/linguine-node.conf
cd /var/www/linguine-node
bower install --allow-root
gulp build

# start linguine-node
sudo service linguine-node restart
