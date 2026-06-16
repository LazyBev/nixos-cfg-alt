#!/usr/bin/env bash

ID=$(grep -oP '(?<=^ID=).*' /etc/os-release 2>/dev/null | tr -d '"')

case "$ID" in
  nixos)      icon="" ;;
  arch|artix) icon="" ;;
  ubuntu)     icon="" ;;
  fedora)     icon="" ;;
  debian)     icon="" ;;
  alpine)     icon="" ;;
  centos)     icon="" ;;
  manjaro)    icon="" ;;
  linuxmint)  icon="" ;;
  opensuse)   icon="" ;;
  pop)        icon="" ;;
  rhel)       icon="" ;;
  solus)      icon="" ;;
  void)       icon="" ;;
  endeavouros)icon="" ;;
  gentoo)     icon="" ;;
  kali)       icon="" ;;
  slackware)  icon="" ;;
  garuda)     icon="" ;;
  *)          icon="" ;;
esac

echo "$icon"
