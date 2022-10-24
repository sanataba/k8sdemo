FROM lolhens/baseimage-openjre
ADD **/*.jar springbootApp.jar
EXPOSE 8085
ENTRYPOINT ["java", "-jar", "springbootApp.jar"]
