CREATE OR REPLACE EXTERNAL TABLE
  `NY_TAXI.eternal_yellow_tripdate` OPTIONS ( format = 'PARQUET',
    uris = ['gs://my_ny_taxi_de_bucket/yellow_tripdata_2024*.parquet'] );


SELECT
  COUNT(1) TOTAL_RECORDS
FROM
  `NY_TAXI.eternal_yellow_tripdate`;


SELECT
  COUNT(DISTINCT PULocationID) LOCID_CNT
FROM
  `NY_TAXI.eternal_yellow_tripdate`;



CREATE OR REPLACE TABLE
  `NY_TAXI.yellow_tripdata` AS
SELECT
  *
FROM
  `NY_TAXI.eternal_yellow_tripdate`;


SELECT
  COUNT(1)
FROM
  `NY_TAXI.yellow_tripdata`;


SELECT
  COUNT(DISTINCT PULocationID) LOCID_CNT
FROM
  `NY_TAXI.yellow_tripdata`;

  
CREATE OR REPLACE TABLE `NY_TAXI.yellow_taxi_optimized`
PARTITION BY
  DATE(tpep_dropoff_datetime)
CLUSTER BY
  VendorID AS
SELECT
  *
FROM `NY_TAXI.yellow_tripdata`;


SELECT
  PULocationID LOCID
FROM
  `NY_TAXI.yellow_tripdata`;


SELECT
  PULocationID LOCID,
  DOLocationID
FROM
  `NY_TAXI.yellow_tripdata`;


SELECT
  COUNT(1)
FROM
  `NY_TAXI.yellow_tripdata`
WHERE
  fare_amount = 0;


SELECT
  DISTINCT VendorID
FROM
  `NY_TAXI.yellow_tripdata`
WHERE
  tpep_dropoff_datetime BETWEEN '2024-03-01'
  AND '2024-03-15';

SELECT
  DISTINCT VendorID
FROM
  `NY_TAXI.yellow_taxi_optimized`
WHERE
  tpep_dropoff_datetime BETWEEN '2024-03-01'
  AND '2024-03-15';



  