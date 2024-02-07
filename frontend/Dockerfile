# build
FROM node:16.20.0-alpine3.18 as builder
ARG VERSION=${VERSION}
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build
RUN sed -i "s/{{VERSION}}/${VERSION}/g" dist/frontend/main.js

FROM nginx:stable-alpine3.17-slim
WORKDIR /app
COPY --from=builder /usr/src/app/dist/frontend ./frontend
EXPOSE 80 
