FROM lolhens/baseimage-openjre
ADD target/springbootApp.jar springbootApp.jar
EXPOSE 8085
CMD ["java", "-jar", "springbootApp.jar"]
