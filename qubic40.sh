#!/bin/bash

# Create directory /qubic and navigate into it
mkdir /qubic && cd /qubic

# Download qli-Client-2.1.3-Linux-x64.tar.gz from the specified URL and extract it
wget https://dl.qubic.li/downloads/qli-Client-2.1.3-Linux-x64.tar.gz && tar -xvf qli-Client-2.1.3-Linux-x64.tar.gz

# Remove appsettings.json if it exists
rm -f appsettings.json

# Get the hostname of the machine
hostname=$(hostname)

# Write the content to appsettings.json with the hostname variable
cat > appsettings.json <<EOF
{
  "Settings": {
    "baseUrl": "https://wps.qubic.li",
    "alias": "$hostname",
    "trainer": {
      "cpu": true,
      "gpu": false,
      "gpuVersion": "CUDA12",
      "cpuVersion": "AVX2",
      "cpuThreads": 40
    },
    "isPps": true,
    "useLiveConnection": true,
    "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjIxMThiMjhlLTQxNTktNDM5Yy05MWMzLTFiZWI1YTQxYjQyZiIsIk1pbmluZyI6IiIsIm5iZiI6MTcyNTY0MDEwNywiZXhwIjoxNzU3MTc2MTA3LCJpYXQiOjE3MjU2NDAxMDcsImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.UgOJMMyQgIYg0MwZhUZGOtTLbmM2bBTpYviNU3L18WlJ3DK9eUhqjX8CaBvx5N4YPisP4RJ2pZC7CjoUqyWOyQ8-WAt67ogsVlTzbK6yUG3q3YoPfCo5otuGSHWuxmBf0meEM_lW6_FPSvMZBl475LnklhB_3HsNdXxd7GFLICKQzw7SoKwKPEvrDnbSKThfe7Lq8Ppe5uBRXslVRdZKs-yWkH54UpiY9RJ2taKIYkmNr4tFDLJhuaizo-bUbq7aJHu5b1L3gKry9MFJC3rc7UQ4X24qlX5Gv-nwcY1V1YuTn_T6T0-0i9YVfAoD0FtBO7aAUov08qlphjeWaKxaDw",
    "idleSettings": null
  }
}
EOF

# Open the qubic.service file for editing in nano
nano /etc/systemd/system/qubic.service

# Add the following content to the qubic.service file
cat > /etc/systemd/system/qubic.service <<EOL
[Unit]
Description=QUBIC

[Service]
WorkingDirectory=/qubic
ExecStart=/qubic/qli-Client
Restart=always
RestartSec=10
KillSignal=SIGINT

[Install]
WantedBy=multi-user.target
EOL
