# ==========================
# PostgreSQL Aliases
# ==========================
# Prefijo 'pg-' para todos los comandos de PostgreSQL
# Abreviaciones mnemónicas: status, start, stop, restart, ready, port, process, data

# Entrar a PostgreSQL como administrador
# psql-admin = psql administrator (entra como usuario postgres)
alias psql-admin="sudo -u postgres psql"

# Estado del servicio
# pg-status = postgresql status (muestra si el servicio está corriendo)
alias pg-status="systemctl status postgresql"

# Reiniciar PostgreSQL
# pg-restart = postgresql restart (reinicia el servicio)
alias pg-restart="sudo systemctl restart postgresql"

# Iniciar PostgreSQL
# pg-start = postgresql start (inicia el servicio)
alias pg-start="sudo systemctl start postgresql"

# Detener PostgreSQL
# pg-stop = postgresql stop (detiene el servicio)
alias pg-stop="sudo systemctl stop postgresql"

# Verificar conexiones
# pg-ready = postgresql ready (verifica si PostgreSQL acepta conexiones)
alias pg-ready="pg_isready"

# Puerto PostgreSQL
# pg-port = postgresql port (muestra qué proceso está escuchando en el puerto 5432)
alias pg-port="sudo ss -tulpn | grep 5432"

# Ver procesos
# pg-process = postgresql process (muestra todos los procesos de postgres)
alias pg-process="ps aux | grep postgres"

# Directorio de datos
# pg-data = postgresql data directory (muestra dónde están los datos de PostgreSQL)
alias pg-data="sudo -u postgres psql -c 'SHOW data_directory;'"
