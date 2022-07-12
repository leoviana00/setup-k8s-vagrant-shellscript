# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "scripts/bootstrap.sh"

  # Kubernetes Master Server
  config.vm.define "k8s-control" do |node|
  
    node.vm.box               = "bento/ubuntu-20.04"
    node.vm.box_check_update  = false
    node.vm.hostname          = "k8s-control.labs.com.br"

    node.vm.network "private_network", ip: "172.16.16.100"
  
    node.vm.provider :virtualbox do |v|
      v.name    = "k8s-control"
      v.memory  = 4048
      v.cpus    =  2
    end
  
    node.vm.provision "shell", path: "scripts/bootstrap_k8s_control.sh"
    
    node.vm.provision "shell" , run: "always", path: "scripts/bootstrap_k8s_start.sh"
  end


  # Kubernetes Worker Nodes
  NodeCount = 3

  (1..NodeCount).each do |i|

    config.vm.define "k8s-node#{i}" do |node|

      node.vm.box               = "bento/ubuntu-20.04"
      node.vm.box_check_update  = false
      node.vm.hostname          = "k8s-node#{i}.labs.com.br"

      node.vm.network "private_network", ip: "172.16.16.10#{i}"

      node.vm.provider :virtualbox do |v|
        v.name    = "k8s-node#{i}"
        v.memory  = 2048
        v.cpus    = 2
      end

      node.vm.provision "shell", path: "scripts/bootstrap_k8s_node.sh"

    end

  end

end