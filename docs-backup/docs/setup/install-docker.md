# 🐳 Instalación de Docker

Guía completa para instalar Docker y Docker Compose en Pop!_OS.

## 📋 Tabla de Contenidos

- [¿Qué es Docker?](#qué-es-docker)
- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Configuración Post-Instalación](#configuración-post-instalación)
- [Verificación](#verificación)
- [Docker Compose](#docker-compose)
- [Solución de Problemas](#solución-de-problemas)

---

## ¿Qué es Docker?

Docker es una plataforma de contenedores que permite empaquetar aplicaciones y sus dependencias en contenedores portátiles.

**Características principales:**
- Aislamiento de aplicaciones
- Portabilidad entre sistemas
- Consistencia en desarrollo y producción
- Gestión eficiente de recursos
- Ecosistema extenso de imágenes

---

## Requisitos Previos

- Sistema Pop!_OS o Ubuntu 20.04+
- Acceso a terminal con privilegios de sudo
- Conexión a internet

---

## Instalación

### Método 1: Desde repositorio oficial de Docker (Recomendado)

#### 1. Actualizar el índice de paquetes

```bash
sudo apt update
```

#### 2. Instalar dependencias necesarias

```bash
sudo apt install -y ca-certificates curl gnupg
```

#### 3. Añadir la clave GPG oficial de Docker

```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

#### 4. Configurar el repositorio

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

#### 5. Actualizar el índice de paquetes

```bash
sudo apt update
```

#### 6. Instalar Docker Engine

```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Método 2: Desde repositorio de Ubuntu

```bash
sudo apt update
sudo apt install -y docker.io docker-compose
```

**Nota:** Este método puede tener versiones más antiguas de Docker.

---

## Configuración Post-Instalación

### Añadir usuario al grupo docker

Esto permite ejecutar Docker sin sudo:

```bash
sudo usermod -aG docker $USER
```

**Importante:** Necesitas cerrar sesión y volver a entrar para que el cambio surta efecto.

### Habilitar Docker al inicio

```bash
sudo systemctl enable docker
```

### Iniciar Docker

```bash
sudo systemctl start docker
```

### Verificar estado de Docker

```bash
sudo systemctl status docker
```

---

## Verificación

### Ver versión de Docker

```bash
docker --version
```

### Ver versión de Docker Compose

```bash
docker compose version
```

### Ejecutar contenedor de prueba

```bash
docker run hello-world
```

Deberías ver un mensaje indicando que la instalación funciona correctamente.

### Ver información del sistema Docker

```bash
docker info
```

### Ver contenedores en ejecución

```bash
docker ps
```

### Ver todas las imágenes

```bash
docker images
```

---

## Docker Compose

Docker Compose v2 está incluido como plugin en la instalación moderna.

### Usar Docker Compose

```bash
# Crear archivo docker-compose.yml
cat > docker-compose.yml << EOF
version: '3.8'
services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
EOF

# Iniciar servicios
docker compose up -d

# Ver logs
docker compose logs

# Detener servicios
docker compose down
```

### Comandos útiles de Docker Compose

```bash
docker compose up -d          # Iniciar en modo detached
docker compose down           # Detener y eliminar contenedores
docker compose logs -f        # Ver logs en tiempo real
docker compose ps             # Ver contenedores
docker compose restart        # Reiniciar servicios
docker compose build          # Reconstruir imágenes
docker compose pull           # Actualizar imágenes
```

---

## Solución de Problemas

### Error: "permission denied while trying to connect to the Docker daemon socket"

**Causa:** El usuario no está en el grupo docker.

**Solución:**
```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Error: "Cannot connect to the Docker daemon"

**Causa:** El servicio Docker no está ejecutándose.

**Solución:**
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

### Error: "Got permission denied while trying to connect to the Docker daemon socket"

**Causa:** Permisos incorrectos en el socket de Docker.

**Solución:**
```bash
sudo chmod 666 /var/run/docker.sock
```

### Limpiar Docker si hay problemas

```bash
# Detener Docker
sudo systemctl stop docker

# Limpiar contenedores
sudo docker container prune -f

# Limpiar imágenes
sudo docker image prune -a -f

# Limpiar volúmenes
sudo docker volume prune -f

# Limpiar redes
sudo docker network prune -f

# Reiniciar Docker
sudo systemctl start docker
```

### Usar script de limpieza del proyecto

El proyecto incluye scripts útiles en `scripts/docker/`:

```bash
# Verificar instalación de Docker
./scripts/docker/docker-doctor.sh

# Limpiar recursos de Docker
./scripts/docker/docker-clean.sh

# Reset completo de Docker
./scripts/docker/docker-reset.sh
```

---

## 📝 Notas

- Docker se instala en `/var/lib/docker/`
- La configuración de Docker está en `/etc/docker/`
- El socket de Docker está en `/var/run/docker.sock`
- Para usar Docker sin sudo, tu usuario debe estar en el grupo `docker`
- El proyecto incluye alias de Docker en `configs/aliases/docker.zsh`
- Los scripts de Docker del proyecto están en `scripts/docker/`

---

**Volver al [Índice](../index.md)**
