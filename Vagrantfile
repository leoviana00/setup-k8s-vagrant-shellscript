# Variables
IMAGE="bento/ubuntu-22.04"
NODE=2
CP=1
ETCD=0
RR=0
IP_PREFIX="172.16.16."
IP_START=100


ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell" do |s|
    ssh_pub_key = File.readlines("./keys/kubespray.pub").first.strip
    s.inline = <<-SHELL
    echo "Ambiente para laboratório: K8S Kubernetesy" > /tmp/vagrant.txt
    echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
    echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
  SHELL
  end

  config.vm.provision "shell", path: "scripts/bootstrap.sh"
  config.vm.box_check_update  = true

  (1..CP).each do |i|
    config.vm.define "k8s-control-#{i}" do |master|
      master.vm.box               = IMAGE
      master.vm.hostname          = "k8s-control-#{i}.labs.com.br"
      master.vm.network "private_network", ip: IP_PREFIX + "#{IP_START}"
    
      master.vm.provider :virtualbox do |v|
        v.name    = "k8s-control-#{i}"
        v.memory  = 4048
        v.cpus    =  2
      end
      master.vm.provision "shell", path: "scripts/bootstrap_k8s_control.sh"
      master.vm.provision "shell" , run: "always", path: "scripts/bootstrap_k8s_start.sh"
    end
  end

  (1..NODE).each do |i|
    config.vm.define "k8s-node-#{i}" do |node|
      node.vm.box               = IMAGE
      node.vm.hostname          = "k8s-node-#{i}.labs.com.br"
      node.vm.network "private_network", ip: IP_PREFIX + "#{IP_START + i}"

      node.vm.provider :virtualbox do |v|
        v.name    = "k8s-node-#{i}"
        v.memory  = 2048
        v.cpus    = 2
      end
      node.vm.provision "shell", path: "scripts/bootstrap_k8s_node.sh"
    end
  end
end