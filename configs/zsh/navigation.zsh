# ====================================
# Linux Dev Setup - Navigation Aliases
# ====================================
# Alias para navegación en el sistema de archivos

# Navegación básica
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Listado mejorado
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -lath'  # Ordenado por tiempo (más reciente primero)
alias lx='ls -lXBh'  # Ordenado por extensión
alias lk='ls -lSrh'  # Ordenado por tamaño (más grande primero)

# Directorios
alias md='mkdir -p'
alias rd='rmdir'
alias d='dirs'

# Buscar archivos
alias f='find . -name'
alias ff='find . -type f -name'
alias fd='find . -type d -name'

# Cambiar a directorios comunes
alias home='cd ~'
alias root='cd /'
alias projects='cd ~/Projects'
alias downloads='cd ~/Downloads'
alias documents='cd ~/Documents'

# Historial de directorios
alias cdh='cd ~-'  # Volver al directorio anterior
