DIR=$1/vagrant_debian
mkdir -p $DIR
export VAGRANT_HOME=$DIR
cd $DIR
cat > Vagrantfile << EOM
Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"
  config.vm.synced_folder ".", "/git"
end
EOM
vagrant up
vagrant plugin install vagrant-vbguest
vagrant vb-guest
vagrant reload
cd $DIR
vagrant ssh
