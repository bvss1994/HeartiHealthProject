# Stage 1
FROM node:14 as build-step
VOLUME /tmp 
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app

RUN npm install
COPY . /app

RUN npm run build --prod

# Stage 2
FROM nginx:1.17.1-alpine
COPY --from=build-step /app/docs /usr/share/nginx/html
