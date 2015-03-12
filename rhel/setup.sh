# setup.sh
# description: Install necessary infrastructure to run linguine in a production enviornment on RHEL.
# author: peter mikitsh

# install nginx
sudo yum install -y nginx

# create mongodb repo file
echo "[mongodb-org-2.6]" | sudo tee --append /etc/yum.repos.d/mongodb-org-2.6.repo
echo "name=MongoDB 2.6 Repository" | sudo tee --append /etc/yum.repos.d/mongodb-org-2.6.repo
echo "baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/" | sudo tee --append /etc/yum.repos.d/mongodb-org-2.6.repo
echo "gpgcheck=0" | sudo tee --append /etc/yum.repos.d/mongodb-org-2.6.repo
echo "enabled=1" | sudo tee --append /etc/yum.repos.d/mongodb-org-2.6.repo

# install mongodb
sudo yum install -y mongodb-org

# install python3
sudo yum install http://dl.iuscommunity.org/pub/ius/stable/Redhat/7/x86_64/ius-release-1.0-13.ius.el7.noarch.rpm
sudo yum install python34u
