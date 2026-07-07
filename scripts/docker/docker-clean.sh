#!/bin/bash

# Docker Clean Script
# Elimina imágenes, contenedores y volúmenes huérfanos de forma segura

set -e

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "🧹 Docker Clean - Limpiando recursos huérfanos..."
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

# 1. Limpiar contenedores detenidos
echo "1. Limpiando contenedores detenidos..."
STOPPED_CONTAINERS=$(docker ps -aq -f status=exited)
if [ -n "$STOPPED_CONTAINERS" ]; then
    print_action "Eliminando contenedores detenidos..."
    docker rm $STOPPED_CONTAINERS
    print_result 0 "Contenedores detenidos eliminados"
else
    echo -e "${GREEN}✓${NC} No hay contenedores detenidos"
fi
echo ""

# 2. Limpiar imágenes huérfanas (dangling)
echo "2. Limpiando imágenes huérfanas (dangling)..."
DANGLING_IMAGES=$(docker images -q -f dangling=true)
if [ -n "$DANGLING_IMAGES" ]; then
    print_action "Eliminando imágenes huérfanas..."
    docker rmi $DANGLING_IMAGES
    print_result 0 "Imágenes huérfanas eliminadas"
else
    echo -e "${GREEN}✓${NC} No hay imágenes huérfanas"
fi
echo ""

# 3. Limpiar volúmenes huérfanos
echo "3. Limpiando volúmenes huérfanos..."
ORPHAN_VOLUMES=$(docker volume ls -q -f dangling=true)
if [ -n "$ORPHAN_VOLUMES" ]; then
    print_action "Eliminando volúmenes huérfanos..."
    docker volume rm $ORPHAN_VOLUMES
    print_result 0 "Volúmenes huérfanos eliminados"
else
    echo -e "${GREEN}✓${NC} No hay volúmenes huérfanos"
fi
echo ""

# 4. Limpiar redes no utilizadas
echo "4. Limpiando redes no utilizadas..."
UNUSED_NETWORKS=$(docker network ls -q --filter "type=custom" --filter "driver=bridge" | xargs -r docker network inspect --format='{{.Name}} {{.Containers}}' | grep -w '0$' | awk '{print $1}')
if [ -n "$UNUSED_NETWORKS" ]; then
    print_action "Eliminando redes no utilizadas..."
    docker network rm $UNUSED_NETWORKS
    print_result 0 "Redes no utilizadas eliminadas"
else
    echo -e "${GREEN}✓${NC} No hay redes no utilizadas"
fi
echo ""

# 5. Limpiar build cache
echo "5. Limpiando cache de build..."
print_action "Limpiando cache de build..."
docker builder prune -f
print_result 0 "Cache de build limpiada"
echo ""

# Opción de limpieza profunda
echo "6. Limpieza profunda (opcional)..."
echo -e "${YELLOW}Esto eliminará todas las imágenes no utilizadas y volúmenes no utilizados.${NC}"
confirm_action "¿Deseas realizar una limpieza profunda?"

print_action "Eliminando imágenes no utilizadas..."
docker image prune -a -f
print_result 0 "Imágenes no utilizadas eliminadas"

print_action "Eliminando volúmenes no utilizados..."
docker volume prune -f
print_result 0 "Volúmenes no utilizados eliminados"

echo ""
echo "🏁 Limpieza completada"
echo ""
echo "Resumen de espacio liberado:"
docker system df
