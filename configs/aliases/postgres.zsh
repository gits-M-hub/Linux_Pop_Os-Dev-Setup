# ==========================
# PostgreSQL
# ==========================

# Entrar a PostgreSQL como administrador
alias psql-admin="sudo -u postgres psql"

# Estado del servicio
alias pg-status="systemctl status postgresql"

# Reiniciar PostgreSQL
alias pg-restart="sudo systemctl restart postgresql"

# Iniciar PostgreSQL
alias pg-start="sudo systemctl start postgresql"

# Detener PostgreSQL
alias pg-stop="sudo systemctl stop postgresql"

# Verificar conexiones
alias pg-ready="pg_isready"

# Puerto PostgreSQL
alias pg-port="sudo ss -tulpn | grep 5432"

# Ver procesos
alias pg-process="ps aux | grep postgres"

# Directorio de datos
alias pg-data="sudo -u postgres psql -c 'SHOW data_directory;'"
