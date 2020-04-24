FROM java:8
VOLUME /tmp
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY ./target/park-with-you-backend-0.0.1-SNAPSHOT.jar /usr/share/parkwithyou/myservice.jar
RUN bash -c 'touch /usr/share/myservice/myservice.jar'
ENTRYPOINT java  -Xms512m   -Xmx1024m  -Xmn256m   -Xss256k   -XX:SurvivorRatio=8  -jar  /usr/share/parkwithyou/myservice.jar
EXPOSE 8088
