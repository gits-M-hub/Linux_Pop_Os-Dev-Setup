#!/bin/bash

# ====================================
# Linux Dev Setup - Script Principal (Fedora)
# ====================================
# Este script automatiza la instalación completa del entorno de desarrollo
# para Fedora, incluyendo herramientas base, desarrollo y configuraciones.

set -e

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Funciones de utilidad
print_header() {
    echo -e "${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Verificar si se ejecuta como root
check_sudo() {
    if [ "$EUID" -eq 0 ]; then
        print_error "No ejecutes este script como root. Ejecútalo como usuario normal."
        exit 1
    fi
}

# Verificar sistema operativo
check_os() {
    if [ ! -f /etc/os-release ]; then
        print_error "No se pudo detectar el sistema operativo."
        exit 1
    fi

    source /etc/os-release
    if [[ "$ID" != "fedora" && "$ID" != "rhel" && "$ID" != "centos" ]]; then
        print_warning "Este script está diseñado para Fedora/RHEL/CentOS. Puede funcionar en otros sistemas, pero no está garantizado."
        read -p "¿Continuar? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# Actualizar sistema
update_system() {
    print_header "Actualizando sistema"
    
    print_info "Actualizando repositorios..."
    sudo dnf update -y
    
    print_info "Instalando dependencias básicas..."
    sudo dnf install -y curl wget git unzip gcc-c++ make
    
    print_success "Sistema actualizado"
}

# Instalar herramientas base
install_base_tools() {
    print_header "Instalando herramientas base"
    
    local tools=(
        "zsh"
        "tree"
        "bat"
        "btop"
        "ripgrep"
        "fd-find"
    )
    
    for tool in "${tools[@]}"; do
        if command -v "$tool" >/dev/null 2>&1; then
            print_success "$tool ya está instalado"
        else
            print_info "Instalando $tool..."
            case "$tool" in
                "fd-find")
                    sudo dnf install -y fd-find
                    # Crear symlink para fd-find -> fd
                    if [ ! -L /usr/local/bin/fd ]; then
                        sudo ln -s /usr/bin/fd-find /usr/local/bin/fd
                    fi
                    ;;
                *)
                    sudo dnf install -y "$tool"
                    ;;
            esac
            print_success "$tool instalado"
        fi
    done
}

# Instalar Oh My Zsh
install_oh_my_zsh() {
    print_header "Instalando Oh My Zsh"
    
    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_success "Oh My Zsh ya está instalado"
    else
        print_info "Instalando Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh instalado"
    fi
}

# Instalar Starship
install_starship() {
    print_header "Instalando Starship"
    
    if command -v starship >/dev/null 2>&1; then
        print_success "Starship ya está instalado"
    else
        print_info "Instalando Starship..."
        curl -fsSL https://starship.rs/install.sh | sh
        print_success "Starship instalado"
    fi
}

# Instalar LazyGit
install_lazygit() {
    print_header "Instalando LazyGit"
    
    if command -v lazygit >/dev/null 2>&1; then
        print_success "LazyGit ya está instalado"
    else
        print_info "Instalando LazyGit..."
        
        # Intentar instalar desde repositorio de Fedora primero
        if sudo dnf list lazygit >/dev/null 2>&1; then
            sudo dnf install -y lazygit
            print_success "LazyGit instalado desde repositorio de Fedora"
        else
            print_info "LazyGit no encontrado en repositorios, instalando desde GitHub..."
            LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
            
            if [ -z "$LAZYGIT_VERSION" ]; then
                print_error "No se pudo obtener la versión de LazyGit"
                return 1
            fi
            
            curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
            
            if [ ! -f lazygit.tar.gz ]; then
                print_error "No se pudo descargar LazyGit"
                return 1
            fi
            
            tar xf lazygit.tar.gz
            sudo install lazygit /usr/local/bin
            rm lazygit.tar.gz lazygit
            
            print_success "LazyGit instalado desde GitHub"
        fi
    fi
}

