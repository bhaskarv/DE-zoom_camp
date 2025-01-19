## Study notes
1. Create a docker manifest to create an image with Python version 3.12.8, ans specify bash as an entry point for the container.
    
    <code>
    FROM python:3.12.8

    RUN pip install pandas    
    ENTRYPOINT [ "bash" ]
    </code>
    
2. Save the above code in a file called python-base-version. 
3. Run docker build to create an image using this file
    <code>docker build -t base_python:v1 -f python-base-version . </code>

4. To create a container using the custom image created above, run the command  <code>        
    docker run --rm -it base_python:v1</code>

        --rm : remove container once it is exited
         -it : run the container in interactive mode

    This runs the cotnainer in interactive mode and opens a bash shell for us to interact with the container.


5. Docker command to run postgres:17-alpine is

       docker run -it  -e POSTGRES_USER="root" -e POSTGRES_PASSWORD="root" -e POSTGRES_DB="ny_taxi" -v D:\WORKSPACE\DEZoomCamp\2025\week1\ny_taxi_pg_data:/var/lib/postgresql/data -p 5432:5432 postgres:17-alpine

    Here full path to local folder<b>ny_taxi_pg_data</b> is given to mount PGDB volume 

6. Create docker network so that 2 distint containers can be made to talk to each other `docker network create pg-network`

    Run PG DB using newly created network 

    `docker run -it  -e POSTGRES_USER="root" -e POSTGRES_PASSWORD="root" -e POSTGRES_DB="ny_taxi" -v D:\WORKSPACE\DEZoomCamp\2025\week1\ny_taxi_pg_data:/var/lib/postgresql/data -p 5432:5432 --network=pg-network --name=pg_db postgres:17-alpine`


7. Run a container using pgadmin image and specify the network and name of the pg db to connect to 

    <code>docker run -it -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" -e PGADMIN_DEFAULT_PASSWORD="root" -p 8080:80 --network=pg-network dpage/pgadmin5</code>

8. Docker compose can be used to group both the container under same network. With this there is no need to create any network, docker automatically takes care of it. Refere docker-compose.yaml file for details. 

9. Load data using `ingest-data.py` script

       python ingest-data.py --user postgres --password postgres --host localhost --port 5433 --db ny_taxi --table_name green_trip_data --url http://172.20.240.1:8000/green_tripdata_2019-10.csv.gz

I have added another parameter --file_name to work around with wget on windows.