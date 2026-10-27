from dagster import AssetExecutionContext, AssetKey, SourceAsset
from dagster_dbt import DbtCliResource, dbt_assets

from .project import peliculas_100k_project

# 1. Definir formalmente la fuente cruda en Dagster
source_ratings = SourceAsset(
    key=AssetKey(["ml_source", "ratings"]),
    description="Tabla cruda source.ratings replicada en PostgreSQL",
)


# 2. Definir los activos de dbt apuntando a los modelos del proyecto
@dbt_assets(
    manifest=peliculas_100k_project.manifest_path,
)
def peliculas_100k_project_dbt_assets(
    context: AssetExecutionContext, dbt: DbtCliResource
):
    yield from dbt.cli(["build"], context=context).stream()
