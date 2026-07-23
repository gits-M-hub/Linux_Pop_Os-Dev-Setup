# 💻 Instalación de VS Code

Guía completa para instalar y configurar Visual Studio Code en Pop!_OS.

## 📋 Tabla de Contenidos

- [¿Qué es VS Code?](#qué-es-vs-code)
- [Instalación](#instalación)
- [Configuración](#configuración)
- [Extensiones Recomendadas](#extensiones-recomendadas)
- [Configuración del Proyecto](#configuración-del-proyecto)
- [Verificación](#verificación)

---

## ¿Qué es VS Code?

Visual Studio Code es un editor de código fuente ligero pero potente, desarrollado por Microsoft.

**Características principales:**
- Soporte para múltiples lenguajes de programación
- Depurador integrado
- Control de versiones Git integrado
- Extensible con miles de extensiones
- Personalización con temas y configuraciones
- IntelliSense (autocompletado inteligente)
- Multiplataforma

---

## Instalación

### Método 1: Desde repositorio oficial de Microsoft (Recomendado)

#### 1. Descargar la clave GPG de Microsoft

```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
```

#### 2. Instalar la clave GPG

```bash
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
```

#### 3. Añadir el repositorio de VS Code

```bash
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
```

#### 4. Limpiar archivo temporal

```bash
rm -f packages.microsoft.gpg
```

#### 5. Actualizar el índice de paquetes

```bash
sudo apt update
```

#### 6. Instalar VS Code

```bash
sudo apt install code
```

### Método 2: Desde Snap

```bash
sudo snap install --classic code
```

### Método 3: Descargar el .deb

1. Ve a [https://code.visualstudio.com/](https://code.visualstudio.com/)
2. Descarga el archivo .deb
3. Instala con:

```bash
sudo dpkg -i code_<version>.deb
sudo apt install -f  # Para resolver dependencias
```

---

## Configuración

### Abrir configuración

```bash
# Desde terminal
code

# Desde VS Code: Ctrl + , (Linux)
# O: File → Preferences → Settings
```

### Configuración básica recomendada

#### Auto-guardado

```json
{
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 500
}
```

#### Formato al guardar

```json
{
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true
}
```

#### Tamaño de tab

```json
{
  "editor.tabSize": 2,
  "editor.insertSpaces": true
}
```

#### Fuente

```json
{
  "editor.fontSize": 14,
  "editor.fontFamily": "'Fira Code', 'JetBrains Mono', monospace"
}
```

#### Git

```json
{
  "git.enableSmartCommit": true,
  "git.autofetch": true
}
```

#### Terminal

```json
{
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.shell.linux": "/bin/zsh"
}
```

### Importar configuración del proyecto

El proyecto incluye configuraciones predefinidas en `configs/vscode/`:

```bash
# Copiar configuración de VS Code
mkdir -p ~/.config/Code/User
cp ~/Projects/linux-dev-setup/configs/vscode/settings.json ~/.config/Code/User/settings.json

# Copiar lista de extensiones recomendadas
cp ~/Projects/linux-dev-setup/configs/vscode/extensions.json ~/.config/Code/User/extensions.json
```

---

## Extensiones Recomendadas

### Instalar extensiones desde la línea de comandos

```bash
# Lista de extensiones recomendadas del proyecto
code --install-extension ms-vscode.vscode-json
code --install-extension eamodio.gitlens
code --install-extension github.copilot
code --install-extension redhat.java
code --install-extension fwcd.kotlin
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
```

### Extensiones esenciales

#### Para desarrollo general
- **GitLens** - Mejora la integración de Git
- **GitHub Copilot** - Asistente de IA para código
- **Error Lens** - Muestra errores en línea
- **Todo Tree** - Gestión de TODOs

#### Para Java/Kotlin
- **Extension Pack for Java** - Paquete completo para Java
- **SonarLint** - Análisis de calidad de código
- **Kotlin** - Soporte para Kotlin

#### Para Docker
- **Docker** - Soporte para Docker

#### Para Python
- **Python** - Soporte para Python
- **Pylance** - Servidor de lenguaje Python

#### Para JavaScript/TypeScript
- **ESLint** - Linter para JavaScript
- **Prettier** - Formateador de código

#### Para Markdown
- **Markdown All in One** - Todo para Markdown

#### Para Shell
- **ShellCheck** - Linter para scripts de shell

#### Temas
- **Material Icon Theme** - Iconos de archivos
- **Material Theme** - Tema oscuro

### Instalar todas las extensiones del proyecto

```bash
# Leer el archivo extensions.json y instalar cada extensión
cat ~/Projects/linux-dev-setup/configs/vscode/extensions.json | grep -o '"[^"]*"' | xargs -I {} code --install-extension {}
```

---

## Configuración del Proyecto

### Configuración de workspace

Crea un archivo `.vscode/settings.json` en tu proyecto:

```json
{
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  "java.configuration.updateBuildConfiguration": "automatic"
}
```

### Configuración de launch.json (depuración)

Crea un archivo `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Debug Java",
      "request": "launch",
      "mainClass": "Main",
      "projectName": "mi-proyecto"
    }
  ]
}
```

---

## Verificación

### Ver versión de VS Code

```bash
code --version
```

### Ver ayuda

```bash
code --help
```

### Abrir VS Code

```bash
# Abrir VS Code
code

# Abrir directorio específico
code ~/Projects/mi-proyecto

# Abrir archivo específico
code archivo.txt

# Abrir en nueva ventana
code -n ~/Projects/mi-proyecto
```

---

## 📝 Notas

- VS Code se instala en `/usr/share/code/`
- La configuración de usuario está en `~/.config/Code/User/`
- Las extensiones se instalan en `~/.vscode/extensions/`
- El proyecto incluye configuraciones predefinidas en `configs/vscode/`
- Para sincronizar configuraciones entre máquinas, considera usar Settings Sync de VS Code

---

## 🔧 Atajos de Teclado Útiles

| Comando | Atajo |
|---------|-------|
| Command Palette | Ctrl + Shift + P |
| Abrir archivo | Ctrl + P |
| Buscar en archivos | Ctrl + Shift + F |
| Terminal integrado | Ctrl + ` |
| Dividir editor | Ctrl + \ |
| Cerrar editor | Ctrl + W |
| Guardar | Ctrl + S |
| Guardar todo | Ctrl + K S |
| Formatear documento | Shift + Alt + F |
| Ir a línea | Ctrl + G |
| Comentar | Ctrl + / |
| Multi-cursor | Ctrl + Alt + Arriba/Abajo |

---

**Volver al [Índice](../index.md)**
