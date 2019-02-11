# install sshpass using brew
brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb

#---for each Raspi : One by One---#

# allow connection
ssh pi@192.168.1.X # then tape yes and enter password

# change the hostname
sudo nano /etc/hosts # replace raspberrypi by the name (ie: rpi-worker01), ctrl+x and return
sudo nano /etc/hostname # same as above
sudo reboot

# re-allow connection with the hostname
ssh pi@rpi-worker01.local # tape yes and quit


#---INSTALL ALL THE NECESSARY PACKAGE ON ALL RASPI---#
# We can now use sshpass with the password as argument

for i in rpi-worker01 rpi-worker02 rpi-worker03 rpi-worker04 ; do sshpass -p 'raspberry' ssh pi@$i.local -yes "sudo apt-get update && sudo apt-get dist-upgrade; sudo apt-get install python3-pip; pip3 install virtualenv; python3 -m virtualenv env; . env/bin/activate; pip install dask[complete] distributed bokeh --upgrade; deactivate"; done

# THE SAME CODE AS ABOVE
for i in rpi-worker01 rpi-worker02 rpi-worker03 rpi-worker04
do
	sshpass -p 'raspberry' ssh pi@$i.local -yes
	sudo apt-get update && sudo apt-get dist-upgrade
	sudo apt-get install python3-pip
	pip3 install virtualenv
	python3 -m virtualenv env
	. env/bin/activate
	sudo apt-get install libatlas-base-dev
	pip install dask[complete] distributed bokeh --upgrade
	pip install s3fs
	deactivate
done

# You can also type command without for loop and just synchronize terminal panes when entering the commande.


#---for each Raspi : One by One---#
# LAUNCH WORKERS (for each line) - there is a for loop in order to be able to kill process
for i in rpi-worker01 ; do sshpass -p 'raspberry' ssh pi@$i.local -yes ". env/bin/activate; dask-worker YourScheduler"; done