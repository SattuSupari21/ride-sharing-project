FROM apache/airflow:latest

RUN pip install apache-airflow-providers-docker

RUN pip install pandas

RUN pip install sqlalchemy