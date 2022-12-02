# dockerized-youtrack-arm64
Docker files to run YouTrack (`.jar` version) on an ARM64 server.

## Installation
  
You need to download the YouTrack `.jar` file from the JetBrains website and change VAR `YOUTRACK_JAR_FILE` in the `Dockerfile` to match the version of the `.jar` file you got.  
  
Remember to also put all of the files (`Dockerfile`, `docker-compose.yml` and the `.jar` file) in the same directory before following the instructions!
  
After that it's as simple as running the following commands in sequence: 

1- Run `docker compose build` to build the image

2- If build was successful run `mkdir backups/ data/ logs/` to create the needed directories

3- Then run `sudo chown -R 13001:13001 backups/ data/ logs/` to give working permissions to them

4- Then run `docker compose up` to fire up the containers

And when you're done setting up YouTrack (follow the instructions on JetBrains website if you need help with that) and is ready to run the container in dettached mode:

1- Press `CTRL+C` to stop container

2- Then run `docker compose up -d` to run the container dettached

And done!

## Updating - BACKUP YOUR DATA FIRST!

1- First you will need the updated `.jar` file from the JetBrains website and place it where your old `.jar` file is located.

2- Update the VAR `YOUTRACK_JAR_FILE` in the `Dockerfile` to match the version of the new `.jar` file.

3- Run `docker compose build` to build the new image

4- If build was successful run `docker compose down` to stop the old container

5- Then run `docker compose up` to start the container with the new version that you just built

5- If YouTrack launched and you configured it without issues (refer to the JetBrains website if you need help, but PLEASE remember you need to go through the wizard again, use the URL provided in the terminal), then press `CTRL+C` to stop container

6- Run `docker compose up -d` to run detached

7- Delete the old `.jar` file

And done!
  
--------
If you want to cleanup your Docker environment you can run the following command, but **KEEP IN MIND THAT IT CAN BE DESTRUCTIVE**! It'll delete all containers, volumes, networks, images and build caches that aren't being used by at least one container. If you have a container stopped that you will run later, do not run this. Only run this **when all containers are UP and RUNNING**.
  
`docker system prune --volumes --all`
