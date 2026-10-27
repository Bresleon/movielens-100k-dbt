from dagster import (
    AssetKey,
    AssetSelection,
    Definitions,
    ScheduleDefinition,
    define_asset_job,
)
from dagster_dbt import DbtCliResource

from .assets import peliculas_100k_project_dbt_assets, source_ratings
from .project import peliculas_100k_project

# Job que orquesta stg_ratings, su vista intermedia y fct_ratings
ratings_pipeline_job = define_asset_job(
    name="ratings_pipeline_job",
    description="Orquesta la ingesta cruda y transformación de calificaciones",
    selection=AssetSelection.keys(
        AssetKey(["staging", "stg_ratings"]),
        AssetKey(["intermediate", "int_ratings_enriched"]),
        AssetKey(["marts", "fct_ratings"]),
    ),
)

ratings_daily_schedule = ScheduleDefinition(
    job=ratings_pipeline_job,
    cron_schedule="0 0 * * *",
    description="Ejecución diaria programada del pipeline de ratings",
)

defs = Definitions(
    assets=[source_ratings, peliculas_100k_project_dbt_assets],
    jobs=[ratings_pipeline_job],
    schedules=[ratings_daily_schedule],
    resources={
        "dbt": DbtCliResource(project_dir=peliculas_100k_project),
    },
)
