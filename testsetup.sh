#!/bin/bash

set -e

# --- Schritt 1: Erste Einrichtung ---
sudo apt update && sudo apt upgrade -y && sudo snap refresh

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
sudo apt install -y htop git curl vim vlc 

# --- Schritt 3: Snap Anwendungen installieren ---
sudo snap install code --classic
