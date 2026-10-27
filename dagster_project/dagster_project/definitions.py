from dagster import (
    AssetKey,
    AssetSelection,
    Definitions,
    ScheduleDefinition,
    define_asset_job,
)
from dagster_dbt import DbtCliResource

from .assets import peliculas_100k_project_dbt_assets, source_movies, source_ratings
from .project import peliculas_100k_project

# ==============================================================================
# JOB 1: Pipeline de Calificaciones (Ratings) - Frecuencia Diaria
# ==============================================================================
ratings_pipeline_job = define_asset_job(
    name="ratings_pipeline_job",
    description="Orquesta la ingesta cruda, enriquecimiento intermedio y carga final de calificaciones",
    selection=AssetSelection.keys(
        AssetKey(["staging", "stg_ratings"]),
        AssetKey(["intermediate", "int_ratings_enriched"]),
        AssetKey(["marts", "fct_ratings"]),
    ),
)

ratings_daily_schedule = ScheduleDefinition(
    job=ratings_pipeline_job,
    cron_schedule="0 0 * * *",  # Todos los días a medianoche
    description="Ejecución diaria programada del pipeline de ratings",
)

# ==============================================================================
# JOB 2: Pipeline de Auditoría y Rendimiento del Catálogo - Frecuencia Semanal
# ==============================================================================
catalog_performance_job = define_asset_job(
    name="catalog_performance_job",
    description="Orquesta el saneamiento del catálogo, métricas agregadas y clasificación de desempeño comercial",
    selection=AssetSelection.keys(
        AssetKey(["staging", "stg_movies"]),
        AssetKey(["staging", "stg_genres"]),
        AssetKey(["staging", "stg_movie_genres"]),
        AssetKey(["intermediate", "int_movie_genres_expanded"]),
        AssetKey(["intermediate", "int_movie_ratings_metrics"]),
        AssetKey(["marts", "dim_movies"]),
        AssetKey(["marts", "mart_top_movies_performance"]),
    ),
)

catalog_weekly_schedule = ScheduleDefinition(
    job=catalog_performance_job,
    cron_schedule="0 2 * * 1",  # Todos los lunes a las 02:00 AM
    description="Actualización semanal de auditoría y categorización del catálogo",
)

# ==============================================================================
# DEFINITIONS CENTRALES
# ==============================================================================
defs = Definitions(
    assets=[source_ratings, source_movies, peliculas_100k_project_dbt_assets],
    jobs=[ratings_pipeline_job, catalog_performance_job],
    schedules=[ratings_daily_schedule, catalog_weekly_schedule],
    resources={
        "dbt": DbtCliResource(project_dir=peliculas_100k_project),
    },
)
