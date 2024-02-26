FROM python:latest
WORKDIR /app
COPY . .
RUN wget -O  YandexInternalRootCA.crt https://storage.yandexcloud.net/cloud-certs/CA.pem && keytool -importcert -file YandexInternalRootCA.crt && -alias yandex -cacerts -storepass changeit -noprompt && pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8080