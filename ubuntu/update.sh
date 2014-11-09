# use this bash script to update a production instance.
# author: peter mikitsh

# ssh into application server
cd /var/www/linguine-node-git
git pull
bower install --allow-root
gulp
sudo service linguine-node restart
