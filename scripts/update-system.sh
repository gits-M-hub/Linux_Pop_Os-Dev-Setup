#!/usr/bin/env bash

echo "Actualizando repositorios..."
sudo apt update

echo "Actualizando paquetes..."
sudo apt full-upgrade -y

echo "Eliminando paquetes innecesarios..."
sudo apt autoremove -y

echo "Limpiando caché..."
sudo apt autoclean

echo "Sistema actualizado."
