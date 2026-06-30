# 🛠️ Herramientas de la Terminal

Descripción de las herramientas de terminal que componen el entorno de desarrollo.

## 📋 Tabla de Contenidos

- [Shell y Prompt](#shell-y-prompt)
- [Visualización](#visualización)
- [Monitoreo](#monitoreo)
- [Git](#git)
- [Archivos](#archivos)

## 🐚 Shell y Prompt

### Zsh

**Shell principal del sistema.**

Zsh (Z Shell) es una shell de Unix poderosa que puede usarse como intérpreto de comandos interactivo y como lenguaje de scripting.

**Características:**
- Autocompletado avanzado
- Corrección de comandos
- Historial compartido entre sesiones
- Temas y personalizaciones

---

### Oh My Zsh

**Framework para administrar la configuración de Zsh.**

Oh My Zsh es un framework de código abierto para gestionar la configuración de Zsh.

**Características:**
- Más de 300 plugins opcionales
- 140+ temas para personalizar el prompt
- Sistema de actualización automático
- Comunidad activa

**Instalación:**
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

---

### Starship

**Prompt moderno y altamente configurable.**

Starship es un prompt minimalista, rápido y altamente personalizable para cualquier shell.

**Características:**
- Muestra información relevante (rama git, versión de Python, etc.)
- Compatible con cualquier shell
- Configuración en TOML
- Rápido y ligero

**Instalación:**
```bash
curl -sS https://starship.rs/install.sh | sh
```

---

## 👁️ Visualización

### Tree

**Visualiza estructuras de directorios.**

Tree muestra los directorios en formato de árbol, facilitando la comprensión de la estructura del proyecto.

**Uso:**
```bash
tree              # Muestra estructura completa
tree -L 2         # Limita a 2 niveles
tree -d           # Solo directorios
tree -I "node_modules" # Ignora carpetas específicas
```

---

### Bat

**Reemplazo moderno de `cat`.**

Bat es un clon de `cat` con mejoras como resaltado de sintaxis y integración con Git.

**Características:**
- Resaltado de sintaxis
- Numeración de líneas
- Integración con Git (muestra modificaciones)
- Paginación automática
- Soporte para múltiples archivos

**Uso:**
```bash
bat archivo.txt           # Ver archivo con resaltado
bat -n archivo.txt        # Solo numeración de líneas
bat --line-range 10:20 archivo.txt  # Rango específico
```

---

## 📊 Monitoreo

### Btop

**Monitor interactivo del sistema.**

Btop es un monitor de recursos del sistema con una interfaz visual atractiva.

**Características:**
- Visualización en tiempo real de:
  - CPU
  - RAM
  - Disco
  - Procesos
  - Red
- Interfaz interactiva
- Gráficos y estadísticas
- Filtros y búsqueda de procesos

**Uso:**
```bash
btop
```

**Controles:**
- `q`: Salir
- `F5`: Actualizar
- `F6`: Ordenar procesos

---

## 🌿 Git

### LazyGit

**Interfaz de Git para la terminal.**

LazyGit es una interfaz de usuario terminal para comandos de Git, simplificando el uso de Git.

**Características:**
- Visualización de estado de Git
- Staging/unstaging con teclas
- Commits con editor integrado
- Gestión de ramas
- Historial visual

**Uso:**
```bash
lazygit
# o usando el alias
lg
```

**Controles principales:**
- `Space`: Stage/unstage archivos
- `Enter`: Confirmar acción
- `c`: Commit
- `p`: Push
- `q`: Salir

---

## 📁 Archivos

### Yazi

**Administrador de archivos moderno para la terminal.**

Yazi es un administrador de archivos de terminal escrito en Rust, con soporte para previsualización de archivos.

**Características:**
- Navegación rápida con teclado
- Previsualización de archivos (imágenes, PDF, código)
- Integración con comandos externos
- Soporte para múltiples pestañas
- Búsqueda y filtrado

**Uso:**
```bash
yazi
# o usando el alias
yz
```

**Controles básicos:**
- `h/j/k/l`: Navegación (vim-style)
- `Enter`: Abrir archivo/carpeta
- `q`: Salir
- `/`: Buscar

---

## 📝 Notas

Estas herramientas forman la base del entorno de desarrollo. Para comandos de navegación básicos, consulta [`navigation.md`](/docs/terminal/navigation.md).

**Volver al [Índice](/docs/index.md)**