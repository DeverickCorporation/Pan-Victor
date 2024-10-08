# build environment
FROM node:18.14.2-alpine3.17 as build
WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# production environment
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY --from=build /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8006
CMD ["nginx", "-g", "daemon off;"]
