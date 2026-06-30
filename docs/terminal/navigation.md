# 🧭 Navegación en Linux

Guía completa de comandos para navegar y gestionar archivos en el sistema Linux.

## 📋 Tabla de Contenidos

- [Ubicación](#ubicación)
- [Navegación](#navegación)
- [Listado de archivos](#listado-de-archivos)
- [Gestión de archivos](#gestión-de-archivos)
- [Búsqueda](#búsqueda)
- [Utilidades](#utilidades)

---

## 📍 Ubicación

### Saber dónde estoy

```bash
pwd
```

Muestra el directorio de trabajo actual (Print Working Directory).

---

### Ir al directorio personal

```bash
cd
```

o

```bash
cd ~
```

`~` es un atajo para tu directorio personal (home).

---

## 🔄 Navegación

### Cambiar de carpeta

```bash
cd Carpeta
```

Cambia al directorio especificado.

**Tips:**
- Usa `Tab` para autocompletar nombres de carpetas
- Puedes navegar múltiples niveles: `cd docs/terminal`

---

### Volver atrás

```bash
cd ..
```

`..` representa el directorio padre.

**Volver múltiples niveles:**
```bash
cd ../..    # Dos niveles atrás
cd ../../.. # Tres niveles atrás
```

---

### Volver al directorio anterior

```bash
cd -
```

Alterna entre el directorio actual y el anterior.

---

## 📂 Listado de archivos

### Mostrar archivos

```bash
ls
```

Lista los archivos y directorios en el directorio actual.

---

### Mostrar información detallada

```bash
ls -lah
```

- `-l`: formato largo (permisos, propietario, tamaño, fecha)
- `-a`: muestra archivos ocultos (empiezan con `.`)
- `-h`: tamaños en formato legible (KB, MB, GB)

---

### Ver estructura del proyecto

```bash
tree
```

Muestra la estructura de directorios en formato de árbol.

**Limitar profundidad:**
```bash
tree -L 2  # Muestra hasta 2 niveles de profundidad
tree -L 3  # Muestra hasta 3 niveles de profundidad
```

---

## 📁 Gestión de archivos

### Crear carpetas

```bash
mkdir nombre
```

Crear múltiples carpetas anidadas:

```bash
mkdir -p ruta/completa/a/archivo
```

`-p` crea directorios padre si no existen.

---

### Crear archivos

```bash
touch archivo.txt
```

Crea un archivo vacío o actualiza la fecha de modificación si existe.

**Crear múltiples archivos:**
```bash
touch archivo1.txt archivo2.txt archivo3.txt
```

---

### Copiar

```bash
cp origen destino
```

Copia un archivo o directorio.

**Opciones útiles:**
```bash
cp -r carpeta destino  # Copia directorio recursivamente
cp -i origen destino  # Pide confirmación antes de sobrescribir
```

---

### Mover o renombrar

```bash
mv origen destino
```

Mueve o renombra archivos y directorios.

**Ejemplos:**
```bash
mv archivo.txt nuevo_nombre.txt  # Renombrar
mv archivo.txt /ruta/destino/    # Mover
```

---

### Eliminar

```bash
rm archivo
```

Elimina archivos.

**⚠️ ADVERTENCIA:** `rm` es irreversible. Úsalo con cuidado.

**Opciones:**
```bash
rm -r carpeta        # Elimina directorio recursivamente
rm -i archivo        # Pide confirmación antes de eliminar
rm -rf carpeta       # Elimina sin confirmación (peligroso)
```

---

## 🔍 Búsqueda

### Buscar archivos por nombre

```bash
find . -name "*.md"
```

Busca archivos que coinciden con un patrón.

**Ejemplos:**
```bash
find . -name "*.txt"           # Archivos .txt
find /home -name "config.json" # En todo /home
find . -type d -name "docs"    # Solo directorios
```

---

### Buscar contenido en archivos

```bash
grep "texto" archivo.txt
```

Busca texto dentro de archivos.

**Opciones útiles:**
```bash
grep -r "texto" .      # Busca recursivamente en directorio actual
grep -i "texto" .      # Búsqueda case-insensitive
grep -n "texto" .      # Muestra número de línea
```

---

## 🔧 Utilidades

### Recargar Zsh

```bash
source ~/.zshrc
```

Recarga la configuración de Zsh después de modificar `~/.zshrc`.

---

### Verificar si un programa está instalado

```bash
command -v programa
```

Devuelve la ruta del programa si está instalado, o nada si no lo está.

**Ejemplo:**
```bash
command -v git   # /usr/bin/git
command -v programa_inexistente  # (no devuelve nada)
```

---

### Limpiar terminal

```bash
clear
```

o

```bash
Ctrl + L
```

Limpia la pantalla de la terminal.

---

## 📝 Tips adicionales

- **Autocompletado:** Usa `Tab` para autocompletar comandos y rutas
- **Historial:** Usa `Ctrl + R` para buscar en el historial de comandos
- **Cancelar:** Usa `Ctrl + C` para cancelar un comando en ejecución
- **Verificar antes:** Usa `pwd` antes de crear archivos para confirmar ubicación

---

**Volver al [Índice](/docs/index.md)**