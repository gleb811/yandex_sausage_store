#FROM python:latest
FROM python:3.10-slim
WORKDIR /app
COPY . .
RUN mkdir /root/.postgresql && apt-get update -y && apt-get install wget -y && wget -O /root/.postgresql/root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem && pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8080