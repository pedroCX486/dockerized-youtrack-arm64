# dockerized-youtrack-arm64
Docker files to run YouTrack (.jar) on an ARM64 server. This may not be the best/optimal settings but it works quite well.
  
You need to download the YouTrack `.jar` file from the JetBrains website and change the Dockerfile as needed for the version you got.
  
After that it's as simple as: 

`docker compose build`

then 

`docker compose up`

and when you're done and ready:

`docker compose up -d`