# Instalar Yazi
install_yazi() {
    print_header "Instalando Yazi"
    
    if command -v yazi >/dev/null 2>&1; then
        print_success "Yazi ya está instalado"
    else
        print_info "Instalando Yazi..."
        sudo dnf install -y unzip
        
        # Intentar instalar desde repositorio de Fedora primero
        if sudo dnf list yazi >/dev/null 2>&1; then
            sudo dnf install -y yazi
            print_success "Yazi instalado desde repositorio de Fedora"
        # Si no está disponible, instalar via cargo
        elif command -v cargo >/dev/null 2>&1; then
            cargo install --locked yazi
            print_success "Yazi instalado via cargo"
        else
            print_warning "Cargo no encontrado. Instalando Rust primero..."
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            source "$HOME/.cargo/env"
            cargo install --locked yazi
            print_success "Yazi instalado via cargo"
        fi
    fi
}

# Instalar SDKMAN
install_sdkman() {
    print_header "Instalando SDKMAN!"
    
    if [ -d "$HOME/.sdkman" ]; then
        print_success "SDKMAN! ya está instalado"
    else
        print_info "Instalando SDKMAN!..."
        curl -s "https://get.sdkman.io" | bash
        source "$HOME/.sdkman/bin/sdkman-init.sh"
        print_success "SDKMAN! instalado"
    fi
}

# Instalar Java
install_java() {
    print_header "Instalando Java"
    
    if [ ! -d "$HOME/.sdkman" ]; then
        print_error "SDKMAN! no está instalado. Instalando primero..."
        install_sdkman
    fi
    
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    
    if sdk list java | grep -q "installed"; then
        print_success "Java ya está instalado"
        sdk list java | grep "installed"
    else
        print_info "Instalando Java 21 LTS..."
        sdk install java 21.0.1-tem
        print_success "Java instalado"
    fi
}

# Instalar Kotlin
install_kotlin() {
    print_header "Instalando Kotlin"
    
    if [ ! -d "$HOME/.sdkman" ]; then
        print_error "SDKMAN! no está instalado. Instalando primero..."
        install_sdkman
    fi
    
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    
    if sdk list kotlin | grep -q "installed"; then
        print_success "Kotlin ya está instalado"
        sdk list kotlin | grep "installed"
    else
        print_info "Instalando Kotlin..."
        sdk install kotlin
        print_success "Kotlin instalado"
    fi
}

# Instalar Docker
install_docker() {
    print_header "Instalando Docker"
    
    if command -v docker >/dev/null 2>&1; then
        print_success "Docker ya está instalado"
    else
        print_info "Instalando Docker..."
        
        # Añadir repositorio de Docker
        print_info "Añadiendo repositorio de Docker..."
        sudo dnf -y install dnf-plugins-core
        sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
        
        print_info "Instalando paquetes de Docker..."
        sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        
        # Habilitar e iniciar Docker
        print_info "Habilitando e iniciando servicio Docker..."
        sudo systemctl enable docker
        sudo systemctl start docker
        
        # Verificar que Docker está corriendo
        if sudo systemctl is-active --quiet docker; then
            print_success "Docker está corriendo correctamente"
        else
            print_error "Docker no se pudo iniciar correctamente"
            print_info "Verifica con: sudo systemctl status docker"
            return 1
        fi
        
        # Añadir usuario al grupo docker
        print_info "Añadiendo usuario al grupo docker..."
        sudo usermod -aG docker $USER
        
        print_success "Docker instalado"
        print_warning "Necesitas cerrar sesión y volver a entrar para que el grupo docker surta efecto"
    fi
}

# Instalar VS Code
install_vscode() {
    print_header "Instalando VS Code"
    
    if command -v code >/dev/null 2>&1; then
        print_success "VS Code ya está instalado"
    else
        print_info "Instalando VS Code..."
        
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
        
        sudo dnf install -y code
        
        print_success "VS Code instalado"
    fi
}

