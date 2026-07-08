-- INSIGHT 1 & 2 & 3
SELECT
    COUNT(*) AS Total_Requests,
    COUNT(*) FILTER (WHERE Status = 'Trip Completed') AS Completed_Trips,
    COUNT(*) FILTER (WHERE Status != 'Trip Completed') AS Failed_Trips,
    ROUND(
        COUNT(*) FILTER (WHERE Status != 'Trip Completed') * 100.0 /
        COUNT(*), 2
    ) AS Failure_Percentage
FROM uber_data;

-- INSIGHT 4: Failure Modes
SELECT
    Status,
    COUNT(*) AS Total_Count
FROM uber_data
WHERE Status IN ('Cancelled', 'No Cars Available')
GROUP BY Status
ORDER BY Total_Count DESC;

-- INSIGHT 5: Pickup Point Demand
SELECT
    "Pickup point",
    COUNT(*) AS Total_Requests
FROM uber_data
GROUP BY "Pickup point"
ORDER BY Total_Requests DESC;

-- INSIGHT 6 & 7: Failure Rate by Pickup Point
SELECT
    "Pickup point",
    COUNT(*) AS Total_Requests,
    COUNT(*) FILTER (WHERE Status != 'Trip Completed') AS Failed_Requests,
    ROUND(
        COUNT(*) FILTER (WHERE Status != 'Trip Completed') * 100.0 /
        COUNT(*), 2
    ) AS Failure_Rate
FROM uber_data
GROUP BY "Pickup point";

-- INSIGHT 8: Requests by Hour
SELECT
    EXTRACT(HOUR FROM "Request timestamp") AS Hour,
    COUNT(*) AS Total_Requests
FROM uber_data
GROUP BY Hour
ORDER BY Total_Requests DESC;

-- INSIGHT 9: Airport Bottleneck
SELECT
    Status,
    COUNT(*) AS Total_Count
FROM uber_data
WHERE "Pickup point" = 'Airport'
GROUP BY Status
ORDER BY Total_Count DESC;

-- INSIGHT 10: City Bottleneck
SELECT
    Status,
    COUNT(*) AS Total_Count
FROM uber_data
WHERE "Pickup point" = 'City'
GROUP BY Status
ORDER BY Total_Count DESC;

-- Status Distribution
SELECT
    Status,
    COUNT(*) AS Total_Count
FROM uber_data
GROUP BY Status
ORDER BY Total_Count DESC;

-- Pickup Point vs Status
SELECT
    "Pickup point",
    Status,
    COUNT(*) AS Total_Count
FROM uber_data
GROUP BY "Pickup point", Status
ORDER BY "Pickup point", Total_Count DESC;