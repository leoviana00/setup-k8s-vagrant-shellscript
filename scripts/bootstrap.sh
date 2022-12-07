#!/bin/bash

echo "[TASK 01] - DESABILITAR O USO DE SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

echo "[TASK 02] - DESATIVAR O FIREWALL"
systemctl disable --now ufw >/dev/null 2>&1

echo "[TASK 03] - HABILITAR OS MODULOS DO KERNEL"
cat >>/etc/modules-load.d/containerd.conf<<EOF
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter

echo "[TASK 04] - CONFIGURAR OS MODULOS DO KERNEL"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF
sysctl --system >/dev/null 2>&1

echo "[TASK 05] - INSTALAÇÃO DOCKER"
curl -fsSL https://get.docker.com | bash >/dev/null 2>&1
usermod -aG docker ${USER}
chmod 777 /var/run/docker.sock
usermod -aG docker vagrant

cat >>/etc/docker/daemon.json<<EOF
{
  "insecure-registries" : ["192.168.10.30:5000","192.168.10.30:5001"]
}
EOF
systemctl daemon-reload
systemctl restart docker

echo "[TASK 06] - ADICIONAR O REPOSITÓRIO DO KUBERNETES"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - >/dev/null 2>&1
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" >/dev/null 2>&1

echo "[TASK 07] - INSTALAR O KUBEADM, KUBELET E KUBECTL"
apt install -qq -y kubeadm=1.21.7-00 kubelet=1.21.7-00 kubectl=1.21.7-00 >/dev/null 2>&1

echo "[TASK 08] - HABILITAR A AUTENTICAÇÃO COM SSH"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

echo "[TASK 09] - DEFINIR A SENHA DO ROOT"
echo -e "pulse\npulse" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bash.bashrc

echo "[TASK 10] - ALTERAR O ARQUIVO /etc/hosts"
cat >>/etc/hosts<<EOF
172.16.16.100   k8s-control-1.labs.com.br    k8s-control-1
172.16.16.101   k8s-node-1.labs.com.br       k8s-node-1
172.16.16.102   k8s-node-2.labs.com.br       k8s-node-2
EOF