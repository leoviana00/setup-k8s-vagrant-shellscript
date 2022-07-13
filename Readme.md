<h1 align="center">Setup Kubernetes </h1>

<p align="center">
  <img alt="Shell" src="https://img.shields.io/static/v1?label=K8S&message=Shell&color=8257E5&labelColor=000000"  />
  <img alt="Vagrant" src="https://img.shields.io/static/v1?label=K8S&message=Vagrant&color=8257E5&labelColor=000000"  />
  <img alt="License" src="https://img.shields.io/static/v1?label=license&message=MIT&color=49AA26&labelColor=000000">
</p>

## 🌱 Project

- Setup kubernetes com shell script, vagrant e virtualbox.

## 🗒 Pré requisitos

- vagrant
- virtualbox

## ✨ Ferramentas utilizadas

- Vagrant
- Kubernetes
- Virtualbox
- VsCode

## Arquitetura

- 1 Master
- 3 Nodes

## 🚀 Execução
1. Instalação dos pré-requisitos:

```bash
make requirements
```

2. Subir ambiente

```bash
make setup
```

<p align="center">
  <img alt="script" src="images/k8s-script.png">
</p>

3. Remover o ambiente

```bash
make destroy -f
```

4. Parar o ambiente

```bash
make halt
```

## 📄 Licença
Esse projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.