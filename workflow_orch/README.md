## Queries to identify row count for the year 2020
 
    SELECT COUNT(1)
    FROM yellow_tripdata
    WHERE tpep_pickup_datetime >= '2020-01-01' AND          tpep_pickup_datetime < '2021-01-01'

Below query to fetch count from green_tripdata
    
    SELECT COUNT(1)
    FROM green_tripdata
    WHERE lpep_pickup_datetime >= '2020-01-01' AND lpep_pickup_datetime < '2021-01-01'

Below qquery is used to find count of records from yellow taxi data for March 2021

    SELECT COUNT(1)
    FROM yellow_tripdata
    WHERE tpep_pickup_datetime >= '2021-03-01' AND tpep_pickup_datetime < '2021-04-01'

**Note** : These qqueries were run post successful execution of backfill data for 2020 & 2021. Instead of running the queries we can also extract similar data from the output tab when flow is being executed. However querying the data makes it efficient. 


