# 🐘 Guía de Uso de PostgreSQL

Guía completa y resumida para usar PostgreSQL en el día a día.

## 📋 Tabla de Contenidos

- [Gestión del Servicio PostgreSQL](#gestión-del-servicio-postgresql)
- [Verificación del Servicio](#verificación-del-servicio)
- [Conexión a PostgreSQL](#conexión-a-postgresql)
- [Comandos Básicos](#comandos-básicos)
- [Gestión de Bases de Datos](#gestión-de-bases-de-datos)
- [Gestión de Tablas](#gestión-de-tablas)
- [Operaciones CRUD](#operaciones-crud)
- [Consultas Avanzadas](#consultas-avanzadas)
- [Funciones y Agregaciones](#funciones-y-agregaciones)
- [Índices y Rendimiento](#índices-y-rendimiento)
- [Backup y Restore](#backup-y-restore)
- [Logs y Monitoreo](#logs-y-monitoreo)
- [Comandos Avanzados de psql](#comandos-avanzados-de-psql)
- [Alias Útiles](#alias-útiles)

---

## Gestión del Servicio PostgreSQL

### Iniciar el servicio

```bash
sudo systemctl start postgresql
```

### Detener el servicio

```bash
sudo systemctl stop postgresql
```

### Reiniciar el servicio

```bash
sudo systemctl restart postgresql
```

### Recargar configuración sin reiniciar

```bash
sudo systemctl reload postgresql
```

### Habilitar al inicio del sistema

```bash
sudo systemctl enable postgresql
```

### Deshabilitar al inicio del sistema

```bash
sudo systemctl disable postgresql
```

### Ver estado del servicio

```bash
sudo systemctl status postgresql
```

### Ver si el servicio está activo

```bash
sudo systemctl is-active postgresql
```

### Ver si el servicio está habilitado

```bash
sudo systemctl is-enabled postgresql
```

---

## Verificación del Servicio

### Verificar si PostgreSQL acepta conexiones

```bash
pg_isready
```

Salida esperada:
```
/var/run/postgresql:5432 - accepting connections
```

### Verificar puerto en uso

```bash
sudo ss -tulpn | grep 5432
```

Salida esperada:
```
tcp   LISTEN 0   128   0.0.0.0:5432   0.0.0.0:*
```

### Ver proceso de PostgreSQL

```bash
ps aux | grep postgres
```

### Ver directorio de datos

```bash
sudo -u postgres psql -c 'SHOW data_directory;'
```

### Ver versión de PostgreSQL

```bash
psql --version
```

### Ver versión desde psql

```bash
sudo -u postgres psql -c "SELECT version();"
```

### Ver configuración actual

```bash
sudo -u postgres psql -c "SHOW ALL;"
```

### Ver archivo de configuración

```bash
sudo -u postgres psql -c "SHOW config_file;"
```

### Ver archivo de configuración de autenticación

```bash
sudo -u postgres psql -c "SHOW hba_file;"
```

---

## Conexión a PostgreSQL

### Conectar como superusuario

```bash
sudo -u postgres psql
```

### Conectar como usuario específico

```bash
psql -U usuario -d base_de_datos
```

### Conectar con contraseña

```bash
psql -U usuario -d base_de_datos -W
```

### Conectar a host remoto

```bash
psql -h localhost -p 5432 -U usuario -d base_de_datos
```

### Usando el alias configurado

```bash
psql-admin
```

---

## Comandos Básicos

### Comandos de psql (meta-comandos)

```sql
\h              # Ayuda de comandos SQL
\?              # Ayuda de comandos psql
\l              # Listar todas las bases de datos
\c nombre_db    # Conectar a una base de datos
\d              # Listar tablas
\d nombre_tabla # Describir tabla
\du             # Listar usuarios
\dn             # Listar esquemas
\q              # Salir de psql
\dt             # Listar tablas
\di             # Listar índices
```

### Ejecutar comandos desde terminal

```bash
psql -U usuario -d base_de_datos -c "SELECT * FROM tabla;"
```

### Ejecutar archivo SQL

```bash
psql -U usuario -d base_de_datos -f archivo.sql
```

---

## Gestión de Bases de Datos

### Crear base de datos

```sql
CREATE DATABASE mi_base_de_datos;
```

### Crear base de datos con propietario

```sql
CREATE DATABASE mi_base_de_datos OWNER mi_usuario;
```

### Eliminar base de datos

```sql
DROP DATABASE mi_base_de_datos;
```

### Cambiar a una base de datos

```sql
\c mi_base_de_datos
```

### Ver información de la base de datos actual

```sql
SELECT current_database();
```

---

## Gestión de Tablas

### Crear tabla

```sql
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    edad INTEGER CHECK (edad >= 18),
    creado_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Ver estructura de tabla

```sql
\d usuarios
```

### Eliminar tabla

```sql
DROP TABLE usuarios;
```

### Eliminar tabla si existe

```sql
DROP TABLE IF EXISTS usuarios;
```

### Renombrar tabla

```sql
ALTER TABLE usuarios RENAME TO clientes;
```

### Añadir columna

```sql
ALTER TABLE usuarios ADD COLUMN telefono VARCHAR(20);
```

### Eliminar columna

```sql
ALTER TABLE usuarios DROP COLUMN telefono;
```

### Modificar tipo de columna

```sql
ALTER TABLE usuarios ALTER COLUMN edad TYPE INTEGER;
```

### Añadir restricción

```sql
ALTER TABLE usuarios ADD CONSTRAINT chk_edad CHECK (edad >= 18);
```

---

## Operaciones CRUD

### CREATE (Insertar)

```sql
INSERT INTO usuarios (nombre, email, edad)
VALUES ('Juan Pérez', 'juan@example.com', 25);
```

### Insertar múltiples filas

```sql
INSERT INTO usuarios (nombre, email, edad)
VALUES 
    ('Juan Pérez', 'juan@example.com', 25),
    ('María García', 'maria@example.com', 30),
    ('Carlos López', 'carlos@example.com', 28);
```

### READ (Seleccionar)

```sql
-- Seleccionar todo
SELECT * FROM usuarios;

-- Seleccionar columnas específicas
SELECT nombre, email FROM usuarios;

-- Con condición
SELECT * FROM usuarios WHERE edad > 25;

-- Con ordenamiento
SELECT * FROM usuarios ORDER BY nombre ASC;

-- Con límite
SELECT * FROM usuarios LIMIT 10;

-- Con offset
SELECT * FROM users LIMIT 10 OFFSET 5;
```

### UPDATE (Actualizar)

```sql
UPDATE usuarios
SET edad = 26
WHERE email = 'juan@example.com';
```

### DELETE (Eliminar)

```sql
DELETE FROM usuarios WHERE email = 'juan@example.com';
```

### Eliminar todos los registros

```sql
DELETE FROM usuarios;
```

### Truncar tabla (más rápido)

```sql
TRUNCATE TABLE usuarios;
```

---

## Consultas Avanzadas

### JOIN (Unir tablas)

```sql
-- INNER JOIN
SELECT u.nombre, p.titulo
FROM usuarios u
INNER JOIN posts p ON u.id = p.usuario_id;

-- LEFT JOIN
SELECT u.nombre, p.titulo
FROM usuarios u
LEFT JOIN posts p ON u.id = p.usuario_id;

-- RIGHT JOIN
SELECT u.nombre, p.titulo
FROM usuarios u
RIGHT JOIN posts p ON u.id = p.usuario_id;
```

### Subconsultas

```sql
SELECT nombre, edad
FROM usuarios
WHERE edad > (SELECT AVG(edad) FROM usuarios);
```

### GROUP BY

```sql
SELECT edad, COUNT(*)
FROM usuarios
GROUP BY edad;
```

### HAVING

```sql
SELECT edad, COUNT(*)
FROM usuarios
GROUP BY edad
HAVING COUNT(*) > 1;
```

### UNION

```sql
SELECT nombre FROM usuarios
UNION
SELECT nombre FROM administradores;
```

### CASE

```sql
SELECT nombre,
    CASE
        WHEN edad < 18 THEN 'Menor'
        WHEN edad BETWEEN 18 AND 65 THEN 'Adulto'
        ELSE 'Adulto mayor'
    END AS categoria
FROM usuarios;
```

---

## Funciones y Agregaciones

### Funciones de cadena

```sql
-- Longitud
SELECT LENGTH(nombre) FROM usuarios;

-- Mayúsculas/Minúsculas
SELECT UPPER(nombre), LOWER(email) FROM usuarios;

-- Concatenar
SELECT CONCAT(nombre, ' - ', email) FROM usuarios;

-- Reemplazar
SELECT REPLACE(email, '@', ' [at] ') FROM usuarios;

-- Substring
SELECT SUBSTRING(nombre FROM 1 FOR 3) FROM usuarios;
```

### Funciones de fecha

```sql
-- Fecha actual
SELECT CURRENT_DATE;
SELECT CURRENT_TIMESTAMP;

-- Extraer partes
SELECT EXTRACT(YEAR FROM creado_at) FROM usuarios;
SELECT EXTRACT(MONTH FROM creado_at) FROM usuarios;

-- Formatear
SELECT TO_CHAR(creado_at, 'DD/MM/YYYY') FROM usuarios;

-- Sumar/restar fechas
SELECT creado_at + INTERVAL '1 day' FROM usuarios;
```

### Funciones numéricas

```sql
-- Redondear
SELECT ROUND(edad) FROM usuarios;

-- Valor absoluto
SELECT ABS(edad) FROM usuarios;

-- Mínimo/Máximo
SELECT MIN(edad), MAX(edad) FROM usuarios;

-- Suma/Promedio
SELECT SUM(edad), AVG(edad) FROM usuarios;
```

### Funciones de agregación

```sql
-- Contar
SELECT COUNT(*) FROM usuarios;
SELECT COUNT(DISTINCT email) FROM usuarios;

-- Promedio
SELECT AVG(edad) FROM usuarios;

-- Suma
SELECT SUM(edad) FROM usuarios;

-- Mínimo/Máximo
SELECT MIN(edad), MAX(edad) FROM usuarios;
```

---

## Índices y Rendimiento

### Crear índice

```sql
CREATE INDEX idx_usuarios_email ON usuarios(email);
```

### Crear índice único

```sql
CREATE UNIQUE INDEX idx_usuarios_email ON usuarios(email);
```

### Crear índice compuesto

```sql
CREATE INDEX idx_usuarios_nombre_edad ON usuarios(nombre, edad);
```

### Ver índices de una tabla

```sql
\d usuarios
-- o
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'usuarios';
```

### Eliminar índice

```sql
DROP INDEX idx_usuarios_email;
```

### Analizar tabla para optimización

```sql
ANALYZE usuarios;
```

### Ver plan de ejecución

```sql
EXPLAIN SELECT * FROM usuarios WHERE email = 'juan@example.com';
```

### Ver plan de ejecución con ejecución

```sql
EXPLAIN ANALYZE SELECT * FROM usuarios WHERE email = 'juan@example.com';
```

---

## Backup y Restore

### Backup de una base de datos

```bash
pg_dump -U usuario nombre_db > backup.sql
```

### Backup de todas las bases de datos

```bash
pg_dumpall -U postgres > backup_completo.sql
```

### Backup solo esquema (sin datos)

```bash
pg_dump -U usuario --schema-only nombre_db > esquema.sql
```

### Backup solo datos (sin esquema)

```bash
pg_dump -U usuario --data-only nombre_db > datos.sql
```

### Restore de base de datos

```bash
psql -U usuario nombre_db < backup.sql
```

### Restore desde terminal psql

```sql
\i backup.sql
```

### Backup comprimido

```bash
pg_dump -U usuario nombre_db | gzip > backup.sql.gz
```

### Restore desde comprimido

```bash
gunzip -c backup.sql.gz | psql -U usuario nombre_db
```

---

## Gestión de Usuarios

### Crear usuario

```sql
CREATE USER mi_usuario WITH PASSWORD 'contraseña_segura';
```

### Crear superusuario

```sql
CREATE USER mi_usuario WITH PASSWORD 'contraseña' SUPERUSER;
```

### Otorgar privilegios

```sql
-- Conectar a base de datos
GRANT CONNECT ON DATABASE nombre_db TO mi_usuario;

-- Crear esquema
GRANT CREATE ON SCHEMA public TO mi_usuario;

-- CRUD en tablas
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO mi_usuario;

-- Todos los privilegios
GRANT ALL PRIVILEGES ON DATABASE nombre_db TO mi_usuario;
```

### Cambiar contraseña

```sql
ALTER USER mi_usuario WITH PASSWORD 'nueva_contraseña';
```

### Eliminar usuario

```sql
DROP USER mi_usuario;
```

### Ver usuarios

```sql
\du
-- o
SELECT usename FROM pg_user;
```

---

## Transacciones

### Iniciar transacción

```sql
BEGIN;
```

### Confirmar transacción

```sql
COMMIT;
```

### Revertir transacción

```sql
ROLLBACK;
```

### Ejemplo de transacción

```sql
BEGIN;
UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;
UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;
COMMIT;
```

---

## Vistas

### Crear vista

```sql
CREATE VIEW usuarios_activos AS
SELECT * FROM usuarios WHERE activo = true;
```

### Consultar vista

```sql
SELECT * FROM usuarios_activos;
```

### Eliminar vista

```sql
DROP VIEW usuarios_activos;
```

---

## Triggers

### Crear función para trigger

```sql
CREATE OR REPLACE FUNCTION actualizar_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.actualizado_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

### Crear trigger

```sql
CREATE TRIGGER trigger_actualizar
BEFORE UPDATE ON usuarios
FOR EACH ROW
EXECUTE FUNCTION actualizar_timestamp();
```

---

## Alias Útiles

El proyecto incluye alias en `configs/aliases/postgres.zsh` para facilitar la gestión de PostgreSQL:

```bash
psql-admin     # Entrar como usuario postgres
pg-status      # Estado del servicio (systemctl status postgresql)
pg-start       # Iniciar PostgreSQL (systemctl start postgresql)
pg-stop        # Detener PostgreSQL (systemctl stop postgresql)
pg-restart     # Reiniciar PostgreSQL (systemctl restart postgresql)
pg-ready       # Verificar si acepta conexiones (pg_isready)
pg-port        # Ver qué proceso está en el puerto 5432
pg-process     # Ver procesos de postgres (ps aux | grep postgres)
pg-data        # Ver directorio de datos
```

### Ejemplos de uso

```bash
# Verificar estado del servicio
pg-status

# Iniciar el servicio si está detenido
pg-start

# Reiniciar el servicio
pg-restart

# Verificar que está listo para aceptar conexiones
pg-ready

# Ver qué está usando el puerto 5432
pg-port

# Ver procesos de PostgreSQL
pg-process

# Ver directorio de datos
pg-data

# Entrar como administrador
psql-admin
```

### Equivalencias con comandos nativos

```bash
# Alias → Comando nativo
pg-status      → sudo systemctl status postgresql
pg-start       → sudo systemctl start postgresql
pg-stop        → sudo systemctl stop postgresql
pg-restart     → sudo systemctl restart postgresql
pg-ready       → pg_isready
pg-port        → sudo ss -tulpn | grep 5432
pg-process     → ps aux | grep postgres
pg-data        → sudo -u postgres psql -c 'SHOW data_directory;'
psql-admin     → sudo -u postgres psql
```

---

## Tips de Productividad

### Autocompletado en psql

Presiona `Tab` para autocompletar comandos y nombres de tablas.

### Historial de comandos

Usa las flechas `↑` y `↓` para navegar el historial.

### Editar comando actual

Presiona `Ctrl + E` para ir al final, `Ctrl + A` para ir al inicio.

### Cancelar comando

Presiona `Ctrl + C` para cancelar un comando en ejecución.

### Salvar salida a archivo

```sql
\o salida.txt
SELECT * FROM usuarios;
\o
```

### Cambiar formato de salida

```sql
\x              # Toggle formato expandido
\a              # Toggle alineación
\pset border 2  # Estilo de borde
```

---

## Logs y Monitoreo

### Ubicación de logs

Los logs de PostgreSQL se encuentran en:

```bash
/var/log/postgresql/
```

### Ver logs en tiempo real

```bash
sudo tail -f /var/log/postgresql/postgresql-14-main.log
```

### Ver últimas líneas de logs

```bash
sudo tail -n 50 /var/log/postgresql/postgresql-14-main.log
```

### Ver logs con errores

```bash
sudo grep ERROR /var/log/postgresql/postgresql-14-main.log
```

### Ver logs con warnings

```bash
sudo grep WARNING /var/log/postgresql/postgresql-14-main.log
```

### Configurar nivel de log

Edita `postgresql.conf`:

```bash
sudo nano /etc/postgresql/14/main/postgresql.conf
```

Busca y modifica:

```bash
log_min_messages = warning  # debug5, debug4, debug3, debug2, debug1, info, notice, warning, error
log_statement = all         # none, ddl, mod, all
```

### Ver conexiones activas

```sql
SELECT * FROM pg_stat_activity;
```

### Ver conexiones por usuario

```sql
SELECT usename, COUNT(*) FROM pg_stat_activity GROUP BY usename;
```

### Ver consultas largas en ejecución

```sql
SELECT pid, now() - query_start AS duration, query 
FROM pg_stat_activity 
WHERE state = 'active' 
ORDER BY duration DESC;
```

### Terminar una conexión

```sql
SELECT pg_terminate_backend(pid);
```

### Terminar todas las conexiones excepto la actual

```sql
SELECT pg_terminate_backend(pid) 
FROM pg_stat_activity 
WHERE pid <> pg_backend_pid();
```

### Ver tamaño de bases de datos

```sql
SELECT pg_database.datname, 
       pg_size_pretty(pg_database_size(pg_database.datname)) 
FROM pg_database;
```

### Ver tamaño de tablas

```sql
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

### Ver estadísticas de rendimiento

```sql
SELECT * FROM pg_stat_database;
```

### Ver locks activos

```sql
SELECT * FROM pg_locks;
```

### Ver locks que bloquean

```sql
SELECT 
    blocked_locks.pid AS blocked_pid,
    blocked_activity.usename AS blocked_user,
    blocking_locks.pid AS blocking_pid,
    blocking_activity.usename AS blocking_user,
    blocked_activity.query AS blocked_statement,
    blocking_activity.query AS current_statement_in_blocking_process
FROM pg_catalog.pg_locks blocked_locks
    JOIN pg_catalog.pg_stat_activity blocked_activity ON blocked_activity.pid = blocked_locks.pid
    JOIN pg_catalog.pg_locks blocking_locks 
        ON blocking_locks.locktype = blocked_locks.locktype
        AND blocking_locks.DATABASE IS NOT DISTINCT FROM blocked_locks.DATABASE
        AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
        AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page
        AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple
        AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid
        AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid
        AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid
        AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid
        AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid
        AND blocking_locks.pid != blocked_locks.pid
    JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
WHERE NOT blocked_locks.GRANTED;
```

---

## Comandos Avanzados de psql

### Ver historial de comandos

```sql
\s
```

### Guardar historial en archivo

```sql
\s historial_comandos.txt
```

### Ejecutar comando del historial

```bash
!n  # Donde n es el número del comando
```

### Editar último comando en editor

```sql
\e
```

### Cambiar editor por defecto

```bash
export EDITOR=nano
```

### Ver tipos de datos

```sql
\dT
```

### Ver funciones

```sql
\df
```

### Ver funciones con patrón

```sql
\df *nombre*
```

### Ver código de función

```sql
\df+ nombre_funcion
```

### Ver vistas

```sql
\dv
```

### Ver secuencias

```sql
\ds
```

### Ver roles (usuarios)

```sql
\dg
```

### Ver permisos de tabla

```sql
\dp nombre_tabla
```

### Ver todos los permisos

```sql
\dp
```

### Ver esquemas

```sql
\dn
```

### Ver esquemas con detalles

```sql
\dn+
```

### Ver tipos de datos personalizados

```sql
\dT+
```

### Ver operadores

```sql
\do
```

### Ver reglas

```sql
\dR
```

### Ver triggers

```sql
\dS
```

### Ver triggers de tabla específica

```sql
\dT nombre_tabla
```

### Ver configuración de psql

```sql
\set
```

### Cambiar formato de salida

```sql
\x              # Toggle formato expandido
\a              # Toggle alineación
\pset border 2  # Estilo de borde (0, 1, 2)
\pset format wrapped  # Formato envuelto
```

### Cambiar separador de campos

```sql
\pset fieldsep ','
```

### Cambir null a texto

```sql
\pset null 'NULL'
```

### Ver tiempo de ejecución

```sql
\timing on
```

### Guardar resultados en archivo

```sql
\o resultados.txt
SELECT * FROM usuarios;
\o
```

### Guardar resultados en CSV

```sql
\o resultados.csv
\pset format csv
SELECT * FROM usuarios;
\o
```

### Ejecutar comando del sistema desde psql

```sql
\! ls -la
```

### Ver variables de entorno

```sql
\setenv
```

### Establecer variable

```sql
\set mi_variable 'valor'
```

### Usar variable

```sql
SELECT :'mi_variable';
```

### Ver tabla con formato HTML

```sql
\H
SELECT * FROM usuarios;
```

### Ver tabla con formato LaTeX

```sql
\T
SELECT * FROM usuarios;
```

### Ver información del servidor

```sql
\conninfo
```

### Codificar/decodificar

```sql
\encoding UTF8
```

### Ver encoding actual

```sql
\encoding
```

### Ver tamaño de consulta

```sql
SELECT pg_size_pretty(pg_total_relation_size('nombre_tabla'));
```

### Ver plan de ejecución

```sql
EXPLAIN SELECT * FROM usuarios WHERE id = 1;
```

### Ver plan de ejecución con análisis

```sql
EXPLAIN ANALYZE SELECT * FROM usuarios WHERE id = 1;
```

### Ver plan de ejecución con buffers

```sql
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM usuarios WHERE id = 1;
```

### Ver plan de ejecución detallado

```sql
EXPLAIN (ANALYZE, BUFFERS, VERBOSE) SELECT * FROM usuarios WHERE id = 1;
```

### Ver estadísticas de tabla

```sql
SELECT * FROM pg_stats WHERE tablename = 'usuarios';
```

### Analizar tabla para actualizar estadísticas

```sql
ANALYZE usuarios;
```

### Vaciar tabla (TRUNCATE)

```sql
TRUNCATE TABLE usuarios;
```

### Vaciar tabla con reinicio de secuencia

```sql
TRUNCATE TABLE usuarios RESTART IDENTITY CASCADE;
```

### Clonar tabla

```sql
CREATE TABLE usuarios_backup AS SELECT * FROM usuarios;
```

### Clonar estructura sin datos

```sql
CREATE TABLE usuarios_vacia (LIKE usuarios INCLUDING ALL);
```

### Renombrar columna

```sql
ALTER TABLE usuarios RENAME COLUMN nombre TO nombre_completo;
```

### Añadir constraint UNIQUE

```sql
ALTER TABLE usuarios ADD CONSTRAINT unique_email UNIQUE (email);
```

### Eliminar constraint

```sql
ALTER TABLE usuarios DROP CONSTRAINT unique_email;
```

### Añadir constraint CHECK

```sql
ALTER TABLE usuarios ADD CONSTRAINT check_edad CHECK (edad >= 18);
```

### Añadir constraint FOREIGN KEY

```sql
ALTER TABLE pedidos ADD CONSTRAINT fk_usuario 
FOREIGN KEY (usuario_id) REFERENCES usuarios(id);
```

### Ver constraints de tabla

```sql
SELECT * FROM information_schema.table_constraints 
WHERE table_name = 'usuarios';
```

### Ver índices de tabla

```sql
SELECT indexname, indexdef FROM pg_indexes 
WHERE tablename = 'usuarios';
```

### Recrear índice

```sql
REINDEX INDEX idx_usuarios_email;
```

### Recrear todos los índices de tabla

```sql
REINDEX TABLE usuarios;
```

### Recrear todos los índices de base de datos

```sql
REINDEX DATABASE mi_base_de_datos;
```

### Ver particiones de tabla

```sql
SELECT * FROM pg_partitioned_table;
```

### Crear partición

```sql
CREATE TABLE usuarios_2024 PARTITION OF usuarios 
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
```

### Ver extensiones instaladas

```sql
SELECT * FROM pg_extension;
```

### Instalar extensión

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

### Eliminar extensión

```sql
DROP EXTENSION "uuid-ossp";
```

### Ver funciones de extensión

```sql
SELECT * FROM pg_available_extensions;
```

### Crear tabla con UUID

```sql
CREATE TABLE usuarios (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    nombre VARCHAR(100)
);
```

---

## 📝 Notas

- PostgreSQL es case-insensitive para identificadores no citados
- Usa comillas dobles para identificadores con mayúsculas/minúsculas
- Usa comillas simples para strings
- Siempre usa transacciones para operaciones críticas
- Los índices mejoran el rendimiento de consultas SELECT
- Los índices ralentizan INSERT/UPDATE/DELETE

---

**Volver al [Índice](../index.md)**
