### Learning to use Docker 
1. To run docker with the python:3.12.8 image in an interactive mode, and use the entrypoint bash, we can use below command
    
        docker run -it python:3.12.8 bash

    This downloads python:3.12.8 image [ if not available locally, creates a container using it and makes the container available to exuecute commands in interactive mode as we specified -it option ]

    The container is based on GNU Linux, so we can run any Linux commands at the bash prompt

        Get Details of Linux OS 
            cat /etc/os-release
        
        To findout the version of pip package manager
            pip --version
        
        To identify list of packages installed
            `pip list`

2.  Refer the services defined in docker-compose.yaml, pgadmin can access the pg db using hostname port combo of db:5432

3. To find out count trips that took place between October 1st 2019 (inclusive) and November 1st 2019 (exclusive) for various miles we can use below SQL script

        SELECT
            SUM(CASE WHEN trip_distance <= 1 THEN 1 ELSE 0 END) AS up_to_1_mile,
            SUM(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 ELSE 0 END) AS between_1_and_3_miles,
            SUM(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 ELSE 0 END) AS between_4_and_5_miles,
            SUM(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 ELSE 0 END) AS between_4_and_5_miles,
            SUM(CASE WHEN trip_distance > 10 THEN 1 ELSE 0 END) AS between_4_and_5_miles
        FROM green_trip_data
            WHERE lpep_pickup_datetime >= '2019-10-01'
            AND lpep_dropoff_datetime < '2019-11-01';


4. To find out trip pick up date time for the trip that has longest trip distance we can use below query

        SELECT
            LPEP_PICKUP_DATETIME
        FROM
            GREEN_TRIP_DATA
        WHERE
            TRIP_DISTANCE >= (
                SELECT
                    MAX(TRIP_DISTANCE)
                FROM
                    GREEN_TRIP_DATA
            );


5. Which were the top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?. Below query will give pickup locations required for the above question.

        SELECT
            SUM(TRIP_DATA.TOTAL_AMOUNT) TOTAL_AMOUNT,
            TRIP_DATA."PULocationID" LOCATIONID,
            ZONES."Zone" ZONE_NAME
        FROM
            GREEN_TRIP_DATA AS TRIP_DATA,
            ZONE_DATA ZONES
        WHERE
            CAST(TRIP_DATA.LPEP_PICKUP_DATETIME AS DATE) = '2019-10-18'
            AND TRIP_DATA."PULocationID" = ZONES."LocationID"
        GROUP BY
            TRIP_DATA."PULocationID",
            ZONES."Zone"
        HAVING
            SUM(TOTAL_AMOUNT) >= 13000
        ORDER BY
            TOTAL_AMOUNT DESC;

6. SQL to identify max tip amount for the question "For the passengers picked up in October 2019 in the zone name "East Harlem North" which was the drop off zone that had the largest tip?" 

       SELECT
            MAX(TRIP_DATA.TIP_AMOUNT) MAX_TIP,
            ZONES."Zone"
        FROM
            GREEN_TRIP_DATA AS TRIP_DATA,
            ZONE_DATA AS ZONES,
            ZONE_DATA AS PUZONE
        WHERE
            TRIP_DATA."DOLocationID" = ZONES."LocationID"
            AND PUZONE."LocationID" = TRIP_DATA."PULocationID"
            AND PUZONE."Zone" = 'East Harlem North'
            AND EXTRACT(
                MONTH
                FROM
                    TRIP_DATA.LPEP_PICKUP_DATETIME
            ) = 10
            AND EXTRACT(
                YEAR
                FROM
                    TRIP_DATA.LPEP_PICKUP_DATETIME
            ) = 2019
        GROUP BY
            ZONES."Zone"
        ORDER BY
            MAX_TIP DESC
        LIMIT
            1;