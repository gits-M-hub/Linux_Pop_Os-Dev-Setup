# 🐘 Instalación de PostgreSQL en Pop!_OS

Guía completa para instalar y configurar PostgreSQL en Pop!_OS (Ubuntu/Debian).

## 📋 Tabla de Contenidos

- [¿Qué es PostgreSQL?](#qué-es-postgresql)
- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Configuración Inicial](#configuración-inicial)
- [Verificación](#verificación)
- [Configuración de Seguridad](#configuración-de-seguridad)
- [Configuración de Acceso Remoto](#configuración-de-acceso-remoto)
- [Solución de Problemas](#solución-de-problemas)

---

## ¿Qué es PostgreSQL?

PostgreSQL es un sistema de gestión de bases de datos relacional de código abierto, robusto y altamente escalable. Es conocido por:

- **Fiabilidad**: Probado en entornos de producción de alta carga
- **Extensibilidad**: Soporta procedimientos almacenados, triggers y funciones personalizadas
- **Estándares SQL**: Cumple con los estándares SQL más estrictos
- **Tipos de datos avanzados**: JSON, XML, arrays, tipos geométricos, etc.
- **Rendimiento**: Optimizado para consultas complejas y grandes volúmenes de datos

---

## Requisitos Previos

- Sistema Pop!_OS o Ubuntu/Debian
- Acceso a terminal con privilegios de sudo
- Conexión a internet (para descargar paquetes)

---

## Instalación

### 1. Actualizar el sistema

Antes de instalar, actualiza los paquetes del sistema:

```bash
sudo apt update
sudo apt upgrade -y
```

### 2. Instalar PostgreSQL

Instala PostgreSQL y sus herramientas adicionales:

```bash
sudo apt install postgresql postgresql-contrib -y
```

**Explicación de paquetes:**
- `postgresql`: Servidor de base de datos PostgreSQL
- `postgresql-contrib`: Módulos adicionales (extensiones, funciones)

### 3. Verificar la versión instalada

```bash
psql --version
```

Salida esperada:
```
psql (PostgreSQL) 14.x (Ubuntu 14.x-0ubuntu0.22.04.x)
```

---

## Configuración Inicial

### 1. El usuario postgres

PostgreSQL crea automáticamente un usuario del sistema llamado `postgres` que es el superusuario de la base de datos.

### 2. Cambiar al usuario postgres

```bash
sudo -i -u postgres
```

### 3. Acceder a la consola de PostgreSQL

```bash
psql
```

Verás el prompt de PostgreSQL:
```
postgres=#
```

### 4. Establecer contraseña para el usuario postgres

Dentro de la consola psql:

```sql
ALTER USER postgres WITH PASSWORD 'tu_contraseña_segura';
```

### 5. Salir de psql

```sql
\q
```

### 6. Volver a tu usuario normal

```bash
exit
```

---

## Verificación

### 1. Verificar el estado del servicio

```bash
sudo systemctl status postgresql
```

Salida esperada:
```
● postgresql.service - PostgreSQL database server
     Loaded: loaded (/lib/systemd/system/postgresql.service; enabled; vendor preset: enabled)
     Active: active (active) since...
```

### 2. Verificar si PostgreSQL está aceptando conexiones

```bash
pg_isready
```

Salida esperada:
```
/var/run/postgresql:5432 - accepting connections
```

### 3. Verificar el puerto

```bash
sudo ss -tulpn | grep 5432
```

Salida esperada:
```
tcp   LISTEN 0   128   0.0.0.0:5432   0.0.0.0:*
```

---

## Configuración de Seguridad

### 1. Configurar autenticación por contraseña

Edita el archivo de configuración de autenticación:

```bash
sudo nano /etc/postgresql/14/main/pg_hba.conf
```

Busca las líneas que empiezan con `local` y cámbialas a `md5`:

```bash
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             postgres                                md5
local   all             all                                     md5
host    all             all             127.0.0.1/32            md5
host    all             all             ::1/128                 md5
```

**Explicación:**
- `md5`: Autenticación con contraseña encriptada
- `local`: Conexiones vía socket Unix
- `host`: Conexiones vía TCP/IP

### 2. Reiniciar PostgreSQL para aplicar cambios

```bash
sudo systemctl restart postgresql
```

### 3. Crear un usuario normal (opcional)

Es mejor práctica crear un usuario normal en lugar de usar `postgres`:

```bash
sudo -u postgres createuser --interactive
```

Sigue las instrucciones:
```
Enter name of role to add: tu_usuario
Shall the new role be a superuser? (y/n) n
Shall the new role be allowed to create databases? (y/n) y
Shall the new role be allowed to create more new roles? (y/n) n
```

### 4. Crear una base de datos para el usuario

```bash
sudo -u postgres createdb tu_usuario
```

---

## Configuración de Acceso Remoto

### 1. Editar configuración de escucha

```bash
sudo nano /etc/postgresql/14/main/postgresql.conf
```

Busca y modifica la línea `listen_addresses`:

```bash
listen_addresses = '*'  # Escucha en todas las interfaces
# o
listen_addresses = 'localhost,192.168.1.100'  # IPs específicas
```

### 2. Configurar pg_hba.conf para conexiones remotas

```bash
sudo nano /etc/postgresql/14/main/pg_hba.conf
```

Añade esta línea al final:

```bash
host    all             all             192.168.1.0/24          md5
```

**Explicación:**
- Permite conexiones desde la red `192.168.1.0/24`
- Usa autenticación md5 (contraseña)

### 3. Reiniciar PostgreSQL

```bash
sudo systemctl restart postgresql
```

### 4. Configurar firewall (si usas UFW)

```bash
sudo ufw allow from 192.168.1.0/24 to any port 5432
```

---

## Solución de Problemas

### Problema: No puedo conectar a PostgreSQL

**Verificar:**
1. El servicio está corriendo:
```bash
sudo systemctl status postgresql
```

2. El puerto está escuchando:
```bash
sudo ss -tulpn | grep 5432
```

3. Los archivos de configuración son correctos:
```bash
sudo postgresql -C config_file
```

### Problema: Error de autenticación

**Solución:**
1. Verifica `pg_hba.conf`:
```bash
sudo cat /etc/postgresql/14/main/pg_hba.conf
```

2. Reinicia PostgreSQL después de cambios:
```bash
sudo systemctl restart postgresql
```

### Problema: No puedo entrar como usuario postgres

**Solución:**
```bash
sudo -i -u postgres psql
```

### Problema: Puerto 5432 ya está en uso

**Solución:**
1. Ver qué está usando el puerto:
```bash
sudo lsof -i :5432
```

2. Cambia el puerto en `postgresql.conf`:
```bash
port = 5433
```

3. Reinicia PostgreSQL:
```bash
sudo systemctl restart postgresql
```

---

## Comandos Útiles

### Iniciar/Detener/Reiniciar PostgreSQL

```bash
sudo systemctl start postgresql    # Iniciar
sudo systemctl stop postgresql     # Detener
sudo systemctl restart postgresql  # Reiniciar
sudo systemctl enable postgresql   # Habilitar al inicio
sudo systemctl disable postgresql  # Deshabilitar al inicio
```

### Ver directorio de datos

```bash
sudo -u postgres psql -c 'SHOW data_directory;'
```

### Ver todas las bases de datos

```bash
sudo -u postgres psql -l
```

### Ver conexiones activas

```bash
sudo -u postgres psql -c "SELECT * FROM pg_stat_activity;"
```

---

## Solución de Problemas

### Error: "role does not exist" al ejecutar psql

Si al ejecutar `psql` obtienes este error:

```
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  role "tu_usuario" does not exist
```

**Causa:** PostgreSQL intenta conectarte como el usuario actual del sistema a una base de datos con el mismo nombre, pero ese usuario no existe como role en PostgreSQL.

**Soluciones:**

#### Opción 1: Conectarte como usuario postgres (recomendado para administración)

```bash
sudo -u postgres psql
```

#### Opción 2: Crear tu usuario en PostgreSQL (recomendado para uso diario)

```bash
# Conecta como postgres primero
sudo -u postgres psql

# Crea tu usuario con contraseña
CREATE USER maximilianobalam WITH PASSWORD 'tu_contraseña';

# Otorga privilegios de superusuario (opcional)
ALTER USER maximilianobalam WITH SUPERUSER;

# Crea una base de datos con tu nombre
CREATE DATABASE maximilianobalam OWNER maximilianobalam;

# Sal de psql
\q
```

Luego podrás entrar directamente con:

```bash
psql
```

#### Opción 3: Especificar usuario explícitamente

```bash
psql -U postgres
```

#### Opción 4: Usar el alias configurado

```bash
psql-admin
```

**Recomendación:** La opción 2 es la más conveniente para uso diario. Una vez creado tu usuario, podrás entrar simplemente con `psql` sin especificar argumentos.

---

## Alias Configurados

El proyecto incluye alias en `configs/aliases/postgres.zsh`:

```bash
pg-status      # Estado del servicio
pg-start       # Iniciar PostgreSQL
pg-stop        # Detener PostgreSQL
pg-restart     # Reiniciar PostgreSQL
pg-ready       # Verificar si acepta conexiones
pg-port        # Ver qué proceso está en el puerto 5432
pg-process     # Ver procesos de postgres
pg-data        # Ver directorio de datos
psql-admin     # Entrar como usuario postgres
```

Para cargar estos alias, ejecuta:
```bash
~/Projects/linux-dev-setup/scripts/install/install-aliases.sh
```

---

## 📝 Notas

- PostgreSQL se instala por defecto en `/var/lib/postgresql/14/main/`
- Los archivos de configuración están en `/etc/postgresql/14/main/`
- El puerto por defecto es 5432
- El superusuario es `postgres`
- Es recomendable crear usuarios normales para desarrollo

---

**Volver al [Índice](../index.md)**
