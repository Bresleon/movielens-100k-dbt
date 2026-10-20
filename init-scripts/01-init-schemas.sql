-- Crear esquema para la ingesta en bruto (Airbyte)
CREATE SCHEMA IF NOT EXISTS source;

-- Crear esquema para las transformaciones analíticas (dbt)
CREATE SCHEMA IF NOT EXISTS marts;

-- Crear usuario exclusivo para Airbyte con permisos sobre su esquema
CREATE USER airbyte_user WITH PASSWORD 'airbyte_pass';
GRANT ALL PRIVILEGES ON DATABASE peliculas_100k_db TO airbyte_user;
GRANT ALL ON SCHEMA source TO airbyte_user;
GRANT USAGE, CREATE ON SCHEMA source TO airbyte_user;
