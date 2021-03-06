FROM dockerhub/library/gradle as builder
COPY ./app /app
WORKDIR /app
RUN ls && gradle build
FROM dockerhub/library/tomcat
RUN ["rm", "-rf", "/usr/local/tomcat/webapps/ROOT"]
COPY --from=builder /app/build/libs/*.jar /usr/local/tomcat/webapps/ROOT.jar
CMD ["java","-jar","/usr/local/tomcat/webapps/ROOT.jar"]
