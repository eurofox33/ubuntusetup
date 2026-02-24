#!/bin/bash

set -e

# UFW aktvieren
sudo ufw enable

# --- Schritt 1: Erste Einrichtung ---
sudo apt update && sudo apt upgrade -y && sudo snap refresh

# Uhrzeit für Dual Boot konfigurieren
timedatectl set-local-rtc 1

# Gnome Settings
# Dynamische Workspaces deaktivieren, damit die Anzahl fix bleibt
gsettings set org.gnome.mutter dynamic-workspaces false

# Anzahl der virtuellen Desktops auf 5 setzen
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5

# ALT+1 bis ALT+5 zum Wechseln der virtuellen Desktops belegen
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Alt>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Alt>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Alt>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Alt>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Alt>5']"

# --- Schritt 2: Die gewünschten Anwendungen installieren ---
sudo apt install -y htop nvtop git curl vim python3-venv vlc yt-dlp libreoffice obs-studio

# --- Schritt 3: Snap Anwendungen installieren ---
sudo snap install brave discord
sudo snap install code --classic

# --- Schritt 4: pyenv installieren ---
curl -fsSL https://pyenv.run | bash

# Set up your shell environment for Pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init - bash)"' >> ~/.bashrc

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init - bash)"' >> ~/.profile

# Install Python build dependencies
sudo apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# --- Schritt 5: yt-dlp installieren ---
mkdir ~/.local/bin
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o ~/.local/bin/yt-dlp
chmod +x ~/.local/bin/yt-dlp

# --- Schritt 6: Docker einrichten ---
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER
