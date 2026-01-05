#!/bin/bash
echo "Installing Linux build tools..."
sudo apt-get update
sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev

echo "----------------------------------------------------------------"
echo "Build tools installed. Now try running: flutter run -d linux"
echo "----------------------------------------------------------------"
