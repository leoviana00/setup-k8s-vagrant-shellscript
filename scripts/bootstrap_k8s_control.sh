#!/bin/bash

NODENAME=$(hostname -s)

echo "[TASK 01] - INICIALIZAR O KUBERNETES"
kubeadm init --apiserver-advertise-address=172.16.16.100 --apiserver-cert-extra-sans=172.16.16.100 --pod-network-cidr=192.168.0.0/16 --node-name "$NODENAME">> /root/kubeinit.log 2>/dev/null

echo "[TASK 02] - INSTALAR O CALICO"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.18/manifests/calico.yaml >/dev/null 2>&1

echo "[TASK 03] - GERAR O COMANDO DE JOIN DOS NODES"
kubeadm token create --print-join-command > /joincluster.sh 2>/dev/null

echo "[TASK 04] - COPIANDO OS ARQUIVOS DE CONFIGURAÇÃO "kubectl" PARA O DIRETÓRIO HOME"
mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown vagrant:$(id -g) /home/vagrant/.kube/config

export KUBECONFIG=/etc/kubernetes/admin.conf