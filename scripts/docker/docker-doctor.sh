#!/bin/bash

# Docker Doctor Script
# Verifica si Docker, Docker Compose y BuildKit funcionan correctamente

set -e

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Docker Doctor - Verificando instalación de Docker..."
echo ""

# Función para imprimir estado
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
    fi
}

# Verificar Docker
echo "1. Verificando Docker..."
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version)
    print_status 0 "Docker instalado: $DOCKER_VERSION"
    
    # Verificar si Docker daemon está corriendo
    if docker info &> /dev/null; then
        print_status 0 "Docker daemon está corriendo"
    else
        print_status 1 "Docker daemon NO está corriendo"
        echo -e "${YELLOW}Intenta iniciar Docker con: sudo systemctl start docker${NC}"
    fi
else
    print_status 1 "Docker NO está instalado"
    echo -e "${YELLOW}Instala Docker desde: https://docs.docker.com/get-docker/${NC}"
fi
echo ""

# Verificar Docker Compose
echo "2. Verificando Docker Compose..."
if command -v docker-compose &> /dev/null; then
    COMPOSE_VERSION=$(docker-compose --version)
    print_status 0 "Docker Compose instalado: $COMPOSE_VERSION"
elif docker compose version &> /dev/null; then
    COMPOSE_VERSION=$(docker compose version)
    print_status 0 "Docker Compose (plugin) instalado: $COMPOSE_VERSION"
else
    print_status 1 "Docker Compose NO está instalado"
    echo -e "${YELLOW}Instala Docker Compose desde: https://docs.docker.com/compose/install/${NC}"
fi
echo ""

# Verificar BuildKit
echo "3. Verificando Docker BuildKit..."
if docker info 2>/dev/null | grep -q "BuildKit: true"; then
    print_status 0 "BuildKit está habilitado"
else
    print_status 1 "BuildKit NO está habilitado"
    echo -e "${YELLOW}Habilita BuildKit con: export DOCKER_BUILDKIT=1${NC}"
fi
echo ""

# Verificar grupos de usuario
echo "4. Verificando permisos de usuario..."
if groups | grep -q docker; then
    print_status 0 "Usuario está en el grupo docker"
else
    print_status 1 "Usuario NO está en el grupo docker"
    echo -e "${YELLOW}Añade tu usuario al grupo docker: sudo usermod -aG docker \$USER${NC}"
    echo -e "${YELLOW}Luego cierra sesión y vuelve a entrar${NC}"
fi
echo ""

# Verificar recursos del sistema
echo "5. Verificando recursos del sistema..."
DOCKER_INFO=$(docker info 2>/dev/null || echo "")

if [ -n "$DOCKER_INFO" ]; then
    # Verificar CPUs
    CPUS=$(echo "$DOCKER_INFO" | grep "CPUs:" | awk '{print $2}')
    print_status 0 "CPUs disponibles: $CPUS"
    
    # Verificar memoria
    TOTAL_MEM=$(echo "$DOCKER_INFO" | grep "Total Memory:" | awk '{print $3, $4}')
    print_status 0 "Memoria total: $TOTAL_MEM"
    
    # Verificar espacio en disco
    DISK_SPACE=$(echo "$DOCKER_INFO" | grep "Docker Root Dir" -A 5 | grep "Available Space" | awk '{print $4, $5}')
    print_status 0 "Espacio disponible: $DISK_SPACE"
else
    print_status 1 "No se pudo obtener información de recursos"
fi
echo ""

# Verificar contenedores en ejecución
echo "6. Verificando contenedores..."
RUNNING_CONTAINERS=$(docker ps -q 2>/dev/null | wc -l)
print_status 0 "Contenedores en ejecución: $RUNNING_CONTAINERS"

TOTAL_CONTAINERS=$(docker ps -aq 2>/dev/null | wc -l)
print_status 0 "Total de contenedores: $TOTAL_CONTAINERS"
echo ""

# Verificar imágenes
echo "7. Verificando imágenes..."
TOTAL_IMAGES=$(docker images -q 2>/dev/null | wc -l)
print_status 0 "Total de imágenes: $TOTAL_IMAGES"
echo ""

# Verificar volúmenes
echo "8. Verificando volúmenes..."
TOTAL_VOLUMES=$(docker volume ls -q 2>/dev/null | wc -l)
print_status 0 "Total de volúmenes: $TOTAL_VOLUMES"
echo ""

echo "🏁 Verificación completada"
