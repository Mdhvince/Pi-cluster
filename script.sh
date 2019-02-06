# install sshpass using brew
brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb

#---for each Raspi : One by One---#

# allow connection
ssh pi@192.168.1.X # then tape yes and enter password

# change the hostname
sudo nano /etc/hosts # replace raspberrypi by the name (ie: rpi01), ctrl+x and return
sudo nano /etc/hostname # same as above
sudo reboot

# re-allow connection with the hostname
ssh pi@rpi01.local # tape yes and quit


#---INSTALL ALL THE NECESSARY PACKAGE ON ALL RASPI IN ONE LINE---#
# We can now use sshpass with the password as argument

for i in rpi01 rpi02 rpi03 rpi04 ; do sshpass -p 'raspberry' ssh pi@$i.local -yes "sudo apt-get update && sudo apt-get dist-upgrade; sudo apt-get install python3-pip; pip install virtualenv; python3 -m virtualenv env; . env/bin/activate; pip install dask[complete] distributed bokeh --upgrade; deactivate"; done