#!/bin/bash

# Docker Backup Volumes Script
# Realiza copias de seguridad de volúmenes importantes de Docker

set -e

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuración
BACKUP_DIR="${BACKUP_DIR:-./backups/docker}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS=${RETENTION_DAYS:-7}

echo "💾 Docker Backup Volumes - Creando copias de seguridad de volúmenes..."
echo ""

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

# Crear directorio de backup
print_action "Creando directorio de backup: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
print_result 0 "Directorio de backup creado"

echo ""
echo "1. Listando volúmenes disponibles..."
VOLUMES=$(docker volume ls -q --format "{{.Name}}")
VOLUME_COUNT=$(echo "$VOLUMES" | wc -l)

if [ -z "$VOLUMES" ]; then
    echo -e "${YELLOW}⚠️  No hay volúmenes para respaldar${NC}"
    exit 0
fi

echo -e "${GREEN}✓${NC} Encontrados $VOLUME_COUNT volúmenes:"
echo "$VOLUMES" | nl
echo ""

# Preguntar si quiere respaldar todos o seleccionar
read -p "¿Respaldar todos los volúmenes? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Selecciona los volúmenes a respaldar (separados por espacio):"
    read VOLUMES_TO_BACKUP
    VOLUMES=$(echo $VOLUMES_TO_BACKUP)
fi

echo ""
echo "2. Iniciando backup de volúmenes..."
BACKUP_SUCCESS=0
BACKUP_FAILED=0

for VOLUME in $VOLUMES; do
    print_action "Respaldando volumen: $VOLUME"
    
    # Crear nombre del archivo de backup
    BACKUP_FILE="$BACKUP_DIR/${VOLUME}_${TIMESTAMP}.tar.gz"
    
    # Obtener información del contenedor que usa el volumen
    CONTAINER=$(docker ps -q --filter "volume=$VOLUME" --format "{{.Names}}" | head -n 1)
    
    if [ -n "$CONTAINER" ]; then
        # Método 1: Usar un contenedor temporal para respaldar el volumen
        docker run --rm \
            -v "$VOLUME:/volume_data:ro" \
            -v "$BACKUP_DIR:/backup" \
            alpine tar czf "/backup/$(basename $BACKUP_FILE)" -C /volume_data . 2>/dev/null
        
        if [ $? -eq 0 ]; then
            print_result 0 "Volumen $VOLUME respaldado: $BACKUP_FILE"
            ((BACKUP_SUCCESS++))
        else
            print_result 1 "Error al respaldar volumen $VOLUME"
            ((BACKUP_FAILED++))
        fi
    else
        # Método 2: El volumen no está en uso, usar docker cp directo
        TEMP_CONTAINER=$(docker run -d -v "$VOLUME:/volume_data" alpine sleep 100)
        docker cp "$TEMP_CONTAINER:/volume_data" "/tmp/$VOLUME" 2>/dev/null
        tar czf "$BACKUP_FILE" -C "/tmp/$VOLUME" . 2>/dev/null
        docker rm -f "$TEMP_CONTAINER" 2>/dev/null
        rm -rf "/tmp/$VOLUME" 2>/dev/null
        
        if [ $? -eq 0 ]; then
            print_result 0 "Volumen $VOLUME respaldado: $BACKUP_FILE"
            ((BACKUP_SUCCESS++))
        else
            print_result 1 "Error al respaldar volumen $VOLUME"
            ((BACKUP_FAILED++))
        fi
    fi
done

echo ""
echo "3. Limpiando backups antiguos (más de $RETENTION_DAYS días)..."
print_action "Eliminando backups antiguos..."
find "$BACKUP_DIR" -name "*.tar.gz" -type f -mtime +$RETENTION_DAYS -delete
print_result 0 "Backups antiguos eliminados"

echo ""
echo "🏁 Backup completado"
echo ""
echo "Resumen:"
echo -e "${GREEN}✓${NC} Backups exitosos: $BACKUP_SUCCESS"
if [ $BACKUP_FAILED -gt 0 ]; then
    echo -e "${RED}✗${NC} Backups fallidos: $BACKUP_FAILED"
fi
echo ""
echo "Backups guardados en: $BACKUP_DIR"
echo "Para restaurar un volumen, usa:"
echo "  docker run --rm -v <volume>:/volume_data -v <backup_dir>:/backup alpine tar xzf /backup/<backup_file> -C /volume_data"
