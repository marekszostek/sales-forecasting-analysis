import pandas as pd

files = [
    "train.csv",
    "stores.csv",
    "transactions.csv",
    "holidays_events.csv"
]

for file in files:
    print(f"\n{'='*50}")
    print(file)

    df = pd.read_csv(f"data/raw/{file}")

    print("\nShape:")
    print(df.shape)

    print("\nColumns:")
    print(df.columns.tolist())

    print("\nMissing Values:")
    print(df.isnull().sum())
    print(df.dtypes)