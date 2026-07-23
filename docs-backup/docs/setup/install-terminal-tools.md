# 🖥️ Instalación de Herramientas de Terminal

Guía completa para instalar las herramientas de terminal esenciales en Pop!_OS.

## 📋 Tabla de Contenidos

- [Herramientas a Instalar](#herramientas-a-instalar)
- [Zsh](#zsh)
- [Oh My Zsh](#oh-my-zsh)
- [Starship](#starship)
- [Tree](#tree)
- [Bat](#bat)
- [Btop](#btop)
- [LazyGit](#lazygit)
- [Yazi](#yazi)
- [Ripgrep](#ripgrep)
- [fd](#fd)
- [Verificación](#verificación)

---

## Herramientas a Instalar

Esta guía cubre la instalación de:

- **Zsh** - Shell mejorado
- **Oh My Zsh** - Framework para Zsh
- **Starship** - Prompt moderno
- **Tree** - Visualización de directorios
- **Bat** - `cat` con resaltado de sintaxis
- **Btop** - Monitor de recursos
- **LazyGit** - Interfaz de Git
- **Yazi** - Administrador de archivos
- **Ripgrep** - Buscador rápido
- **fd** - Buscador de archivos rápido

---

## Zsh

### ¿Qué es Zsh?

Zsh (Z Shell) es una shell de Unix poderosa que puede usarse como intérprete de comandos interactivo y como lenguaje de scripting.

### Verificar si Zsh está instalado

```bash
zsh --version
```

### Instalar Zsh

```bash
sudo apt update
sudo apt install zsh
```

### Cambiar shell por defecto a Zsh

```bash
chsh -s $(which zsh)
```

### Verificar shell actual

```bash
echo $SHELL
```

---

## Oh My Zsh

### ¿Qué es Oh My Zsh?

Oh My Zsh es un framework de código abierto para gestionar la configuración de Zsh.

### Verificar si Oh My Zsh está instalado

```bash
[ -d ~/.oh-my-zsh ] && echo "Instalado" || echo "No instalado"
```

### Instalar Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

### Plugins recomendados

Edita `~/.zshrc` y añade plugins:

```bash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```

### Instalar plugins adicionales

```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

---

## Starship

### ¿Qué es Starship?

Starship es un prompt minimalista, extremadamente rápido y altamente personalizable para cualquier shell.

### Verificar si Starship está instalado

```bash
starship --version
```

### Instalar Starship

```bash
curl -fsSL https://starship.rs/install.sh | sh
```

### Configurar Starship en Zsh

Añade al final de `~/.zshrc`:

```bash
eval "$(starship init zsh)"
```

### Configuración personalizada

El proyecto incluye una configuración de Starship en `configs/starship/starship.toml`.

```bash
# Copiar configuración del proyecto
mkdir -p ~/.config
cp ~/Projects/linux-dev-setup/configs/starship/starship.toml ~/.config/starship.toml
```

---

## Tree

### ¿Qué es Tree?

Tree es un comando recursivo de listado de directorios que produce un listado en profundidad de archivos.

### Verificar si Tree está instalado

```bash
tree --version
```

### Instalar Tree

```bash
sudo apt install tree
```

### Uso básico

```bash
# Listar directorio actual
tree

# Listar con profundidad 2
tree -L 2

# Listar archivos ocultos
tree -a

# Listar solo directorios
tree -d
```

---

## Bat

### ¿Qué es Bat?

Bat es un clon de `cat` con resaltado de sintaxis, integración con Git y paginación automática.

### Verificar si Bat está instalado

```bash
bat --version
```

### Instalar Bat

```bash
sudo apt install bat
```

### Crear symlink (en Ubuntu/Debian)

```bash
sudo ln -s /usr/bin/batcat /usr/local/bin/bat
```

### Uso básico

```bash
# Ver archivo con resaltado
bat archivo.txt

# Ver múltiples archivos
bat archivo1.txt archivo2.txt

# Ver con números de línea
bat -n archivo.txt

# Ver con paginación
bat --paging=never archivo.txt
```

---

## Btop

### ¿Qué es Btop?

Btop es un monitor de recursos del sistema, una versión mejorada de htop y bpytop.

### Verificar si Btop está instalado

```bash
btop --version
```

### Instalar Btop

```bash
sudo apt install btop
```

### Uso básico

```bash
# Iniciar btop
btop

# Opciones de teclado:
# q - Salir
# F2 - Configuración
# F3 - Procesos
# F4 - CPU
# F5 - Memoria
# F6 - Red
# F7 - Discos
```

---

## LazyGit

### ¿Qué es LazyGit?

LazyGit es una interfaz de terminal para Git que hace trabajar con Git más fácil y eficiente.

### Verificar si LazyGit está instalado

```bash
lazygit --version
```

### Instalar LazyGit

```bash
# Obtener última versión
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Descargar e instalar
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
```

### Uso básico

```bash
# Iniciar lazygit
lazygit

# Atajos principales:
# q - Salir
# x - Confirmar acción
# 1 - Ver archivos
# 2 - Ver ramas
# 3 - Ver commits
# 4 - Ver stash
```

---

## Yazi

### ¿Qué es Yazi?

Yazi es un administrador de archivos de terminal escrito en Rust, diseñado para ser rápido y personalizable.

### Verificar si Yazi está instalado

```bash
yazi --version
```

### Instalar Rust (si no está instalado)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
```

### Instalar Yazi

```bash
cargo install --locked yazi
```

### Uso básico

```bash
# Iniciar yazi
yazi

# Atajos principales:
# q - Salir
# Enter - Entrar en directorio
# Esc - Volver atrás
# Space - Seleccionar
# D - Borrar
```

---

## Ripgrep

### ¿Qué es Ripgrep?

Ripgrep (rg) es una herramienta de búsqueda de líneas de código extremadamente rápida.

### Verificar si Ripgrep está instalado

```bash
rg --version
```

### Instalar Ripgrep

```bash
sudo apt install ripgrep
```

### Uso básico

```bash
# Buscar texto en archivos
rg "texto"

# Buscar en directorio específico
rg "texto" /ruta/directorio

# Buscar con contexto
rg "texto" -C 2

# Buscar solo nombres de archivos
rg "texto" -l

# Buscar ignorando mayúsculas/minúsculas
rg "texto" -i
```

---

## fd

### ¿Qué es fd?

fd es una alternativa simple, rápida y amigable para `find`.

### Verificar si fd está instalado

```bash
fd --version
```

### Instalar fd

```bash
sudo apt install fd-find
```

### Crear symlink (en Ubuntu/Debian)

```bash
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
```

### Uso básico

```bash
# Buscar archivos
fd nombre

# Buscar con patrón
fd "*.txt"

# Buscar en directorio específico
fd nombre /ruta/directorio

# Buscar solo directorios
fd -t d nombre

# Buscar solo archivos
fd -t f nombre
```

---

## Verificación

### Verificar todas las herramientas

```bash
echo "=== Verificación de herramientas ==="
echo "Zsh: $(zsh --version)"
echo "Oh My Zsh: $([ -d ~/.oh-my-zsh ] && echo 'Instalado' || echo 'No instalado')"
echo "Starship: $(starship --version)"
echo "Tree: $(tree --version)"
echo "Bat: $(bat --version)"
echo "Btop: $(btop --version)"
echo "LazyGit: $(lazygit --version)"
echo "Yazi: $(yazi --version)"
echo "Ripgrep: $(rg --version)"
echo "fd: $(fd --version)"
```

### Script de verificación del proyecto

El proyecto incluye un script de verificación:

```bash
./scripts/doctor.sh
```

---

## 📝 Notas

- Las herramientas se instalan en `/usr/bin/` o `/usr/local/bin/`
- Las configuraciones de Zsh están en `~/.zshrc`
- Oh My Zsh se instala en `~/.oh-my-zsh/`
- La configuración de Starship está en `~/.config/starship.toml`
- El proyecto incluye configuraciones predefinidas en `configs/`
- El script de instalación del proyecto instala todas estas herramientas automáticamente

---

## 🚀 Instalación Automática

Para instalar todas estas herramientas automáticamente, ejecuta el script del proyecto:

```bash
cd ~/Projects/linux-dev-setup
./scripts/install/install-base-tools.sh
```

Este script instalará todas las herramientas de terminal descritas en esta guía.

---

**Volver al [Índice](../index.md)**
