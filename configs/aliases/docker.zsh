# Docker Aliases

# Docker basic commands
alias d='docker'
alias dc='docker-compose'
alias dce='docker-compose exec'
alias dcb='docker-compose build'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcp='docker-compose ps'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'

# Docker container management
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dvol='docker volume ls'
alias dnet='docker network ls'

# Docker cleanup
alias dprune='docker system prune -f'
alias dprunea='docker system prune -a -f'
alias dvolprune='docker volume prune -f'

# Docker exec shortcuts
alias dex='docker exec -it'
alias dsh='docker exec -it /bin/bash'
alias dshz='docker exec -it /bin/zsh'

# Docker stats
alias dstats='docker stats'

# Docker inspect
alias dinsp='docker inspect'

# Docker run shortcuts
alias drun='docker run -it'
alias drund='docker run -it -d'

# Docker compose shortcuts
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'
alias dcrestart='docker-compose restart'
alias dcstop='docker-compose stop'
alias dcstart='docker-compose start'
