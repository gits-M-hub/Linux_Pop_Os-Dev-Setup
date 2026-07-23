# 🔤 Docker Aliases

Documentación de los alias de Docker configurados en `configs/aliases/docker.zsh`.

## 📋 Tabla de Contenidos

- [Comandos Básicos](#comandos-básicos)
- [Gestión de Contenedores](#gestión-de-contenedores)
- [Gestión de Imágenes](#gestión-de-imágenes)
- [Gestión de Volúmenes](#gestión-de-volúmenes)
- [Gestión de Redes](#gestión-de-redes)
- [Limpieza](#limpieza)
- [Ejecución en Contenedores](#ejecución-en-contenedores)
- [Docker Compose](#docker-compose)
- [Estadísticas e Inspección](#estadísticas-e-inspección)
- [Configuración](#configuración)

---

## Comandos Básicos

### d
```bash
d
```
Alias para `docker`.

**Uso:**
```bash
d ps              # Equivale a docker ps
d images          # Equivale a docker images
d run nginx       # Equivale a docker run nginx
```

### dc
```bash
dc
```
Alias para `docker-compose`.

**Uso:**
```bash
dc up              # Equivale a docker-compose up
dc down            # Equivale a docker-compose down
dc ps              # Equivale a docker-compose ps
```

---

## Gestión de Contenedores

### dps
```bash
dps
```
Alias para `docker ps`.

Lista los contenedores que están **en ejecución** actualmente.

**Ejemplo:**
```bash
$ dps
CONTAINER ID   IMAGE     COMMAND              CREATED        STATUS        PORTS
abc123         nginx     "/docker-entrypoint"  2 minutes ago  Up 2 minutes  80/tcp
```

### dpsa
```bash
dpsa
```
Alias para `docker ps -a`.

Lista **todos** los contenedores, incluyendo los detenidos.

**Ejemplo:**
```bash
$ dpsa
CONTAINER ID   IMAGE     STATUS
abc123         nginx     Up 2 minutes
def456         postgres  Exited (0) 1 hour ago
```

### dstop
```bash
dstop <contenedor>
```
Alias para `docker stop`.

Detiene un contenedor en ejecución de forma elegante (envía SIGTERM).

**Uso:**
```bash
dstop abc123              # Detiene contenedor con ID abc123
dstop mi-nginx            # Detiene contenedor con nombre mi-nginx
```

### dkill
```bash
dkill <contenedor>
```
Alias para `docker kill`.

Detiene un contenedor inmediatamente (envía SIGKILL).

**Uso:**
```bash
dkill abc123              # Mata contenedor con ID abc123
```

---

## Gestión de Imágenes

### di
```bash
di
```
Alias para `docker images`.

Lista todas las imágenes Docker descargadas localmente.

**Ejemplo:**
```bash
$ di
REPOSITORY   TAG       SIZE
nginx        latest    142MB
postgres     13        374MB
alpine       latest    5.59MB
```

### dpull
```bash
dpull <imagen>
```
Alias para `docker pull`.

Descarga una imagen desde Docker Hub.

**Uso:**
```bash
dpull nginx:latest       # Descarga imagen nginx
dpull postgres:13        # Descarga imagen postgres 13
```

### dpush
```bash
dpush <imagen>
```
Alias para `docker push`.

Sube una imagen a un registry.

**Uso:**
```bash
dpush usuario/mi-app:1.0  # Sube imagen al registry
```

### dbuild
```bash
dbuild -t <nombre> .
```
Alias para `docker build`.

Construye una imagen desde un Dockerfile.

**Uso:**
```bash
dbuild -t mi-app:1.0 .   # Construye imagen con nombre mi-app:1.0
```

---

## Gestión de Volúmenes

### dvol
```bash
dvol
```
Alias para `docker volume ls`.

Lista todos los volúmenes Docker.

**Ejemplo:**
```bash
$ dvol
DRIVER    VOLUME NAME
local     db_data
local     app_data
```

### dvolrm
```bash
dvolrm <volumen>
```
Alias para `docker volume rm`.

Elimina un volumen Docker.

**Uso:**
```bash
dvolrm db_data           # Elimina volumen db_data
```

### dvolprune
```bash
dvolprune
```
Alias para `docker volume prune -f`.

Elimina todos los volúmenes no utilizados.

**⚠️ ADVERTENCIA:** Elimina volúmenes que no están siendo usados por ningún contenedor.

---

## Gestión de Redes

### dnet
```bash
dnet
```
Alias para `docker network ls`.

Lista todas las redes Docker.

**Ejemplo:**
```bash
$ dnet
NETWORK ID     NAME      DRIVER
abc123         bridge    bridge
def456         host      host
```

### dnetcreate
```bash
dnetcreate <nombre>
```
Alias para `docker network create`.

Crea una nueva red Docker.

**Uso:**
```bash
dnetcreate mi_red        # Crea red llamada mi_red
```

### dnetrm
```bash
dnetrm <red>
```
Alias para `docker network rm`.

Elimina una red Docker.

**Uso:**
```bash
dnetrm mi_red            # Elimina red mi_red
```

---

## Limpieza

### dprune
```bash
dprune
```
Alias para `docker system prune -f`.

Elimina recursos no utilizados:
- Contenedores detenidos
- Redes no utilizadas
- Imágenes huérfanas (dangling)
- Cache de build

**Uso:**
```bash
dprune                   # Limpieza básica
```

### dprunea
```bash
dprunea
```
Alias para `docker system prune -a -f`.

Limpieza profunda que también elimina:
- Todas las imágenes no utilizadas
- No solo las huérfanas

**⚠️ ADVERTENCIA:** Más agresivo que `dprune`.

**Uso:**
```bash
dprunea                  # Limpieza profunda
```

---

## Ejecución en Contenedores

### dex
```bash
dex <contenedor> <comando>
```
Alias para `docker exec -it`.

Ejecuta un comando en un contenedor en modo interactivo.

**Uso:**
```bash
dex mi-nginx bash         # Ejecuta bash en contenedor mi-nginx
dex mi-app python script.py  # Ejecuta script.py en contenedor mi-app
```

### dsh
```bash
dsh <contenedor>
```
Alias para `docker exec -it /bin/bash`.

Entra a un contenedor usando bash.

**Uso:**
```bash
dsh mi-nginx             # Entra a contenedor mi-nginx con bash
```

### dshz
```bash
dshz <contenedor>
```
Alias para `docker exec -it /bin/zsh`.

Entra a un contenedor usando zsh.

**Uso:**
```bash
dshz mi-nginx            # Entra a contenedor mi-nginx con zsh
```

---

## Docker Compose

### dce
```bash
dce <servicio> <comando>
```
Alias para `docker-compose exec`.

Ejecuta un comando en un servicio de docker-compose.

**Uso:**
```bash
dce web bash             # Ejecuta bash en servicio web
dce db psql -U postgres  # Ejecuta psql en servicio db
```

### dcb
```bash
dcb
```
Alias para `docker-compose build`.

Construye o reconstruye servicios.

**Uso:**
```bash
dcb                      # Construye todos los servicios
dcb web                  # Construye solo servicio web
```

### dcu
```bash
dcu
```
Alias para `docker-compose up`.

Crea y inicia contenedores.

**Uso:**
```bash
dcu                      # Inicia servicios en foreground
dcu -d                   # Inicia servicios en background
```

### dcd
```bash
dcd
```
Alias para `docker-compose down`.

Detiene y elimina contenedores, redes y volúmenes creados por up.

**Uso:**
```bash
dcd                      # Detiene y elimina todo
dcd -v                   # También elimina volúmenes
```

### dcp
```bash
dcp
```
Alias para `docker-compose ps`.

Lista contenedores del proyecto docker-compose.

**Ejemplo:**
```bash
$ dcp
NAME          STATUS    PORTS
project_web_1 Up       0.0.0.0:80->80/tcp
project_db_1  Up       5432/tcp
```

### dcl
```bash
dcl
```
Alias para `docker-compose logs`.

Muestra logs de los servicios.

**Uso:**
```bash
dcl                      # Muestra logs de todos los servicios
dcl web                  # Muestra logs de servicio web
```

### dclf
```bash
dclf
```
Alias para `docker-compose logs -f`.

Muestra logs en tiempo real (follow).

**Uso:**
```bash
dclf                     # Sigue logs de todos los servicios
dclf web                 # Sigue logs de servicio web
```

### dcup
```bash
dcup
```
Alias para `docker-compose up -d`.

Inicia servicios en background (detached).

**Uso:**
```bash
dcup                     # Inicia servicios en background
```

### dcdown
```bash
dcdown
```
Alias para `docker-compose down`.

Igual que `dcd`.

### dcrestart
```bash
dcrestart
```
Alias para `docker-compose restart`.

Reinicia servicios.

**Uso:**
```bash
dcrestart                # Reinicia todos los servicios
dcrestart web            # Reinicia solo servicio web
```

### dcstop
```bash
dcstop
```
Alias para `docker-compose stop`.

Detiene servicios.

**Uso:**
```bash
dcstop                   # Detiene todos los servicios
dcstop web               # Detiene solo servicio web
```

### dcstart
```bash
dcstart
```
Alias para `docker-compose start`.

Inicia servicios detenidos.

**Uso:**
```bash
dcstart                  # Inicia todos los servicios
dcstart web              # Inicia solo servicio web
```

---

## Estadísticas e Inspección

### dstats
```bash
dstats
```
Alias para `docker stats`.

Muestra estadísticas en tiempo real de contenedores:
- Uso de CPU
- Uso de memoria
- I/O de red
- I/O de disco

**Ejemplo:**
```bash
$ dstats
CONTAINER   NAME    CPU %   MEM USAGE / LIMIT
abc123      nginx   0.05%   12.5MiB / 7.77GiB
```

### dinsp
```bash
dinsp <objeto>
```
Alias para `docker inspect`.

Muestra información detallada de un objeto Docker (contenedor, imagen, volumen, red).

**Uso:**
```bash
dinsp abc123             # Inspecciona contenedor
dinsp nginx:latest       # Inspecciona imagen
dinsp db_data            # Inspecciona volumen
```

---

## Comandos de Ejecución

### drun
```bash
drun <imagen>
```
Alias para `docker run -it`.

Ejecuta un contenedor en modo interactivo.

**Uso:**
```bash
drun ubuntu              # Ejecuta ubuntu en modo interactivo
drun alpine sh           # Ejecuta alpine con sh
```

### drund
```bash
drund <imagen>
```
Alias para `docker run -it -d`.

Ejecuta un contenedor en modo interactivo y en background.

**Uso:**
```bash
drund nginx              # Ejecuta nginx en background
```

---

## Configuración

### Cargar los alias

Para usar estos alias, añade lo siguiente a tu `~/.zshrc`:

```bash
# Docker aliases
source ~/Projects/linux-dev-setup/configs/aliases/docker.zsh
```

Luego recarga tu configuración:

```bash
source ~/.zshrc
```

---

## 📝 Notas

- Estos alias están diseñados para ser **mnemónicos** y fáciles de recordar
- Prefijos: `d` para Docker, `dc` para Docker Compose
- La mayoría de los alias son abreviaturas intuitivas
- Algunos alias incluyen opciones comunes por defecto (como `-it` para modo interactivo)

---

**Volver al [Índice](index.md)**
