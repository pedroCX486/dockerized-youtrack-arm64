FROM arm64v8/amazoncorretto:11

HEALTHCHECK --start-period=1m \
            CMD wget --server-response --output-document=/dev/null http://localhost:8080 || exit 1

CMD ["bash"]

RUN yum -y update && yum -y install shadow-utils font-config && yum clean all && rm -rf /var/cache/yum

WORKDIR /

RUN groupadd -r -g 13001 jetbrains && useradd -r -g jetbrains -u 13001 jetbrains

RUN mkdir -m 0750 /opt/youtrack

COPY ./youtrack-*.jar /opt/youtrack

RUN chown -R jetbrains:jetbrains /opt/youtrack

RUN mkdir -m 0750 /not-mapped-to-volume-dir && \
	chown jetbrains:jetbrains /not-mapped-to-volume-dir

RUN mkdir /home/jetbrains && \
	chown -R jetbrains:jetbrains /home/jetbrains

RUN mkdir /home/jetbrains/.youtrack && \
	mkdir /home/jetbrains/teamsysdata /home/jetbrains/teamsysdata/conf && \
	mkdir /home/jetbrains/.youtrack/logs /home/jetbrains/.youtrack/temp && \
	chown jetbrains:jetbrains /home/jetbrains/.youtrack && \
	chown -R jetbrains:jetbrains /home/jetbrains/teamsysdata /home/jetbrains/teamsysdata/conf && \
	chown -R jetbrains:jetbrains /home/jetbrains/.youtrack/logs /home/jetbrains/.youtrack/temp

EXPOSE 8080

USER jetbrains

VOLUME ["/home/jetbrains/.youtrack/logs", "/home/jetbrains/.youtrack/backups", "/home/jetbrains/teamsysdata"]

CMD ["java", "-Djava.awt.headless=true", "-Djetbrains.jar.use.system.java=true", "-Djetbrains.youtrack.disableBrowser=true", "-jar", "/opt/youtrack/youtrack-2022.2.57431.jar", "8080"]
