# build
FROM node:16.20.0-alpine3.18 as builder
ARG VERSION=${VERSION}
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build
RUN sed -i "s/{{VERSION}}/${VERSION}/g" dist/frontend/main.js

#release
FROM nginxproxy/nginx-proxy:1.3.1-alpine
WORKDIR /app
COPY --from=builder /usr/src/app/dist/frontend /usr/share/nginx/html
COPY --from=builder /usr/src/app/nginx.tmpl /app/nginx.tmpl
EXPOSE 80