# Instalar PostgreSQL
install_postgresql() {
    print_header "Instalando PostgreSQL"
    
    if command -v psql >/dev/null 2>&1; then
        print_success "PostgreSQL ya está instalado"
    else
        print_info "Instalando PostgreSQL..."
        sudo dnf install -y postgresql postgresql-server
        
        # Inicializar base de datos
        sudo /usr/bin/postgresql-setup --initdb
        
        # Habilitar e iniciar PostgreSQL
        sudo systemctl enable postgresql
        sudo systemctl start postgresql
        
        print_success "PostgreSQL instalado"
    fi
}

# Configurar Zsh
configure_zsh() {
    print_header "Configurando Zsh"
    
    # Cambiar shell por defecto a zsh
    if [ "$SHELL" != "/bin/zsh" ]; then
        print_info "Cambiando shell por defecto a zsh..."
        chsh -s $(which zsh)
        print_success "Shell cambiado a zsh"
    else
        print_success "Zsh ya es el shell por defecto"
    fi
    
    # Instalar alias
    print_info "Instalando alias..."
    "$HOME/Projects/linux-dev-setup/scripts/install/install-aliases.sh"
}

# Configurar Starship
configure_starship() {
    print_header "Configurando Starship"
    
    # Añadir starship al .zshrc si no está
    if ! grep -q "starship init zsh" "$HOME/.zshrc"; then
        print_info "Añadiendo Starship a .zshrc..."
        echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
        print_success "Starship configurado"
    else
        print_success "Starship ya está configurado"
    fi
    
    # Copiar configuración de starship si existe
    if [ -f "$HOME/Projects/linux-dev-setup/configs/starship/starship.toml" ]; then
        print_info "Copiando configuración de Starship..."
        mkdir -p "$HOME/.config"
        cp "$HOME/Projects/linux-dev-setup/configs/starship/starship.toml" "$HOME/.config/starship.toml"
        print_success "Configuración de Starship copiada"
    fi
}

# Configurar Git
configure_git() {
    print_header "Configurando Git"
    
    # Solicitar nombre y email
    if [ -z "$(git config --global user.name)" ]; then
        read -p "Ingresa tu nombre para Git: " git_name
        git config --global user.name "$git_name"
    fi
    
    if [ -z "$(git config --global user.email)" ]; then
        read -p "Ingresa tu email para Git: " git_email
        git config --global user.email "$git_email"
    fi
    
    # Configurar defaults
    git config --global init.defaultBranch main
    git config --global core.autocrlf input
    
    print_success "Git configurado"
}

# Función principal
main() {
    print_header "Linux Dev Setup - Instalación (Fedora)"
    
    check_sudo
    check_os
    
    print_info "Este script instalará:"
    echo "  - Herramientas base (Zsh, Tree, Bat, Btop, etc.)"
    echo "  - Oh My Zsh y Starship"
    echo "  - LazyGit y Yazi"
    echo "  - SDKMAN!, Java y Kotlin"
    echo "  - Docker"
    echo "  - VS Code"
    echo "  - PostgreSQL"
    echo "  - Configuraciones de Zsh, Starship y Git"
    echo ""
    
    read -p "¿Continuar? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Instalación cancelada"
        exit 1
    fi
    
    echo ""
    
    # Ejecutar instalación
    update_system
    install_base_tools
    install_oh_my_zsh
    install_starship
    install_lazygit
    install_yazi
    install_sdkman
    install_java
    install_kotlin
    install_docker
    install_vscode
    install_postgresql
    configure_zsh
    configure_starship
    configure_git
    
    print_header "Instalación Completada"
    
    print_success "Todas las herramientas han sido instaladas"
    echo ""
    print_info "Pasos siguientes:"
    echo "  1. Cierra sesión y vuelve a entrar para aplicar los cambios"
    echo "  2. Ejecuta 'exec zsh' para iniciar Zsh"
    echo "  3. Revisa la documentación en docs/ para más información"
    echo ""
    print_warning "Docker requiere que cierres sesión y vuelvas a entrar para usarlo sin sudo"
}

# Ejecutar función principal
main
