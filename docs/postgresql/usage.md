# 🐘 Guía de Uso de PostgreSQL

Guía completa y resumida para usar PostgreSQL en el día a día.

## 📋 Tabla de Contenidos

- [Conexión a PostgreSQL](#conexión-a-postgresql)
- [Comandos Básicos](#comandos-básicos)
- [Gestión de Bases de Datos](#gestión-de-bases-de-datos)
- [Gestión de Tablas](#gestión-de-tablas)
- [Operaciones CRUD](#operaciones-crud)
- [Consultas Avanzadas](#consultas-avanzadas)
- [Funciones y Agregaciones](#funciones-y-agregaciones)
- [Índices y Rendimiento](#índices-y-rendimiento)
- [Backup y Restore](#backup-y-restore)
- [Alias Útiles](#alias-útiles)

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

El proyecto incluye alias en `configs/aliases/postgres.zsh`:

```bash
psql-admin     # Entrar como usuario postgres
pg-status      # Estado del servicio
pg-start       # Iniciar PostgreSQL
pg-stop        # Detener PostgreSQL
pg-restart     # Reiniciar PostgreSQL
pg-ready       # Verificar si acepta conexiones
pg-port        # Ver qué proceso está en el puerto 5432
pg-process     # Ver procesos de postgres
pg-data        # Ver directorio de datos
```

### Ejemplos de uso

```bash
# Verificar estado
pg-status

# Reiniciar si es necesario
pg-restart

# Verificar que está listo
pg-ready

# Entrar como administrador
psql-admin
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

## 📝 Notas

- PostgreSQL es case-insensitive para identificadores no citados
- Usa comillas dobles para identificadores con mayúsculas/minúsculas
- Usa comillas simples para strings
- Siempre usa transacciones para operaciones críticas
- Los índices mejoran el rendimiento de consultas SELECT
- Los índices ralentizan INSERT/UPDATE/DELETE

---

**Volver al [Índice](../index.md)**
