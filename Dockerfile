FROM tomcat:9.0

EXPOSE 8080
COPY ./target/javarush-project-3.war /usr/local/tomcat/webapps/