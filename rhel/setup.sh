# setup.sh
# description: Install necessary infrastructure to run linguine in a production enviornment on RHEL (Red Hat).
# author: peter mikitsh

# install nginx
sudo yum install -y nginx

# create mongodb repository file from github
sudo wget -q https://raw.githubusercontent.com/rigatoni/config/master/rhel/mongodb-org-2.6.repo -O /etc/yum.repos.d/mongodb-org-2.6.repo

# install mongodb
sudo yum install -y mongodb-org

# install python3
sudo yum install http://dl.iuscommunity.org/pub/ius/stable/Redhat/7/x86_64/ius-release-1.0-13.ius.el7.noarch.rpm
sudo yum install python34u python34u-dev

# install node and build tools
curl -sL https://rpm.nodesource.com/setup | bash -
sudo yum install -y nodejs npm bzip2

# install global node modules
sudo npm install -g gulp bower

# checkout linguine-node (develop branch) to /var/www/linguine-node-git
sudo git clone -b develop https://github.com/rigatoni/linguine-node.git /var/www/linguine-node-git

# checkout linguine-python (develop branch) to /var/www/linguine-python-git
sudo git clone -b dev https://github.com/rigatoni/linguine-python /var/www/linguine-python-git

# install node application-level dependencies
cd /var/www/linguine-node-git
sudo npm install
sudo bower install --allow-root # when prompted, select "1"
sudo gulp build

# install RPM's that are required by python application level dependencies
sudo yum install http://mirror.rit.edu/centos/7/os/x86_64/Packages/blas-devel-3.4.2-4.el7.x86_64.rpm
sudo yum install http://mirror.rit.edu/centos/7/os/x86_64/Packages/lapack-devel-3.4.2-4.el7.x86_64.rpm

# install python application-level dependencies
cd /var/www/linguine-python-git
sudo pip3.4 install -r requirements.txt # give this some time (...a lot of time)
python3 -m textblob.download_corpora # install trained models

# copy system daemon files from github
sudo wget -q https://raw.githubusercontent.com/rigatoni/config/master/rhel/linguine-node.service -O /etc/systemd/system/multi-user.target.wants/linguine-node.service
sudo wget -q https://raw.githubusercontent.com/rigatoni/config/master/rhel/linguine-python.service -O /etc/systemd/system/multi-user.target.wants/linguine-python.service
sudo wget -q https://raw.githubusercontent.com/rigatoni/config/master/no_arch/nginx.conf -O /etc/nginx/nginx.conf

# start mongo
sudo service mongod start

# refresh daemon files
sudo systemctl daemon-reload

# start services
sudo service mongod start
sudo service linguine-node start
sudo service linguine-python start
