# 🐙 LazyGit

Guía completa de uso de LazyGit, la interfaz de terminal para Git.

## 📋 Tabla de Contenidos

- [¿Qué es LazyGit?](#qué-es-lazygit)
- [Instalación](#instalación)
- [Uso Básico](#uso-básico)
- [Atajos de Teclado](#atajos-de-teclado)
- [Flujos de Trabajo Comunes](#flujos-de-trabajo-comunes)
- [Configuración](#configuración)

---

## ¿Qué es LazyGit?

LazyGit es una interfaz de terminal para Git que hace trabajar con Git más fácil y eficiente. Proporciona una vista visual de tu repositorio Git y permite realizar operaciones comunes con simples atajos de teclado.

**Características principales:**
- Interfaz visual intuitiva
- Atajos de teclado para operaciones comunes
- Vista de archivos, ramas, commits y stash
- Integración con Git hooks
- Personalizable

---

## Instalación

LazyGit se instala automáticamente al ejecutar el script de instalación del proyecto:

```bash
./scripts/install/install-base-tools.sh
```

O manualmente:

```bash
# Obtener última versión
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Descargar e instalar
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
```

### Alias del Proyecto

El proyecto incluye un alias para LazyGit:

```bash
lg  # Ejecuta lazygit
```

Este alias está definido en `configs/aliases/tools.zsh`.

---

## Uso Básico

### Iniciar LazyGit

```bash
# En cualquier repositorio Git
lazygit

# O usando el alias del proyecto
lg
```

### Vista Principal

LazyGit muestra varias secciones:

1. **Archivos** - Archivos modificados, nuevos y eliminados
2. **Ramas** - Ramas locales y remotas
3. **Commits** - Historial de commits
4. **Stash** - Stash guardados

### Navegación

- **↑/↓** - Moverse entre elementos
- **Enter** - Seleccionar elemento
- **Esc** - Volver atrás
- **q** - Salir

---

## Atajos de Teclado

### Generales

| Tecla | Acción |
|-------|--------|
| `q` | Salir |
| `Esc` | Volver atrás |
| `Enter` | Confirmar/Seleccionar |
| `Space` | Seleccionar múltiples |
| `/` | Buscar |

### Archivos (Pestaña 1)

| Tecla | Acción |
|-------|--------|
| `Space` | Staged/unstaged archivo |
| `d` | Descartar cambios |
| `e` | Editar archivo |
| `i` | Ignorar archivo |
| `a` | Staged todos los archivos |
| `A` | Unstaged todos los archivos |

### Ramas (Pestaña 2)

| Tecla | Acción |
|-------|--------|
| `n` | Nueva rama |
| `d` | Eliminar rama |
| `c` | Checkout rama |
| `m` | Merge rama |
| `r` | Rebase rama |
| `f` | Fetch remoto |

### Commits (Pestaña 3)

| Tecla | Acción |
|-------|--------|
| `c` | Commit |
| `C` | Commit con mensaje |
| `a` | Amend commit |
| `r` | Revert commit |
| `s` | Squash commits |
| `f` | Fixup commit |
| `d` | Drop commit |

### Stash (Pestaña 4)

| Tecla | Acción |
|-------|--------|
| `s` | Stash |
| `p` | Pop stash |
| `a` | Apply stash |
| `d` | Drop stash |

---

## Flujos de Trabajo Comunes

### Crear un nuevo commit

1. Abre LazyGit: `lazygit`
2. Ve a la pestaña de archivos (Pestaña 1)
3. Presiona `Space` para staged los archivos que quieres
4. Presiona `c` para crear commit
5. Escribe el mensaje del commit
6. Presiona `Enter` para confirmar

### Crear una nueva rama

1. Ve a la pestaña de ramas (Pestaña 2)
2. Presiona `n` para nueva rama
3. Escribe el nombre de la rama
4. Presiona `Enter`

### Cambiar de rama

1. Ve a la pestaña de ramas (Pestaña 2)
2. Navega a la rama deseada
3. Presiona `c` para checkout

### Merge de rama

1. Ve a la pestaña de ramas (Pestaña 2)
2. Navega a la rama que quieres merge
3. Presiona `m` para merge

### Stash cambios

1. Ve a la pestaña de archivos (Pestaña 1)
2. Selecciona los archivos con `Space`
3. Presiona `s` para stash

### Ver historial de commits

1. Ve a la pestaña de commits (Pestaña 3)
2. Navega con ↑/↓
3. Presiona `Enter` para ver detalles del commit

### Revertir un commit

1. Ve a la pestaña de commits (Pestaña 3)
2. Navega al commit que quieres revertir
3. Presiona `r` para revertir

### Squash commits

1. Ve a la pestaña de commits (Pestaña 3)
2. Selecciona los commits con `Space`
3. Presiona `s` para squash

---

## Configuración

### Archivo de configuración

LazyGit usa `~/.config/lazygit/config.yml` para configuración.

### Configuración básica

```yaml
gui:
  theme:
    activeBorderColor:
      - green
inactiveBorderColor:
  - white
optionsTextColor:
  - blue
selectedLineBgColor:
    - default
```

### Configuración de atajos personalizados

```yaml
keybinding:
  universal:
    quit: q
    quitWithoutSaving: Q
    return: esc
    quitAlt: ctrl+c
```

### Configuración de Git

LazyGit usa tu configuración de Git existente. No requiere configuración adicional.

---

## 📝 Notas

- LazyGit es más eficiente que usar comandos de Git directamente
- Los atajos de teclado son intuitivos y fáciles de recordar
- LazyGit muestra información visual que ayuda a entender el estado del repositorio
- El proyecto instala LazyGit automáticamente en `install-base-tools.sh`
- El alias `lg` está disponible después de ejecutar `install-aliases.sh`

---

## 🚀 Ejemplos Prácticos

### Flujo de trabajo típico

```bash
# 1. Iniciar lazygit
lg

# 2. Ver archivos modificados
# (Pestaña 1)

# 3. Staged archivos necesarios
# Presiona Space en cada archivo

# 4. Crear commit
# Presiona c, escribe mensaje, Enter

# 5. Crear nueva rama
# Ve a Pestaña 2, presiona n, nombre, Enter

# 6. Push a remoto
# Presiona p (si está configurado)
```

### Resolver conflictos de merge

```bash
# 1. Iniciar lazygit
lg

# 2. Intentar merge
# Ve a Pestaña 2, selecciona rama, presiona m

# 3. Si hay conflictos, LazyGit los mostrará
# 4. Presiona e para editar archivos con conflictos
# 5. Resuelve conflictos manualmente
# 6. Guarda archivos
# 7. Vuelve a LazyGit, presiona c para continuar
```

---

**Volver al [Índice](index.md)**
