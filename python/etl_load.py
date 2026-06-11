import os
import pandas as pd

from dotenv import load_dotenv
from sqlalchemy import create_engine, text

# ==========================================
# LOAD ENVIRONMENT VARIABLES
# ==========================================

load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

# ==========================================
# DATABASE CONNECTION
# ==========================================

connection_string = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(connection_string)

# ==========================================
# CLEAR TABLES
# ==========================================

print("Clearing existing data...")

with engine.begin() as conn:
    conn.execute(text("DELETE FROM transactions"))
    conn.execute(text("DELETE FROM sales"))
    conn.execute(text("DELETE FROM holidays_events"))
    conn.execute(text("DELETE FROM stores"))

print("Tables cleared.")

# ==========================================
# LOAD STORES
# ==========================================

print("Loading stores...")

stores = pd.read_csv("data/raw/stores.csv")

stores.to_sql(
    name="stores",
    con=engine,
    if_exists="append",
    index=False
)

print(f"Loaded {len(stores):,} store records.")

# ==========================================
# LOAD HOLIDAYS
# ==========================================

print("Loading holidays...")

holidays = pd.read_csv("data/raw/holidays_events.csv")

holidays["date"] = pd.to_datetime(holidays["date"])

holidays.to_sql(
    name="holidays_events",
    con=engine,
    if_exists="append",
    index=False
)

print(f"Loaded {len(holidays):,} holiday records.")

# ==========================================
# LOAD TRANSACTIONS
# ==========================================

print("Loading transactions...")

transactions = pd.read_csv("data/raw/transactions.csv")

transactions["date"] = pd.to_datetime(
    transactions["date"]
)

transactions.to_sql(
    name="transactions",
    con=engine,
    if_exists="append",
    index=False
)

print(f"Loaded {len(transactions):,} transaction records.")

# ==========================================
# LOAD SALES
# ==========================================

print("Loading sales...")

sales_chunks = pd.read_csv(
    "data/raw/train.csv",
    chunksize=50000
)

total_rows = 0

for chunk in sales_chunks:

    chunk["date"] = pd.to_datetime(
        chunk["date"]
    )

    chunk = chunk.drop(columns=["id"])

    chunk.to_sql(
        name="sales",
        con=engine,
        if_exists="append",
        index=False,
        method="multi"
    )

    total_rows += len(chunk)

    print(f"Loaded {total_rows:,} sales records...")

print(f"Loaded {total_rows:,} sales records.")

# ==========================================
# FINISH
# ==========================================

print("ETL completed successfully.")