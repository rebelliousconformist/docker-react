#stage 1 build 
FROM node:alpine AS builder

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

#/app/build 
RUN npm run build


#start 2nd stage build
FROM nginx 
COPY --from=builder /home/node/app/build /usr/share/nginx/html