# 🆘 Linux Survival Guide

Guía de supervivencia para situaciones comunes en Linux. Lecciones aprendidas por experiencia propia.

## 📋 Tabla de Contenidos

- [Comandos que "atrapan" la terminal](#comandos-que-atrapan-la-terminal)
- [Verificar directorio actual](#verificar-directorio-actual)
- [Comandos de emergencia](#comandos-de-emergencia)
- [Tips útiles](#tips-útiles)

---

## 🚪 Comandos que "atrapan" la terminal

### less

Si un comando parece "atrapar" la terminal (como `less`, `man`, `git log`, etc.):

- Presiona `q` para salir
- Presiona `Ctrl + C` para interrumpir

**Comandos comunes que usan `less`:**
- `less archivo.txt`
- `man comando`
- `git log`
- `git diff`

---

## 📍 Verificar directorio actual

Antes de crear archivos, comprobar siempre:

```bash
pwd
```

Esto evita crear archivos en ubicaciones incorrectas.

**Por qué es importante:**
- Evita contaminar el sistema de archivos
- Te mantiene consciente de tu ubicación
- Previene errores de ruta

---

## 🚨 Comandos de emergencia

### Cancelar comando en ejecución

```bash
Ctrl + C
```

### Salir de programas interactivos

```bash
q
# o
Ctrl + D
```

### Limpiar terminal

```bash
clear
# o
Ctrl + L
```

### Ver historial de comandos

```bash
history
```

### Repetir último comando

```bash
!!
```

### Buscar en historial

```bash
Ctrl + R
# Luego escribe lo que buscas
```

---

## 💡 Tips útiles

### Autocompletado

Usa `Tab` para autocompletar rutas y comandos:

```bash
cd doc<Tab>  # Se convierte en cd docs/
```

### Ver contenido de archivo sin editarlo

```bash
cat archivo.txt
# o con resaltado de sintaxis
bat archivo.txt
```

### Ver las últimas líneas de un archivo

```bash
tail archivo.txt
# o en tiempo real
tail -f archivo.log
```

### Buscar texto en archivos

```bash
grep "texto" archivo.txt
```

### Ver procesos en ejecución

```bash
ps aux
# o
htop
```

---

## 📝 Notas

Esta guía se irá actualizando conforme se encuentren nuevas situaciones de emergencia.

**Volver al [Índice](/docs/index.md)**