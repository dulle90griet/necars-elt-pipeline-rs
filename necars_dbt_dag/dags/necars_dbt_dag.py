import os
from datetime import datetime

from cosmos import DbtDag, ProfileConfig, ProjectConfig, ExecutionConfig
from cosmos.profiles import RedshiftUserPasswordProfileMapping

profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=RedshiftUserPasswordProfileMapping(
        conn_id="redshift_conn",   # configured in the Airflow Admin interface
        profile_args={"dbname": "necars_db", "schema": "dbt_schema"},
    )
)

dbt_snowflake_dag = DbtDag(
    project_config=ProjectConfig("/usr/local/airflow/dags/dbt/necars_dbt_rs"),
    operator_args={"install_deps": True},
    profile_config=profile_config,
    execution_config=ExecutionConfig(dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_dag_venv/bin/dbt"),
    schedule_interval="@daily",
    start_date=datetime(2025, 5, 15),
    catchup=False,
    dag_id="necars_dbt_dag"
)