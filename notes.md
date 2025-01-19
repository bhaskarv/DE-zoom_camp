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


