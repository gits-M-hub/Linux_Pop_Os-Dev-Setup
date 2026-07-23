# 📦 Instalación de Git

Guía completa para instalar y configurar Git en Pop!_OS.

## 📋 Tabla de Contenidos

- [¿Qué es Git?](#qué-es-git)
- [Instalación](#instalación)
- [Configuración Inicial](#configuración-inicial)
- [Configuración de SSH con GitHub](#configuración-de-ssh-con-github)
- [Configuración Adicional](#configuración-adicional)
- [Verificación](#verificación)

---

## ¿Qué es Git?

Git es un sistema de control de versiones distribuido, diseñado para manejar desde pequeños hasta muy grandes proyectos con velocidad y eficiencia.

**Características principales:**
- Control de versiones distribuido
- Ramas y fusiones baratas
- Área de staging
- Historial completo
- Trabajo offline

---

## Instalación

### Verificar si Git está instalado

```bash
git --version
```

### Instalar Git

```bash
sudo apt update
sudo apt install git
```

### Instalar desde fuente (última versión)

Si necesitas la versión más reciente:

```bash
# Instalar dependencias
sudo apt install -y libcurl4-openssl-dev libexpat1-dev gettext libz-dev libssl-dev build-essential gcc

# Clonar repositorio de Git
cd /tmp
git clone https://github.com/git/git.git
cd git

# Compilar e instalar
make configure
./configure --prefix=/usr/local
make all
sudo make install
```

---

## Configuración Inicial

### Configurar nombre de usuario

```bash
git config --global user.name "Tu Nombre"
```

### Configurar email

```bash
git config --global user.email "tu@email.com"
```

### Configurar rama por defecto

```bash
git config --global init.defaultBranch main
```

### Configurar finales de línea

```bash
# Linux/Mac
git config --global core.autocrlf input

# Windows
git config --global core.autocrlf true
```

### Ver configuración

```bash
git config --list
```

---

## Configuración de SSH con GitHub

### Generar clave SSH

```bash
ssh-keygen -t ed25519 -C "tu@email.com"
```

Presiona Enter para usar la ubicación por defecto y para no usar passphrase (opcional).

### Iniciar agente SSH

```bash
eval "$(ssh-agent -s)"
```

### Añadir clave SSH al agente

```bash
ssh-add ~/.ssh/id_ed25519
```

### Copiar clave pública

```bash
cat ~/.ssh/id_ed25519.pub
```

### Añadir clave a GitHub

1. Ve a GitHub → Settings → SSH and GPG keys
2. Click en "New SSH key"
3. Pega el contenido de `id_ed25519.pub`
4. Click en "Add SSH key"

### Verificar conexión

```bash
ssh -T git@github.com
```

Deberías ver: `Hi username! You've successfully authenticated...`

---

## Configuración Adicional

### Configurar editor por defecto

```bash
# Nano
git config --global core.editor nano

# VS Code
git config --global core.editor "code --wait"

# Vim
git config --global core.editor vim
```

### Configurar colores

```bash
git config --global color.ui auto
```

### Configurar alias útiles

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.lg "log --graph --oneline --decorate --all"
```

### Configurar rebase por defecto en pull

```bash
git config --global pull.rebase false
```

### Configurar auto stash en rebase

```bash
git config --global rebase.autoStash true
```

### Configurar pruning automático

```bash
git config --global fetch.prune true
```

### Configurar push automático de tracking

```bash
git config --global push.autoSetupRemote true
```

---

## Verificación

### Ver versión de Git

```bash
git --version
```

### Ver configuración global

```bash
git config --global --list
```

### Ver configuración local

```bash
git config --local --list
```

### Probar Git

```bash
# Crear repositorio de prueba
mkdir test-git && cd test-git
git init
echo "# Test" > README.md
git add README.md
git commit -m "Initial commit"
git log
```

---

## 📝 Notas

- La configuración de Git se guarda en `~/.gitconfig`
- Para configuración específica de un repositorio, usa `git config --local` (sin `--global`)
- Los alias de Git del proyecto se cargan automáticamente al ejecutar el script de instalación
- El proyecto incluye una configuración completa de Git en `configs/git/.gitconfig`

---

**Volver al [Índice](../index.md)**
