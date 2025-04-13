import pandas as pd
from sqlalchemy import create_engine

df = pd.read_csv('/opt/airflow/data/rides_data.csv')
db_url = 'postgresql://postgres:password@rapido_db:5432/rides_db'
table_name = 'rides'

print("Loading data...")
try:
    engine = create_engine(db_url)
    df.to_sql(table_name, engine, schema='public', if_exists='replace', index=False)
    print("Data loaded successfully.")
except Exception as e:
    print("[ERROR] An error occured")
    print(e)
