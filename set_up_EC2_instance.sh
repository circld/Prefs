# set locale
sudo echo "LANG=en_US.utf-8" >>  /etc/environment
sudo echo "LC_ALL=en_US.utf-8" >>  /etc/environment

# update all installed programs & add dev tools
sudo yum update
sudo yum groupinstall 'Development Tools'

# install additional software
sudo yum install tmux
sudo yum install atlas-sse3-devel lapack-devel

# install python modules
sudo pip install -U pip
sudo ln -s /usr/local/bin/pip /usr/bin/pip
sudo pip install jupyter
sudo pip install numpy
python -c "import numpy; numpy.show_config()"
sudo pip install scipy
sudo pip install pandas
sudo pip install scikit-learn
sudo pip install nose
sudo pip install pytest
sudo pip install arrow

# test pandas & scipy installs (can be time consuming!)
# nosetests pandas
# nosetests scipy

# clone dotfiles
git clone https://github.com/circld/Prefs Prefs/

# set up vim & other misc config files
./set_up_environment.sh

# re-source .bashrc & .bash_profile
. ~/.bashrc
. ~/.bash_profile
