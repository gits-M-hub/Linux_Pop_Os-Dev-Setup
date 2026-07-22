# 📚 Índice de Documentación

Bienvenido a la documentación del entorno de desarrollo Linux Pop!\_OS.

## 📋 Tabla de Contenidos

- [Guías de Terminal](#guías-de-terminal)
- [Docker](#docker)
- [PostgreSQL](#postgresql)
- [Configuración e Instalación](#configuración-e-instalación)
- [Herramientas de IA](#herramientas-de-ia)
- [Guías de Supervivencia](#guías-de-supervivencia)
- [Próximamente](#próximamente)

---

## 🖥️ Guías de Terminal

### Navegación

- [`terminal/navigation.md`](terminal/navigation.md) - Comandos básicos de navegación en Linux
  - `pwd`, `cd`, `ls`, `tree`
  - Creación y gestión de archivos y carpetas
  - Búsqueda de archivos

### Alias

- [`terminal/aliases.md`](terminal/aliases.md) - Alias configurados para mayor productividad
  - Alias de Git (`gs`, `ga`, `gc`, `gp`, `gl`)
  - Alias de herramientas (`lg`, `yz`)
  - Alias del sistema

### Herramientas

- [`terminal/tools.md`](terminal/tools.md) - Descripción de herramientas de terminal
  - Zsh, Oh My Zsh, Starship
  - Tree, Bat, Btop
  - LazyGit, Yazi

- [`terminal/lazygit.md`](terminal/lazygit.md) - Guía completa de LazyGit
  - Instalación y uso básico
  - Atajos de teclado
  - Flujos de trabajo comunes

---

## 🐳 Docker

### Alias de Docker

- [`docker-aliases.md`](docker-aliases.md) - Documentación completa de alias de Docker
  - Comandos básicos (`d`, `dc`)
  - Gestión de contenedores (`dps`, `dpsa`, `dstop`)
  - Gestión de imágenes (`di`, `dpull`, `dpush`)
  - Gestión de volúmenes (`dvol`, `dvolrm`)
  - Gestión de redes (`dnet`, `dnetcreate`)
  - Limpieza (`dprune`, `dprunea`)
  - Ejecución en contenedores (`dex`, `dsh`, `dshz`)
  - Docker Compose (`dce`, `dcb`, `dcu`, `dcd`, `dcp`, `dcl`, `dclf`)
  - Estadísticas e inspección (`dstats`, `dinsp`)

---

## 🐘 PostgreSQL

### Instalación

- [`postgresql/installation.md`](postgresql/installation.md) - Guía de instalación de PostgreSQL
  - Instalación en Pop!\_OS/Ubuntu
  - Configuración inicial
  - Configuración de seguridad
  - Configuración de acceso remoto
  - Solución de problemas

### Uso

- [`postgresql/usage.md`](postgresql/usage.md) - Guía completa de uso de PostgreSQL
  - Conexión a PostgreSQL
  - Comandos básicos de psql
  - Gestión de bases de datos
  - Gestión de tablas
  - Operaciones CRUD
  - Consultas avanzadas (JOIN, subconsultas, GROUP BY)
  - Funciones y agregaciones
  - Índices y rendimiento
  - Backup y restore
  - Gestión de usuarios
  - Transacciones
  - Vistas y triggers

---

## ⚙️ Configuración e Instalación

### Herramientas Instaladas

- [`setup/installed-tools.md`](setup/installed-tools.md) - Lista completa de herramientas instaladas
  - Terminal (Zsh, Oh My Zsh, Starship, etc.)
  - Desarrollo (Git, Docker, Java, Kotlin, VS Code)
  - Gestores (SDKMAN!)
  - Scripts propios

### Guías de Instalación

- [`setup/install-git.md`](setup/install-git.md) - Guía de instalación de Git
  - Instalación desde repositorio o fuente
  - Configuración inicial
  - Configuración de SSH con GitHub
  - Configuración adicional y alias
- [`setup/install-docker.md`](setup/install-docker.md) - Guía de instalación de Docker
  - Instalación desde repositorio oficial
  - Configuración post-instalación
  - Docker Compose
  - Solución de problemas
- [`setup/install-sdkman.md`](setup/install-sdkman.md) - Guía de instalación de SDKMAN!
  - Instalación y configuración
  - Gestión de Java, Kotlin y Gradle
  - Gestión de múltiples versiones
- [`setup/install-vscode.md`](setup/install-vscode.md) - Guía de instalación de VS Code
  - Instalación desde repositorio oficial
  - Configuración básica
  - Extensiones recomendadas
  - Atajos de teclado
- [`setup/install-terminal-tools.md`](setup/install-terminal-tools.md) - Guía de instalación de herramientas de terminal
  - Zsh, Oh My Zsh, Starship
  - Tree, Bat, Btop
  - LazyGit, Yazi
  - Ripgrep, fd

---

## 🤖 Herramientas de IA

### Índice de IA

- [`ai/README.md`](ai/README.md) - Introducción a las herramientas de IA
  - Claude Code
  - Codex
  - Gemini
  - Prompts

### Documentos Específicos

- [`ai/claude.md`](ai/claude.md) - Guía de Claude Code
- [`ai/codex.md`](ai/codex.md) - Guía de Codex
- [`ai/gemini.md`](ai/gemini.md) - Guía de Gemini
- [`ai/prompts.md`](ai/prompts.md) - Prompts útiles para IA

---

## 🆘 Guías de Supervivencia

### Linux Survival Guide

- [`linux-survival-guide.md`](linux-survival-guide.md) - Lecciones aprendidas y tips esenciales
  - Cómo salir de comandos que "atrapan" la terminal
  - Verificar el directorio actual antes de crear archivos
  - Comandos de emergencia

---

## 🚧 Próximamente

Documentación en desarrollo:

- [ ] Git avanzado
- [ ] Docker completo
- [ ] Java/Kotlin setup
- [ ] Android Studio
- [ ] VS Code configuración
- [ ] IA detallada
- [ ] Troubleshooting
- [ ] Scripts automatizados
- [ ] Cheatsheets

---

## 📝 Filosofía de Documentación

Cada documento intenta responder tres preguntas fundamentales:

1. **¿Qué es?** - Descripción clara de la herramienta o concepto
2. **¿Por qué lo uso?** - Justificación y beneficios
3. **¿Cómo lo utilizo?** - Ejemplos prácticos y comandos

---

**Volver al [README principal](../README.md)**
