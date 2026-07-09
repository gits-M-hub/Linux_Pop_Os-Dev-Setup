#!/bin/bash

# Script de instalación de alias para linux-dev-setup
# Este script añade automáticamente las líneas necesarias al ~/.zshrc
# para cargar los alias de Git, Docker, PostgreSQL y herramientas

set -e

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Ruta del proyecto
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ALIASES_DIR="$PROJECT_DIR/configs/aliases"

echo -e "${BLUE}🔧 Instalando alias de linux-dev-setup...${NC}"
echo ""

# Verificar que el directorio de alias existe
if [ ! -d "$ALIASES_DIR" ]; then
    echo -e "${RED}❌ Error: No se encontró el directorio de aliases en $ALIASES_DIR${NC}"
    exit 1
fi

# Archivo de configuración de Zsh
ZSHRC="$HOME/.zshrc"

# Crear backup del .zshrc
BACKUP_FILE="$ZSHRC.backup.$(date +%Y%m%d_%H%M%S)"
echo -e "${YELLOW}📦 Creando backup de ~/.zshrc en $BACKUP_FILE${NC}"
cp "$ZSHRC" "$BACKUP_FILE"

# Función para añadir línea si no existe
add_line_if_not_exists() {
    local line="$1"
    local file="$2"
    
    if ! grep -qF "$line" "$file" 2>/dev/null; then
        echo "$line" >> "$file"
        echo -e "${GREEN}✓${NC} Añadido: $line"
        return 0
    else
        echo -e "${YELLOW}⊘${NC} Ya existe: $line"
        return 1
    fi
}

# Añadir encabezado de linux-dev-setup
if ! grep -q "# linux-dev-setup aliases" "$ZSHRC" 2>/dev/null; then
    echo "" >> "$ZSHRC"
    echo "# ==========================" >> "$ZSHRC"
    echo "# linux-dev-setup aliases" >> "$ZSHRC"
    echo "# ==========================" >> "$ZSHRC"
    echo "" >> "$ZSHRC"
    echo -e "${GREEN}✓${NC} Añadido encabezado de linux-dev-setup"
else
    echo -e "${YELLOW}⊘${NC} El encabezado de linux-dev-setup ya existe"
fi

echo ""
echo "Añadiendo archivos de alias..."

# Añadir cada archivo de alias
add_line_if_not_exists "source $ALIASES_DIR/git.zsh" "$ZSHRC"
add_line_if_not_exists "source $ALIASES_DIR/docker.zsh" "$ZSHRC"
add_line_if_not_exists "source $ALIASES_DIR/postgres.zsh" "$ZSHRC"
add_line_if_not_exists "source $ALIASES_DIR/tools.zsh" "$ZSHRC"

echo ""
echo -e "${GREEN}✅ Instalación completada${NC}"
echo ""
echo "Los alias se cargarán automáticamente la próxima vez que abras una terminal."
echo ""
echo "Para cargar los alias ahora mismo, ejecuta:"
echo -e "${BLUE}source ~/.zshrc${NC}"
echo ""
echo "O simplemente:"
echo -e "${BLUE}exec zsh${NC}"
echo ""
echo "Alias instalados:"
echo -e "${GREEN}  • Git${NC} (gs, ga, gc, gp, gb, gco, gl, gd)"
echo -e "${GREEN}  • Docker${NC} (d, dc, dps, di, dvol, dprune, dex, dsh)"
echo -e "${GREEN}  • PostgreSQL${NC} (pg-status, pg-start, pg-stop, pg-restart)"
echo -e "${GREEN}  • Tools${NC} (lg, yz, cat)"
