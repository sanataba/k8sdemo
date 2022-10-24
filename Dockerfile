FROM lolhens/baseimage-openjre
ADD **/*.jar springbootApp.war
EXPOSE 8085
ENTRYPOINT ["java", "-jar", "springbootApp.war"]
