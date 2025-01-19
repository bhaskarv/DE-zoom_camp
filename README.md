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

