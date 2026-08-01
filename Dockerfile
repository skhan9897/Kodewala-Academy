# Use Tomcat 9 with JDK 17
FROM tomcat:9.0-jdk17-openjdk

# Remove default tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file from target folder to tomcat webapps
# Make sure to run 'mvn package' before building docker image
COPY target/KodewalaAcademy-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

CMD ["catalina.sh", "run"]
