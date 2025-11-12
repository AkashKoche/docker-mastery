FROM node:18 AS development

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

FROM node:18-alpine AS production

ENV NODE_ENV=production

WORKDIR /usr/src/app

COPY --from=development /usr/src/app/node_modules ./node_modules

COPY --from=development /usr/src/app .

EXPOSE 3000

CMD ["node", "server.js"]
