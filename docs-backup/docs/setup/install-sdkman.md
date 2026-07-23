# ☕ Instalación de SDKMAN!

Guía completa para instalar SDKMAN! y gestionar Java, Kotlin y Gradle en Pop!_OS.

## 📋 Tabla de Contenidos

- [¿Qué es SDKMAN!?](#qué-es-sdkman)
- [Instalación](#instalación)
- [Configuración](#configuración)
- [Instalar Java](#instalar-java)
- [Instalar Kotlin](#instalar-kotlin)
- [Instalar Gradle](#instalar-gradle)
- [Gestión de Versiones](#gestión-de-versiones)
- [Verificación](#verificación)

---

## ¿Qué es SDKMAN?

SDKMAN! es un gestor de versiones paralelas para múltiples SDKs (Software Development Kits) en sistemas Unix.

**SDKs soportados:**
- Java (JDKs)
- Kotlin
- Gradle
- Groovy
- Scala
- Maven
- Y más...

**Características principales:**
- Gestión de múltiples versiones del mismo SDK
- Cambio fácil entre versiones
- Instalación automática de dependencias
- Configuración de variables de entorno
- Comunidad activa

---

## Instalación

### Verificar si SDKMAN! está instalado

```bash
sdk version
```

### Instalar SDKMAN!

```bash
curl -s "https://get.sdkman.io" | bash
```

### Recargar el shell

```bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

### Verificar instalación

```bash
sdk version
```

Deberías ver la versión de SDKMAN! instalada.

---

## Configuración

### Ver configuración actual

```bash
sdk config
```

### Cambiar directorio de instalación

```bash
sdk config sdkman_dir "/ruta/personalizada"
```

### Habilitar auto-actualización

```bash
sdk config selfupdate_enable true
```

### Configurar versión por defecto de un SDK

```bash
sdk default java 21.0.1-tem
```

---

## Instalar Java

### Listar versiones disponibles de Java

```bash
sdk list java
```

### Instalar Java 21 LTS (Recomendado)

```bash
sdk install java 21.0.1-tem
```

### Instalar Java 17 LTS

```bash
sdk install java 17.0.9-tem
```

### Instalar Java 11 LTS

```bash
sdk install java 11.0.21-tem
```

### Establecer Java por defecto

```bash
sdk default java 21.0.1-tem
```

### Ver versión de Java instalada

```bash
java -version
```

### Ver todas las versiones de Java instaladas

```bash
sdk list java | grep installed
```

### Cambiar entre versiones de Java

```bash
sdk use java 17.0.9-tem
```

---

## Instalar Kotlin

### Listar versiones disponibles de Kotlin

```bash
sdk list kotlin
```

### Instalar última versión de Kotlin

```bash
sdk install kotlin
```

### Instalar versión específica

```bash
sdk install kotlin 1.9.22
```

### Establecer Kotlin por defecto

```bash
sdk default kotlin
```

### Ver versión de Kotlin instalada

```bash
kotlinc -version
```

### Compilar y ejecutar un programa Kotlin

```bash
# Crear archivo
cat > Hello.kt << EOF
fun main() {
    println("Hello, World!")
}
EOF

# Compilar
kotlinc Hello.kt -include-runtime -d Hello.jar

# Ejecutar
java -jar Hello.jar
```

---

## Instalar Gradle

### Listar versiones disponibles de Gradle

```bash
sdk list gradle
```

### Instalar última versión de Gradle

```bash
sdk install gradle
```

### Instalar versión específica

```bash
sdk install gradle 8.5
```

### Establecer Gradle por defecto

```bash
sdk default gradle
```

### Ver versión de Gradle instalada

```bash
gradle --version
```

### Crear proyecto Gradle

```bash
# Crear proyecto Kotlin
gradle init --type kotlin-application

# Crear proyecto Java
gradle init --type java-application
```

---

## Gestión de Versiones

### Listar todos los SDKs instalados

```bash
sdk list
```

### Listar versiones instaladas de un SDK específico

```bash
sdk list java
```

### Ver versión actual en uso

```bash
sdk current
```

### Ver versión actual de un SDK específico

```bash
sdk current java
```

### Cambiar versión temporalmente

```bash
sdk use java 17.0.9-tem
```

### Cambiar versión por defecto

```bash
sdk default java 17.0.9-tem
```

### Desinstalar una versión

```bash
sdk uninstall java 11.0.21-tem
```

### Actualizar un SDK

```bash
sdk upgrade java
```

### Limpiar versiones antiguas

```bash
sdk flush java
```

### Actualizar SDKMAN!

```bash
sdk selfupdate
```

---

## Verificación

### Verificar SDKMAN!

```bash
sdk version
```

### Verificar Java

```bash
java -version
```

### Verificar Kotlin

```bash
kotlinc -version
```

### Verificar Gradle

```bash
gradle --version
```

### Verificar todas las instalaciones

```bash
sdk current
```

---

## 📝 Notas

- SDKMAN! se instala en `~/.sdkman/`
- Los SDKs se instalan en `~/.sdkman/candidates/`
- La configuración de SDKMAN! está en `~/.sdkman/etc/config`
- Para usar SDKMAN! en cada sesión, añade `source "$HOME/.sdkman/bin/sdkman-init.sh"` a tu `~/.zshrc`
- El proyecto incluye la configuración de SDKMAN! en `configs/exports/sdkman.zsh`
- El script de instalación del proyecto configura SDKMAN! automáticamente

---

## 🚀 Comandos Útiles

```bash
# Ayuda
sdk help

# Buscar un SDK
sdk search java

# Ver información de un SDK
sdk info java

# Ver versión de un SDK
sdk version java

# Instalar versión por defecto
sdk install java

# Usar versión específica
sdk use java 21.0.1-tem

# Establecer por defecto
sdk default java 21.0.1-tem

# Listar instalados
sdk list java

# Desinstalar
sdk uninstall java 11.0.21-tem

# Actualizar SDKMAN!
sdk selfupdate
```

---

**Volver al [Índice](../index.md)**
