FROM node:alpine as builder

RUN mkdir -p /app 
WORKDIR '/app'


COPY package*.json ./
RUN npm install
RUN chown -R node:node /app/node_modules

COPY . .
RUN npm run build

FROM nginx

EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html