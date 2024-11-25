#!/bin/bash

# Menampilkan ASCII Art
echo "######################################"
echo "#        SHARE IT HUB Setup         #"
echo "#        By GlacierNetwork          #"
echo "######################################"
echo ""
echo "███████ ██   ██  █████  ██████  ███████     ██ ████████     ██   ██ ██    ██ ██████      "
echo "██      ██   ██ ██   ██ ██   ██ ██          ██    ██        ██   ██ ██    ██ ██   ██     "
echo "███████ ███████ ███████ ██████  █████       ██    ██        ███████ ██    ██ ██████      "
echo "     ██ ██   ██ ██   ██ ██   ██ ██          ██    ██        ██   ██ ██    ██ ██   ██     "
echo "███████ ██   ██ ██   ██ ██   ██ ███████     ██    ██        ██   ██  ██████  ██████      "
echo ""
echo "Masukkan PRIVATE_KEY Anda:"

# Meminta input untuk PRIVATE_KEY
read PRIVATE_KEY

# Cek apakah kontainer glacier-verifier ada
if sudo docker ps -a --format '{{.Names}}' | grep -q "glacier-verifier"; then
    echo "Stopping the glacier-verifier container..."
    sudo docker stop glacier-verifier && \
    echo "Removing the glacier-verifier container..." && \
    sudo docker rm glacier-verifier
else
    echo "Kontainer glacier-verifier tidak ditemukan. Melanjutkan ke langkah berikutnya."
fi

# Cek apakah image glacier-verifier:v0.0.1 ada sebelum mencoba menghapus
if sudo docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "glaciernetwork/glacier-verifier:v0.0.1"; then
    echo "Removing the old image glaciernetwork/glacier-verifier:v0.0.1..."
    sudo docker rmi glaciernetwork/glacier-verifier:v0.0.1
else
    echo "Image glaciernetwork/glacier-verifier:v0.0.1 tidak ditemukan. Melanjutkan ke langkah berikutnya."
fi

# Menarik (pull) image terbaru jika belum ada di lokal
if ! sudo docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "glaciernetwork/glacier-verifier:v0.0.2"; then
    echo "Image glacier-verifier:v0.0.2 tidak ditemukan di lokal. Menarik image dari Docker Hub..."
    sudo docker pull glaciernetwork/glacier-verifier:v0.0.2
else
    echo "Image glacier-verifier:v0.0.2 sudah ada di lokal. Melanjutkan ke langkah berikutnya."
fi

# Jalankan kontainer dengan image terbaru
echo "Running the new glacier-verifier container..."
sudo docker run -d -e PRIVATE_KEY="$PRIVATE_KEY" --name glacier-verifier docker.io/glaciernetwork/glacier-verifier:v0.0.2
