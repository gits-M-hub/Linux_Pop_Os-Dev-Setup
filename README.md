# 🚀 Linux Pop!\_OS Dev Setup

Un entorno de desarrollo reproducible, organizado y documentado para **Pop!\_OS**, pensado para desarrollo de software moderno con énfasis en:

- ☕ Java
- 🟣 Kotlin
- 📱 Android
- 🌐 Desarrollo Web
- 🐳 Docker
- 🌿 Git
- 💻 VS Code
- 🤖 Herramientas de IA
- 🐧 Linux

## 📋 Tabla de Contenidos

- [Estructura](#estructura)
- [Documentación](#documentación)
- [Herramientas Instaladas](#herramientas-instaladas)
- [Scripts](#scripts)
- [Licencia](#licencia)
- [Contribuir](#contribuir)

---

## 🎯 Objetivos

Este repositorio tiene como finalidad:

- **Documentar completamente** un entorno de desarrollo
- **Centralizar** configuraciones, scripts y documentación
- **Versionar** todos los cambios importantes
- **Automatizar la instalación** del entorno completo

Este proyecto está diseñado para ser un **setup reproducible** que permite reinstalar el entorno de desarrollo en Pop!\_OS rápidamente cuando sea necesario.

## 🚀 Instalación Rápida

Para instalar el entorno completo, ejecuta:

```bash
# Clonar el repositorio
git clone https://github.com/gits-M-hub/Linux_Pop_Os-Dev-Setup.git ~/Projects/linux-dev-setup
cd ~/Projects/linux-dev-setup

# Ejecutar script de instalación
./scripts/install/setup.sh
```

El script instalará automáticamente:

- Herramientas base (Zsh, Oh My Zsh, Starship, LazyGit, Yazi)
- Herramientas de desarrollo (SDKMAN, Java, Kotlin, Docker, VS Code, PostgreSQL)
- Configuraciones (Zsh, Starship, Git, VS Code)
- Alias de terminal

---

## 📁 Estructura

```
linux-dev-setup/
├── configs/           # Archivos de configuración
│   ├── aliases/      # Alias de terminal
│   ├── exports/      # Variables de entorno
│   ├── git/          # Configuración de Git
│   ├── starship/     # Configuración de Starship
│   ├── vscode/       # Configuración de VS Code
│   └── zsh/          # Configuración de Zsh
├── docs/              # Documentación completa
│   ├── ai/           # Herramientas de IA
│   ├── postgresql/   # Guías de PostgreSQL
│   ├── setup/        # Guías de instalación
│   └── terminal/     # Comandos y herramientas
├── scripts/          # Scripts de automatización
│   ├── docker/       # Scripts de Docker
│   └── install/      # Scripts de instalación
├── .gitignore        # Archivos ignorados por Git
├── LICENSE           # Licencia del proyecto
└── README.md         # Este archivo
```

---

## 📚 Documentación

Toda la documentación se encuentra en la carpeta [`docs/`](docs/).

**Comienza por:**

- [`docs/index.md`](/docs/index.md) - Índice principal de la documentación

**Documentación disponible:**

[`docs/linux-survival-guide.md`](/docs/linux-survival-guide.md) - Guía de supervivencia en Linux
[`docs/ai/README.md`](/docs/ai/README.md) - Herramientas de Inteligencia Artificial
[`docs/setup/installed-tools.md`](/docs/setup/installed-tools.md) - Herramientas instaladas
[`docs/terminal/navigation.md`](/docs/terminal/navigation.md) - Navegación en terminal
[`docs/terminal/tools.md`](/docs/terminal/tools.md) - Herramientas de terminalç
[`docs/terminal/aliases.md`](/docs/terminal/aliases.md) - Alias configurados

---

## 🛠️ Herramientas Instaladas

Actualmente el entorno incluye:

### Desarrollo

- Git
- GitHub SSH
- Docker
- Java (SDKMAN!)
- Kotlin
- Gradle
- VS Code

### Terminal

- Zsh
- Oh My Zsh
- Starship
- LazyGit
- Yazi
- Tree
- Bat
- Btop

Para más detalles, consulta [`docs/setup/installed-tools.md`](/docs/setup/installed-tools.md).

---

## 📜 Scripts

Los scripts del proyecto se encuentran en [`scripts/`](/scripts/).

### Instalación

- [`scripts/install/setup.sh`](scripts/install/setup.sh) - Script principal de instalación completa
- [`scripts/install/install-base-tools.sh`](scripts/install/install-base-tools.sh) - Instalación de herramientas base (Zsh, Oh My Zsh, Starship, LazyGit, Yazi)
- [`scripts/install/install-dev-tools.sh`](scripts/install/install-dev-tools.sh) - Instalación de herramientas de desarrollo (SDKMAN, Java, Kotlin, Docker, VS Code, PostgreSQL)
- [`scripts/install/install-aliases.sh`](scripts/install/install-aliases.sh) - Instalación de alias en ~/.zshrc

### Docker

- `scripts/docker/docker-doctor.sh` - Verificación de instalación de Docker
- `scripts/docker/docker-clean.sh` - Limpieza de recursos de Docker
- `scripts/docker/docker-reset.sh` - Reset completo de Docker
- `scripts/docker/docker-backup-volumes.sh` - Backup de volúmenes Docker

### Sistema

- `scripts/doctor.sh` - Script de verificación del sistema
- `scripts/update-system.sh` - Actualización del sistema

---

## 💡 Filosofía

Este proyecto sigue algunos principios:

- **Configuración reproducible** - Todo debe poder recrearse fácilmente
- **Documentación clara** - Cada herramienta y configuración está documentada
- **Automatización antes que repetición** - Scripts para tareas repetitivas
- **Uso de herramientas oficiales** - Preferir herramientas estándar y bien mantenidas
- **Aprender el porqué** - Entender la razón detrás de cada herramienta

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](/LICENSE) para más detalles.

---

## 🤝 Contribuir

Este es un proyecto de aprendizaje personal, pero si encuentras algo útil o quieres sugerir mejoras, ¡siéntete libre de abrir un issue o un pull request!

---

**Última actualización:** 2026
