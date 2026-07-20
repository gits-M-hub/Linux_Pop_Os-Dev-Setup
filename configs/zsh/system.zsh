# ====================================
# Linux Dev Setup - System Aliases
# ====================================
# Alias para comandos del sistema

# Actualización del sistema
alias update='sudo apt update && sudo apt upgrade -y'
alias upgrade='sudo apt full-upgrade -y'
alias clean='sudo apt autoremove -y && sudo apt autoclean'

# Gestión de paquetes
alias install='sudo apt install -y'
alias remove='sudo apt remove -y'
alias search='apt search'

# Gestión de servicios
alias sstatus='sudo systemctl status'
alias sstart='sudo systemctl start'
alias sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'

# Información del sistema
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='btop'

# Red
alias ping='ping -c 4'
alias ports='sudo ss -tulpn'

# Otros
alias cls='clear'
alias c='clear'
alias h='history'
