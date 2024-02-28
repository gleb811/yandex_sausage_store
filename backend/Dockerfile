FROM maven:3.9.3-eclipse-temurin-20-alpine as builder
ARG VERSION=${VERSION}
WORKDIR /usr/src/app
COPY ./src ./src
COPY *.xml ./
RUN wget -O  YandexInternalRootCA.crt https://storage.yandexcloud.net/cloud-certs/CA.pem \
    && mvn package -Dversion.application=${VERSION} -Dmaven.test.skip=true -Dspring.flyway.enabled=false

# шаг релиза
#FROM bellsoft/liberica-runtime-container:jre-17-slim-musl
FROM eclipse-temurin:17.0.4.1_1-jre-alpine
ARG VERSION=${VERSION}
WORKDIR /app
COPY --from=builder /usr/src/app/YandexInternalRootCA.crt .
RUN keytool -importcert -file YandexInternalRootCA.crt \
    -alias yandex -cacerts -storepass changeit -noprompt \
    && addgroup --system jaruser \
    && adduser -S -s /bin/false -G jaruser jaruser -D -H \
    && mkdir -p /app/report \
    && mkdir -p /app/log \
    && chown -R jaruser:jaruser /app \
    && mkdir -p /home/jaruser/.postgresql \
    && cp YandexInternalRootCA.crt /home/jaruser/.postgresql/root.crt \
    && chown -R jaruser:jaruser /home/jaruser/.postgresql \
    && chmod 0600 /home/jaruser/.postgresql/root.crt \
    && rm -rf YandexInternalRootCA.crt 
    
COPY --chown=jaruser:jaruser \
     --from=builder /usr/src/app/target/sausage-store-${VERSION}.jar ./sausage-store.jar
EXPOSE 8080
USER jaruser
ENTRYPOINT ["java", "-jar", "-Dmyserver.bindPort=8080", "/app/sausage-store.jar"]
