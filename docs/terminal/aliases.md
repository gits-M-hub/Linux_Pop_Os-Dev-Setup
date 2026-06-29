# 🔤 Alias

Los alias permiten ejecutar comandos largos utilizando nombres cortos, mejorando la productividad en la terminal.

## 📋 Tabla de Contenidos

- [Git](#git)
- [Herramientas](#herramientas)
- [Sistema](#sistema)
- [Configuración](#configuración)

---

## 🌿 Git

### gs - Git Status

```bash
gs
```

Equivale a:

```bash
git status
```

Muestra el estado de los archivos en el repositorio.

---

### ga - Git Add

```bash
ga
```

Equivale a:

```bash
git add
```

Añade archivos al área de staging.

**Uso común:**
```bash
ga .           # Añadir todos los archivos
ga archivo.txt # Añadir archivo específico
```

---

### gc - Git Commit

```bash
gc
```

Equivale a:

```bash
git commit
```

Crea un nuevo commit con los cambios staged.

**Uso común:**
```bash
gc -m "mensaje" # Commit con mensaje
```

---

### gp - Git Push

```bash
gp
```

Equivale a:

```bash
git push
```

Envía los commits al repositorio remoto.

---

### gl - Git Pull

```bash
gl
```

Equivale a:

```bash
git pull
```

Actualiza el repositorio local con los cambios remotos.

---

## 🛠️ Herramientas

### lg - LazyGit

```bash
lg
```

Abre LazyGit, una interfaz de Git para la terminal.

**Para más información:** [`tools.md`](tools.md#lazygit)

---

### yz - Yazi

```bash
yz
```

Abre Yazi, un administrador de archivos moderno para la terminal.

**Para más información:** [`tools.md`](tools.md#yazi)

---

## 💻 Sistema

### cat - Bat (Cat mejorado)

```bash
cat archivo.txt
```

Utiliza internamente:

```bash
batcat
```

Muestra archivos con resaltado de sintaxis, numeración de líneas y más.

**Ventajas sobre `cat` original:**
- Resaltado de sintaxis
- Numeración de líneas
- Integración con Git
- Paginación automática

---

## ⚙️ Configuración

Los alias se configuran en el archivo `~/.zshrc`.

**Ejemplo de configuración:**
```bash
# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# Herramientas
alias lg='lazygit'
alias yz='yazi'

# Sistema
alias cat='batcat'
```

Para aplicar cambios después de modificar `~/.zshrc`:

```bash
source ~/.zshrc
```

---

## 📝 Notas

Este documento debe actualizarse cada vez que se cree un nuevo alias.

**Volver al [Índice](../index.md)**