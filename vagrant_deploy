#!/bin/bash 
# *************************************************************************** */
#                                                                             */
#                                                         :::      ::::::::   */
#    Vagrant_deploy                                     :+:      :+:    :+:   */
#                                                     +:+ +:+         +:+     */
#    By: jobailla <jobailla@student.42.fr>          +#+  +:+       +#+        */
#                                                 +#+#+#+#+#+   +#+           */
#                                                      #+#    #+#             */
#                                                     ###   ########.fr       */
#                                                                             */
# *************************************************************************** */

ROOT=sudo

mkdir_vagrant() {
	local DIR=$DIR
	echo $DIR
	$ROOT mkdir -p $NAME
	export VAGRANT_HOME=$DIR
	cd $DIR
}

init_vagrant() {
	$ROOT vagrant up
	$ROOT vagrant plugin install vagrant-vbguest
	$ROOT vagrant vb-guest
	$ROOT vagrant provision
	$ROOT vagrant reload
}

fill_vagrant_file() {
$ROOT cat > Vagrantfile << EOM
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = $SYS
  config.vm.provision :shell, inline: "apt-get -y update"
  config.vm.provision :shell, inline: "apt-get -y upgrade"
  config.vm.provision :shell, inline: "apt-get -y install git"
  config.vm.provision :shell, inline: "apt-get -y install zsh"
  config.vm.provision :shell, inline: "apt-get -y install vim"
  config.vm.provision :shell, inline: "apt-get -y install htop"
  config.vm.provision :shell, privileged: false,
    inline: "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh"
  config.vm.provision :shell, privileged: false,
    inline: "cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc"
  config.vm.provision :shell, inline: "chsh -s /bin/zsh vagrant"
end
EOM
# end string
}

	read -p 'Name of the distribution to install : ' NAME
	if [[ $NAME = "debian" ]]; then
		SYS="\"debian/jessie64\""
	elif [[ $NAME = "ubuntu" ]]; then
		SYS="\"ubuntu/trusty64\""
	elif [[ $NAME = "kali" ]]; then
		SYS="\"Sliim/kali-linux-2.0-amd64\""
	elif [[ $NAME = "fedora" ]]; then
		SYS="\"generic/fedora27\""
	elif [[ $NAME = "archlinux" ]]; then
		SYS="\"terrywang/archlinux\""
	fi
	read -p 'in which folder do you want to install : ' DIR
	echo "All good ! it's time to install $NAME !"
	mkdir_vagrant $NAME $DIR
	fill_vagrant_file $SYS
	init_vagrant
	$ROOT vagrant ssh
