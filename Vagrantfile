Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"  # образ Ubuntu 22.04
  
  # Настройка сети (опционально)
  config.vm.network "private_network", type: "dhcp"
  
  # Синхронизация папки с хоста (где лежит Vagrantfile) в /vagrant внутри VM
  config.vm.synced_folder ".", "/vagrant"
  
  # Дополнительно, можно указать другую папку для синхронизации:
  # config.vm.synced_folder "./src", "/home/vagrant/src"
  
  # Опционально: настройка провайдера VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048" # объем памяти в Мб
    vb.cpus = 2       # количество CPU
  end
  
  # Пример простой shell-провижининга
  config.vm.provision "shell", inline: <<-SHELL
    echo "Provisioning VM..."
  SHELL
end