from datetime import datetime
from airflow import DAG

from docker.types import Mount

from airflow.operators.python_operator import PythonOperator
from airflow.providers.docker.operators.docker import DockerOperator

import subprocess

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
}

def run_load_data_script():
    script_path = "/opt/airflow/scripts/load_data.py"
    result = subprocess.run(["python", script_path], capture_output=True, text=True)
    if result.returncode != 0:
        raise Exception(f"Script failed with error: {result.stderr}")
    else:
        print(result.stdout)

dag = DAG(
    'rapido_elt',
    default_args=default_args,
    description='An ETL workflow with dbt',
    start_date=datetime(2025, 4, 11),
    catchup=False,
)

t1 = PythonOperator(
    task_id="run_load_data_script",
    python_callable=run_load_data_script,
    dag=dag
)

t2 = DockerOperator(
    task_id="dbt_run",
    image='ghcr.io/dbt-labs/dbt-postgres:1.9.latest',
    command=[
        "run",
        "--profiles-dir",
        "/root",
        "--project-dir",
        "/opt/dbt"
    ],
    auto_remove="success",
    docker_url="unix://var/run/docker.sock",
    network_mode="rapido-project_etl_network",
    mounts=[
        Mount(source='/home/sattu/python/rapido-project/dbt/ride_analytics',
              target='/opt/dbt', type='bind'),
        Mount(source='/home/sattu/.dbt',
              target='/root', type='bind'),
    ],
    dag=dag
)

t1 >> t2