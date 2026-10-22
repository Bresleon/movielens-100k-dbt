from dagster import Definitions
from dagster_dbt import DbtCliResource
from .assets import peliculas_100k_project_dbt_assets
from .project import peliculas_100k_project_project
from .schedules import schedules

defs = Definitions(
    assets=[peliculas_100k_project_dbt_assets],
    schedules=schedules,
    resources={
        "dbt": DbtCliResource(project_dir=peliculas_100k_project_project),
    },
)

