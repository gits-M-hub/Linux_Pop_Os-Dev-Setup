# ==========================
# Git Aliases
# ==========================
# Prefijo 'g' para todos los comandos de Git
# Abreviaciones mnemónicas: s = status, a = add, c = commit, p = push/pull, b = branch, co = checkout, l = log, d = diff

# Git básicos
# gs = git status (g + s = git status)
alias gs="git status"
# ga = git add (g + a = git add)
alias ga="git add"
# gaa = git add all (g + a + a = git add all - añade todos los archivos)
alias gaa="git add ."
# gc = git commit (g + c = git commit)
alias gc="git commit"
# gcm = git commit message (g + c + m = git commit message - commit con mensaje)
alias gcm="git commit -m"
# gp = git push (g + p = git push)
alias gp="git push"
# gpl = git pull (g + p + l = git pull - la 'l' distingue de push)
alias gpl="git pull"
# gb = git branch (g + b = git branch)
alias gb="git branch"
# gco = git checkout (g + co = git checkout - 'co' es abreviación común de checkout)
alias gco="git checkout"
# gl = git log (g + l = git log - muestra historial con formato gráfico)
alias gl="git log --oneline --graph --decorate"
# gd = git diff (g + d = git diff - muestra diferencias)
alias gd="git diff"
