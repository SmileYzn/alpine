#!/bin/bash

# Limpar
clear

# Verificar acesso root
if [[ $EUID -eq 0 ]]; then
    echo -e "Esse script NÃO deve ser executado como ${USER}"
    exit
fi

# Abrir pasta do usuário
cd /home/$(whoami)

# Instalar SUDO, habilitar grupo wheel e adicionar usuário ao grupo wheel
su root -c "apk update && apk add --no-cache sudo && echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel && addgroup $(whoami) wheel"

# Atualizar sistema
sudo apk update

# Base
sudo apk add --no-cache 7zip bash-completion fastfetch fwupd ffmpeg ffmpegthumbnailer git gtk-update-icon-cache musl-locales musl-locales-lang nano networkmanager networkmanager-wifi network-manager-applet pipewire pipewire-pulse power-profiles-daemon powertop shadow udisks2 unzip util-linux wireplumber xz zip

# Language for MUSL
echo 'export LANG=pt_BR.UTF-8' | sudo tee /etc/profile.d/locale.sh
echo 'export LC_ALL=pt_BR.UTF-8' | sudo tee -a /etc/profile.d/locale.sh

# XDG Portal
sudo apk add --no-cache xdg-user-dirs xdg-user-dirs-gtk xdg-desktop-portal xdg-desktop-portal-gtk xdg-utils

# CIFS, EXFAT, GVFS, NTFS
sudo apk add --no-cache cifs-utils exfat-utils gvfs gvfs-afc gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb ntfs-3g

# Adobe Font
sudo apk add --no-cache font-adobe-source-code-pro

# Noto Font
sudo apk add --no-cache font-noto font-noto-cjk font-noto-emoji font-noto-extra

# Adwaita
sudo apk add --no-cache adwaita-fonts adwaita-fonts-mono adwaita-fonts-sans

# Other
sudo apk add --no-cache font-dejavu font-droid font-fira font-inconsolata font-opensans font-roboto font-terminus

# Atualizar o chace de fontes
sudo fc-cache -f -v

# XFCE4
sudo apk add --no-cache xfce4-appfinder xfce4-notifyd xfce-polkit xfce4-screensaver xfce4-screenshooter xfce4-taskmanager xfce4-terminal

# XFCE4 Plugins
sudo apk add --no-cache \
xfce4-battery-plugin \
xfce4-calculator-plugin \
xfce4-clipman-plugin \
xfce4-cpufreq-plugin \
xfce4-cpugraph-plugin \
xfce4-diskperf-plugin \
xfce4-docklike-plugin \
xfce4-fsguard-plugin \
xfce4-genmon-plugin \
xfce4-mailwatch-plugin \
xfce4-mpc-plugin \
xfce4-netload-plugin \
xfce4-notes-plugin \
xfce4-places-plugin \
xfce4-pulseaudio-plugin \
xfce4-sensors-plugin \
xfce4-smartbookmark-plugin \
xfce4-statusnotifier-plugin \
xfce4-stopwatch-plugin \
xfce4-systemload-plugin \
xfce4-timer-plugin \
xfce4-verve-plugin \
xfce4-wavelan-plugin \
xfce4-weather-plugin \
xfce4-whiskermenu-plugin \
xfce4-xkb-plugin

# Thunar
sudo apk add --no-cache font-manager-thunar thunar thunar-archive-plugin thunar-media-tags-plugin thunar-vcs-plugin thunar-vcs-plugin

# Adwaita
sudo apk add --no-cache adwaita-icon-theme adwaita-fonts adwaita-fonts-mono adwaita-fonts-sans adwaita-xfce-icon-theme adw-gtk3

# Apps
sudo apk add --no-cache mate-calc gcolor3 gthumb mousepad mugshot parole pavucontrol peek seahorse xarchiver xfburn

# Firefox
sudo apk add --no-cache firefox firefox-intl

# GStreamer
sudo apk add gstreamer gst-libav gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly

# Abrir pasta do usuário
cd /home/$(whoami)

# Criar pastas padrão
xdg-user-dirs-update

# Criar pastas
mkdir Desktop Documentos Downloads Imagens Modelos Músicas Projetos Rede Vídeos

# Alterar pastas
xdg-user-dirs-update --force --set DESKTOP /home/$(whoami)/Desktop
xdg-user-dirs-update --force --set DOCUMENTS /home/$(whoami)/Documentos
xdg-user-dirs-update --force --set DOWNLOAD /home/$(whoami)/Downloads
xdg-user-dirs-update --force --set PICTURES /home/$(whoami)/Imagens
xdg-user-dirs-update --force --set TEMPLATES /home/$(whoami)/Modelos
xdg-user-dirs-update --force --set MUSIC /home/$(whoami)/Músicas
xdg-user-dirs-update --force --set PROJECTS /home/$(whoami)/Projetos
xdg-user-dirs-update --force --set PUBLICSHARE /home/$(whoami)/Rede
xdg-user-dirs-update --force --set VIDEOS /home/$(whoami)/Vídeos

# Atualizar pastas padrão
xdg-user-dirs-update

# Remover pastas antigas
rm -rf Documents Music Pictures Projects Public Templates Videos

# Grupos do usuário
sudo addgroup autologin

# Adicionar aos grupos
sudo adduser $(whoami) autologin
sudo adduser $(whoami) plugdev

# Limpar histórico
history -c && > ~/.bash_history

# Fim
exit
