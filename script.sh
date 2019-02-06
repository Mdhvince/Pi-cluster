# install sshpass using brew
brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb

#---for each Raspi : One by One---#

# allow connection
ssh pi@192.168.1.X # then tape yes and enter password

# change the hostname
sudo nano /etc/hosts # replace raspberrypi by the name (ie: rpi01), ctrl+x and return
sudo nano /etc/hostname # same as above
sudo reboot

