#!/bin/bash

# Menampilkan ASCII Art
echo "######################################"
echo "#        SHARE IT HUB Setup         #"
echo "#        By GlacierNetwork          #"
echo "######################################"
echo ""
echo "  SSSSS  H   H   AAAAA  RRRRR   EEEEE     III  TTTTT    H   H  U   U  BBBBB  "
echo " S       H   H  A     A R   R  E          I     T      H   H  U   U  B    B "
echo "  SSS    HHHHH  AAAAAAA RRRRR  EEEE       I     T      HHHHH  U   U  BBBBB  "
echo "     S   H   H  A     A R  R   E          I     T      H   H  U   U  B    B "
echo " SSSSS   H   H  A     A R   R  EEEEE     III    T      H   H  UUUU   BBBBB  "
echo ""
echo "Masukkan PRIVATE_KEY Anda:"

# Meminta input untuk PRIVATE_KEY
read PRIVATE_KEY

# Stop container glacier-verifier
echo "Stopping the glacier-verifier container..."
sudo docker stop glacier-verifier && \

# Remove container glacier-verifier
echo "Removing the glacier-verifier container..."
sudo docker rm glacier-verifier && \

# Remove the image glaciernetwork/glacier-verifier:v0.0.1
echo "Removing the old image glaciernetwork/glacier-verifier:v0.0.1..."
sudo docker rmi glaciernetwork/glacier-verifier:v0.0.1 && \

# Run the new container with the user input PRIVATE_KEY
echo "Running the new glacier-verifier container..."
sudo docker run -d -e PRIVATE_KEY="$PRIVATE_KEY" --name glacier-verifier docker.io/glaciernetwork/glacier-verifier:v0.0.2
