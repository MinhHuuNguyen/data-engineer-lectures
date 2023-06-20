import psycopg2
import pandas as pd

# Connect to PostgreSQL database
conn = psycopg2.connect(
    host="localhost",
    database="sample_db",
    user="postgres",
    password="docker"
)

# Define SQL query to select data
sql_query = """
    SELECT *
    FROM sample_schema.sample_table
"""

# Load data into Pandas DataFrame
df = pd.read_sql_query(sql_query, conn)
df.to_parquet()

# Close database connection
conn.close()

# Print first 5 rows of DataFrame
print(df.head())
print(df.info())