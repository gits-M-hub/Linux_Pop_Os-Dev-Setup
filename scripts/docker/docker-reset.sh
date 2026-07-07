#!/bin/bash

# Docker Reset Script
# Deja Docker en un estado limpio para empezar nuevas pruebas

set -e

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "🔄 Docker Reset - Reiniciando Docker a estado limpio..."
echo ""

# Función para confirmar acción
confirm_action() {
    read -p "$1 (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Acción cancelada${NC}"
        exit 0
    fi
}

# Función para imprimir acción
print_action() {
    echo -e "${BLUE}➜${NC} $1"
}

# Función para imprimir resultado
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
    fi
}

# ADVERTENCIA IMPORTANTE
echo -e "${RED}⚠️  ADVERTENCIA: Este script eliminará TODOS los contenedores, imágenes, volúmenes y redes de Docker.${NC}"
echo -e "${RED}⚠️  Esta acción es irreversible y perderás todos los datos de Docker.${NC}"
echo ""
confirm_action "¿Estás seguro de que quieres continuar con el reset de Docker?"

echo ""
echo "1. Deteniendo todos los contenedores en ejecución..."
RUNNING_CONTAINERS=$(docker ps -q)
if [ -n "$RUNNING_CONTAINERS" ]; then
    print_action "Deteniendo contenedores..."
    docker stop $RUNNING_CONTAINERS
    print_result 0 "Contenedores detenidos"
else
    echo -e "${GREEN}✓${NC} No hay contenedores en ejecución"
fi
echo ""

echo "2. Eliminando todos los contenedores..."
ALL_CONTAINERS=$(docker ps -aq)
if [ -n "$ALL_CONTAINERS" ]; then
    print_action "Eliminando contenedores..."
    docker rm -f $ALL_CONTAINERS
    print_result 0 "Contenedores eliminados"
else
    echo -e "${GREEN}✓${NC} No hay contenedores"
fi
echo ""

echo "3. Eliminando todas las imágenes..."
ALL_IMAGES=$(docker images -q)
if [ -n "$ALL_IMAGES" ]; then
    print_action "Eliminando imágenes..."
    docker rmi -f $ALL_IMAGES
    print_result 0 "Imágenes eliminadas"
else
    echo -e "${GREEN}✓${NC} No hay imágenes"
fi
echo ""

echo "4. Eliminando todos los volúmenes..."
ALL_VOLUMES=$(docker volume ls -q)
if [ -n "$ALL_VOLUMES" ]; then
    print_action "Eliminando volúmenes..."
    docker volume rm -f $ALL_VOLUMES
    print_result 0 "Volúmenes eliminados"
else
    echo -e "${GREEN}✓${NC} No hay volúmenes"
fi
echo ""

echo "5. Eliminando todas las redes personalizadas..."
CUSTOM_NETWORKS=$(docker network ls -q --filter "type=custom")
if [ -n "$CUSTOM_NETWORKS" ]; then
    print_action "Eliminando redes personalizadas..."
    docker network rm $CUSTOM_NETWORKS
    print_result 0 "Redes personalizadas eliminadas"
else
    echo -e "${GREEN}✓${NC} No hay redes personalizadas"
fi
echo ""

echo "6. Limpiando cache de build..."
print_action "Limpiando cache de build..."
docker builder prune -af
print_result 0 "Cache de build limpiada"
echo ""

echo "7. Limpiando sistema completo..."
print_action "Limpiando sistema completo..."
docker system prune -af --volumes
print_result 0 "Sistema limpiado completamente"
echo ""

echo "8. Reiniciando Docker daemon..."
print_action "Reiniciando Docker daemon..."
if command -v systemctl &> /dev/null; then
    sudo systemctl restart docker
    print_result 0 "Docker daemon reiniciado"
else
    echo -e "${YELLOW}⚠️  No se pudo reiniciar Docker daemon automáticamente (no systemctl)${NC}"
    echo -e "${YELLOW}Reinicia Docker manualmente si es necesario${NC}"
fi
echo ""

echo "🏁 Docker reset completado"
echo ""
echo "Docker ahora está en un estado limpio."
echo "Puedes verificar el estado ejecutando: ./docker-doctor.sh"
