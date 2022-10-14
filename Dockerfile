FROM arm64v8/amazoncorretto:11

HEALTHCHECK --start-period=1m \
            CMD wget --server-response --output-document=/dev/null http://localhost:8080 || exit 1

CMD ["bash"]

RUN yum -y update && yum -y install shadow-utils font-config && yum clean all && rm -rf /var/cache/yum

WORKDIR /

RUN groupadd -r -g 13001 jetbrains && useradd -r -g jetbrains -u 13001 jetbrains

RUN mkdir -m 0750 /opt/youtrack

COPY ./youtrack-*.jar /opt/youtrack

RUN mkdir -m 0750 /opt/youtrack/.youtrack /opt/youtrack/.youtrack/logs /opt/youtrack/teamsysdata /opt/youtrack/teamsysdata/conf /opt/youtrack/.youtrack/backups /opt/youtrack/.youtrack/temp /not-mapped-to-volume-dir && chown -R jetbrains:jetbrains /opt/youtrack/.youtrack/logs /opt/youtrack/teamsysdata /opt/youtrack/.youtrack/backups /opt/youtrack/.youtrack/temp /not-mapped-to-volume-dir /opt/youtrack/teamsysdata/conf && chown jetbrains:jetbrains /opt/youtrack && mkdir /home/jetbrains && chown jetbrains:jetbrains /home/jetbrains

RUN chown -R jetbrains:jetbrains /opt/youtrack

EXPOSE 8080

USER jetbrains

VOLUME ["/opt/youtrack/teamsysdata/conf", "/opt/youtrack/.youtrack/logs", "/opt/youtrack/.youtrack/backups", "/opt/youtrack/teamsysdata/"]

CMD ["java", "-Djava.awt.headless=true", "-Djetbrains.youtrack.disableBrowser=true", "-jar", "/opt/youtrack/youtrack-2022.2.57431.jar", "8080"]
