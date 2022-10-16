# dockerized-youtrack-arm64
Docker files to run YouTrack (.jar) on an ARM64 server.
  
You need to download the YouTrack `.jar` file from the JetBrains website and change VAR `YOUTRACK_JAR_FILE` in the `Dockerfile` to match the version of the file you got.  
Remember to also put all of the files (Dockerfile, docker-compose.yml and the .jar file) in the same directory before following the instructions!
  
After that it's as simple as: 

1- `docker compose build`

2- `mkdir backups/ data/ logs/`

3- `sudo chown -R 13001:13001 backups/ data/ logs/`

4- `docker compose up`

And when you're done setting up YouTrack (follow the instructions on JetBrains website if you need help with that) and is ready to run the container as daemon:

1- `CTRL+C` to stop container

2- `docker compose up -d`

And done!
