FROM arm64v8/amazoncorretto:11

COPY ./youtrack-*.jar /root/

EXPOSE 8080

WORKDIR /root

VOLUME ["/root/teamsysdata", "/root/.youtrack/logs", "/root/.youtrack/backups"]

CMD ["java", "-Djava.awt.headless=true", "-Djetbrains.youtrack.disableBrowser=true", "-jar", "youtrack-2022.2.57431.jar", "8080"]
