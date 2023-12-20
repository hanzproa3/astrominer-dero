#bin/bash

wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update && sudo apt-get install -y dotnet-sdk-6.0 aspnetcore-runtime-6.0 libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev libzstd-dev curl libsnappy-dev libc-dev libc6-dev libc6 unzip git make g++ build-essential libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev
