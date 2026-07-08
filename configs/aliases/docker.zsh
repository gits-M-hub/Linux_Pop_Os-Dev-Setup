# ==========================
# Docker Aliases
# ==========================
# Prefijo 'd' para comandos de Docker
# Prefijo 'dc' para comandos de Docker Compose
# Abreviaciones mnemónicas: ps = process status, vol = volume, net = network, prune = limpiar

# Docker basic commands
# d = docker (abreviación de la primera letra)
alias d='docker'
# dc = docker-compose (d + c = docker compose)
alias dc='docker-compose'
# dce = docker-compose exec (d + c + e = docker compose exec)
alias dce='docker-compose exec'
# dcb = docker-compose build (d + c + b = docker compose build)
alias dcb='docker-compose build'
# dcu = docker-compose up (d + c + u = docker compose up)
alias dcu='docker-compose up'
# dcd = docker-compose down (d + c + d = docker compose down)
alias dcd='docker-compose down'
# dcp = docker-compose ps (d + c + p = docker compose process status)
alias dcp='docker-compose ps'
# dcl = docker-compose logs (d + c + l = docker compose logs)
alias dcl='docker-compose logs'
# dclf = docker-compose logs -f (d + c + l + f = docker compose logs follow)
alias dclf='docker-compose logs -f'

# Docker container management
# dps = docker process status (d + ps = docker process status)
alias dps='docker ps'
# dpsa = docker process status all (d + ps + a = docker process status all)
alias dpsa='docker ps -a'
# di = docker images (d + i = docker images)
alias di='docker images'
# dvol = docker volume (d + vol = docker volume)
alias dvol='docker volume ls'
# dnet = docker network (d + net = docker network)
alias dnet='docker network ls'

# Docker cleanup
# dprune = docker prune (d + prune = docker prune/clean)
alias dprune='docker system prune -f'
# dprunea = docker prune all (d + prune + a = docker prune all - más agresivo)
alias dprunea='docker system prune -a -f'
# dvolprune = docker volume prune (d + vol + prune = docker volume prune)
alias dvolprune='docker volume prune -f'

# Docker exec shortcuts
# dex = docker exec (d + ex = docker exec)
alias dex='docker exec -it'
# dsh = docker shell (d + sh = docker shell - entra con bash)
alias dsh='docker exec -it /bin/bash'
# dshz = docker shell zsh (d + sh + z = docker shell zsh - entra con zsh)
alias dshz='docker exec -it /bin/zsh'

# Docker stats
# dstats = docker stats (d + stats = docker statistics)
alias dstats='docker stats'

# Docker inspect
# dinsp = docker inspect (d + insp = docker inspect)
alias dinsp='docker inspect'

# Docker run shortcuts
# drun = docker run (d + run = docker run)
alias drun='docker run -it'
# drund = docker run detached (d + run + d = docker run detached/background)
alias drund='docker run -it -d'

# Docker compose shortcuts
# dcup = docker compose up (d + c + up = docker compose up - en background)
alias dcup='docker-compose up -d'
# dcdown = docker compose down (d + c + down = docker compose down)
alias dcdown='docker-compose down'
# dcrestart = docker compose restart (d + c + restart = docker compose restart)
alias dcrestart='docker-compose restart'
# dcstop = docker compose stop (d + c + stop = docker compose stop)
alias dcstop='docker-compose stop'
# dcstart = docker compose start (d + c + start = docker compose start)
alias dcstart='docker-compose start'
