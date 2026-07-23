# 📝 Changelog

Todos los cambios notables en este proyecto se documentarán en este archivo.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
y este proyecto adherirse a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Añadido
- Contributing guide para nuevos contribuidores
- Code of conduct para la comunidad
- Issue templates para GitHub
- Pull request templates para GitHub
- GitHub Actions workflow para validación automática
- Changelog para seguimiento de cambios

### Cambiado
- Mejorada estructura del proyecto
- Actualizada documentación con enlaces corregidos

### Corregido
- Enlaces rotos en documentación
- Rutas relativas incorrectas en archivos markdown

---

## [1.0.0] - 2026-07-22

### Añadido
- Script principal de instalación (`setup.sh`)
- Script de herramientas base (`install-base-tools.sh`)
- Script de herramientas de desarrollo (`install-dev-tools.sh`)
- Script de instalación de alias (`install-aliases.sh`)
- Scripts de Docker:
  - `docker-doctor.sh` - Verificación de Docker
  - `docker-clean.sh` - Limpieza de recursos
  - `docker-reset.sh` - Reset completo
  - `docker-backup-volumes.sh` - Backup de volúmenes
- Configuraciones de Zsh:
  - `system.zsh` - Alias del sistema
  - `navigation.zsh` - Alias de navegación
  - `git.zsh` - Configuración adicional de Git
  - `docker.zsh` - Configuración adicional de Docker
  - `ai.zsh` - Configuración para herramientas de IA
  - `aliases.zsh` - Carga de alias
- Configuraciones de alias:
  - `docker.zsh` - Alias de Docker con comentarios
  - `git.zsh` - Alias de Git con comentarios
  - `postgres.zsh` - Alias de PostgreSQL con comentarios
  - `tools.zsh` - Alias de herramientas con comentarios
- Configuración de Starship (`starship.toml`)
- Configuración de VS Code:
  - `settings.json` - Configuración completa
  - `extensions.json` - Extensiones recomendadas
- Configuración de Git (`.gitconfig`)
- Configuración de SDKMAN (`sdkman.zsh`)
- Guías de instalación:
  - `install-git.md` - Guía de Git
  - `install-docker.md` - Guía de Docker
  - `install-sdkman.md` - Guía de SDKMAN
  - `install-vscode.md` - Guía de VS Code
  - `install-terminal-tools.md` - Guía de herramientas de terminal
- Documentación de PostgreSQL:
  - `installation.md` - Guía de instalación
  - `usage.md` - Guía de uso
- Documentación de terminal:
  - `tools.md` - Herramientas de terminal
  - `aliases.md` - Documentación de alias
  - `navigation.md` - Comandos de navegación
  - `lazygit.md` - Guía completa de LazyGit
- Documentación de IA:
  - `README.md` - Introducción
  - `claude.md` - Claude Code
  - `codex.md` - Codex
  - `gemini.md` - Gemini
  - `prompts.md` - Prompts útiles
- Documentación de Docker (`docker-aliases.md`)
- Guía de supervivencia de Linux (`linux-survival-guide.md`)
- Índice de documentación (`index.md`)
- Lista de herramientas instaladas (`installed-tools.md`)
- Script de verificación del sistema (`doctor.sh`)
- Script de actualización del sistema (`update-system.sh`)
- Archivo `.gitignore`
- Licencia del proyecto

### Herramientas Instaladas
- Zsh - Shell mejorado
- Oh My Zsh - Framework para Zsh
- Starship - Prompt moderno
- Tree - Visualización de directorios
- Bat - `cat` con resaltado de sintaxis
- Btop - Monitor de recursos
- LazyGit - Interfaz de Git
- Yazi - Administrador de archivos
- Ripgrep - Buscador rápido
- fd - Buscador de archivos rápido
- Git - Control de versiones
- Docker - Contenedores
- SDKMAN! - Gestor de SDKs
- Java 21 - Lenguaje de programación
- Kotlin - Lenguaje de programación
- Gradle - Herramienta de build
- VS Code - Editor de código
- PostgreSQL - Base de datos

---

## [0.1.0] - 2026-07-20

### Añadido
- Estructura inicial del proyecto
- README.md con descripción del proyecto
- Directorios base (configs, docs, scripts)

---

## Formato de Versiones

- **Major (X.0.0):** Cambios incompatibles hacia atrás
- **Minor (0.X.0):** Nuevas funcionalidades compatibles
- **Patch (0.0.X):** Correcciones de bugs compatibles

---

## Categorías de Cambios

- **Añadido:** Nuevas funcionalidades
- **Cambiado:** Cambios en funcionalidades existentes
- **Deprecado:** Funcionalidades que serán removidas
- **Removido:** Funcionalidades removidas
- **Corregido:** Correcciones de bugs
- **Seguridad:** Vulnerabilidades de seguridad
