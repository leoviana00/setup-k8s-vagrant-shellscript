#!/bin/bash

echo "[TASK 01] - STATUS DOS SERVIÇOS"

export KUBECONFIG=/etc/kubernetes/admin.conf

echo "DOCKER"
systemctl status docker | grep "Active:"
echo "CONTAINERD"
systemctl status containerd | grep "Active:"
echo "K8S"
systemctl status kubelet | grep "Active:"

echo "[TASK 02] - INFORMAÇÕES DO CLUSTER"
kubectl cluster-info

echo "[TASK 03] - LISTAR TUDO"
kubectl get all --all-namespaces

echo "[TASK 04] - LISTAR NODES K8S..."
kubectl get nodes

echo "[TASK 05] - LISTAR TODOS OS NAMESPACES PADRÃO"
kubectl get ns