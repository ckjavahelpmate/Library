# Use the official Tomcat image
FROM tomcat:9.0-jdk17

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file to ROOT
COPY target/my-webapp.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080
