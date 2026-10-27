from dagster import AssetExecutionContext, AssetKey, SourceAsset
from dagster_dbt import DbtCliResource, dbt_assets

from .project import peliculas_100k_project

# 1. Definición formal de las fuentes crudas
source_ratings = SourceAsset(
    key=AssetKey(["ml_source", "ratings"]),
    description="Tabla cruda source.ratings replicada en PostgreSQL",
)

source_movies = SourceAsset(
    key=AssetKey(["ml_source", "movies"]),
    description="Tabla cruda source.movies replicada en PostgreSQL",
)


# 2. Activos dbt
@dbt_assets(
    manifest=peliculas_100k_project.manifest_path,
)
def peliculas_100k_project_dbt_assets(
    context: AssetExecutionContext, dbt: DbtCliResource
):
    yield from dbt.cli(["build"], context=context).stream()
