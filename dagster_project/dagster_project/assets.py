from dagster import AssetExecutionContext
from dagster_dbt import DbtCliResource, dbt_assets

from .project import peliculas_100k_project_project


@dbt_assets(manifest=peliculas_100k_project_project.manifest_path)
def peliculas_100k_project_dbt_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()
    

