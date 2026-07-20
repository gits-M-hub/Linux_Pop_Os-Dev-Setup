# ====================================
# Linux Dev Setup - Docker Configuration
# ====================================
# Configuración adicional de Docker

# Docker compose v2 (si está disponible)
if command -v docker &> /dev/null; then
    if docker compose version &> /dev/null; then
        alias dc='docker compose'
    fi
fi

# Docker logs mejorado
alias dlogs='docker logs -f --tail 100'

# Docker stats mejorado
alias dstats='docker stats --no-stream'

# Docker inspect mejorado
alias dinsp='docker inspect'

# Docker network mejorado
alias dnetls='docker network ls'
alias dnetrm='docker network rm'
