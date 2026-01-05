#!/bin/bash

# 1. Update and install dependencies
echo "Installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# 2. Clone Flutter SDK
# We install it in $HOME/development (standard practice) or just $HOME
INSTALL_DIR="$HOME/development"
mkdir -p "$INSTALL_DIR"

echo "Cloning Flutter SDK to $INSTALL_DIR..."
if [ ! -d "$INSTALL_DIR/flutter" ]; then
    git clone https://github.com/flutter/flutter.git -b stable "$INSTALL_DIR/flutter"
else
    echo "Flutter already exists in $INSTALL_DIR/flutter"
fi

# 3. Add to PATH (Temporary for this session and Permanent for .bashrc)
echo "Configuring PATH..."
export PATH="$PATH:$INSTALL_DIR/flutter/bin"

if ! grep -q "flutter/bin" "$HOME/.bashrc"; then
    echo "Adding flutter to .bashrc..."
    echo "" >> "$HOME/.bashrc"
    echo "# Flutter SDK" >> "$HOME/.bashrc"
    echo "export PATH=\"\$PATH:$INSTALL_DIR/flutter/bin\"" >> "$HOME/.bashrc"
    echo "Added to .bashrc. restart terminal or run 'source ~/.bashrc' to make it permanent."
fi

# 4. Run Doctor
echo "Running flutter doctor..."
flutter doctor

echo "----------------------------------------------------------------"
echo "Installation Complete!"
echo "You can now run 'flutter run' in your project directory."
echo "----------------------------------------------------------------"
