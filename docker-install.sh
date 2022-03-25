 #!/bin/bash

curl https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_1.5.11-1_amd64.deb

curl https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_20.10.9~3-0~ubuntu-bionic_amd64.deb

curl https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_20.10.9~3-0~ubuntu-bionic_amd64.deb

sudo dpkg -i docker-ce_20.10.9~3-0~ubuntu-bionic_amd64.deb
sudo dpkg -i docker-ce-cli_20.10.9~3-0~ubuntu-bionic_amd64.deb
sudo dpkg -i containerd.io_1.5.11-1_amd64.deb
