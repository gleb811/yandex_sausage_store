# build
FROM node:16.20.0-alpine3.18 as builder
ARG VERSION=${VERSION}
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build
RUN sed -i "s/{{VERSION}}/${VERSION}/g" dist/frontend/main.js


# Final stage
FROM nginx:stable-alpine3.17-slim
WORKDIR /app
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/dist/frontend /usr/share/nginx/html
EXPOSE 80
