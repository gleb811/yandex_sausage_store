FROM python:3.13.0a4-alpine3.19
WORKDIR /app
COPY . .
RUN mkdir /root/.postgresql && wget -O /root/.postgresql/root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem && pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8080