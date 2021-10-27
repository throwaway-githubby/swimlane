# Rather pin than blindly pull latest
FROM node:17-alpine3.12

# Planning on pushing this into the helm chart so it's easier to change
# ENV MONGODB_URL=${MONGODB_URL

WORKDIR /app

COPY package*.json ./

RUN npm install
#RUN npm ci --only=production 

COPY . .

EXPOSE 3000

CMD [ "node", "server.js"]


