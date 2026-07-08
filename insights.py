import pandas as pd
import duckdb

uber_data = pd.read_excel(
    'Uber%20Request%20Raw%20Data.csv.xlsx',
    engine='openpyxl'
)

duckdb.register('uber_data', uber_data)

queries = [

"""
SELECT
COUNT(*) AS Total_Requests,
COUNT(*) FILTER (WHERE Status='Trip Completed') AS Completed_Trips
FROM uber_data
""",

"""
SELECT
Status,
COUNT(*) AS Total_Count
FROM uber_data
GROUP BY Status
ORDER BY Total_Count DESC
""",

"""
SELECT
"Pickup point",
COUNT(*) AS Total_Requests
FROM uber_data
GROUP BY "Pickup point"
"""
]

for i, query in enumerate(queries, start=1):
    print(f"\n========== QUERY {i} ==========")
    print(duckdb.query(query).to_df())