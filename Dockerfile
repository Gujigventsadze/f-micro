FROM node:18-alpine AS builder-anotherproj
WORKDIR /app/anotherproj
COPY ./anotherproj .
RUN npm install
RUN npm run build

FROM node:18-alpine AS builder-docker-pract
WORKDIR /app/docker-pract
COPY ./docker-pract .
RUN npm install
RUN npm run build

FROM nginx:alpine
COPY --from=builder-anotherproj /app/anotherproj/dist /usr/share/nginx/html/anotherproj
COPY --from=builder-docker-pract /app/docker-pract/dist /usr/share/nginx/html/docker-pract
COPY nginx/default.conf /etc/nginx/conf.d/default.conf