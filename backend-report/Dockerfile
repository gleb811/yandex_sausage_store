FROM python:slim-bullseye
WORKDIR /app
COPY . .
RUN mkdir /root/.postgresql && wget -O /root/.postgresql/root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem && pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8080