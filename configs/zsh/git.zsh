# ====================================
# Linux Dev Setup - Git Configuration
# ====================================
# Configuración adicional de Git

# Git aliases adicionales
alias gcl='git clone'
alias gclean='git clean -fd'
alias greset='git reset --hard'
alias gresetsoft='git reset --soft HEAD~1'
alias gstash='git stash'
alias gstashpop='git stash pop'
alias gstashlist='git stash list'

# Git log mejorado
alias glg='git log --graph --oneline --decorate --all'
alias glga='git log --graph --oneline --decorate --all --date=short --format="%C(auto)%h %ad %C(bold blue)%an %C(auto)%d %s"'

# Git branch mejorado
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'

# Git remote
alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'
alias grr='git remote remove'
