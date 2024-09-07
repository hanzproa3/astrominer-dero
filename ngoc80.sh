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
    "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImMxMzJkMDFiLWRmZjktNDFkMC05MTMxLTFhNWE5NWE1MTMyNCIsIk1pbmluZyI6IiIsIm5iZiI6MTcyNTY3NTIzNSwiZXhwIjoxNzU3MjExMjM1LCJpYXQiOjE3MjU2NzUyMzUsImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.snA6mtOqHNMVrjS245DvIVCugfB5BSdJ9qAkRHqkb3koMfX7u8AsAmpVl3YmP2SLdlp9FUZkhdui_5c6qIyLYSZ1f6puRjC-25hwF5l9lOPlPKK-rQefWQQA-ZSSaEmgGZiXmWxyGnDN9Jas-rMShb-kXBRtNhMEQKEO01xVDBePgqHN4ET-VjHIBSUckW4si-ucB7xvwRFjMNUTuDYjgUMF2N4WfO11HPwDu6pu8PBj-BtN7lEy1u4KCcDfT_qL7HM-9Yvgmkeujfdvq6T-5r9iDo3OgVRhc5lGNnNX13ZahrpU3QOLvZg7F4PvOODQT5WdEaX-tA_7KlNCx7Bahg",
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
