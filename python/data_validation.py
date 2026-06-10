import pandas as pd

sales = pd.read_csv("data/raw/train.csv")

print("Unique stores:")
print(sales["store_nbr"].nunique())

print("\nUnique product families:")
print(sales["family"].nunique())

print("\nDate range:")
print(sales["date"].min())
print(sales["date"].max())