FROM quay.io/astronomer/astro-runtime:13.2.0

RUN python -m venv dbt_dag_venv && source dbt_dag_venv/bin/activate && \
    pip install --no-cache-dir dbt-redshift && deactivate
