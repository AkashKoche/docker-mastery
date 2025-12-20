FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
COPY tsconfig.json ./
COPY .npmrc ./

RUN npm ci --silent

COPY public/ ./public/
COPY src/ ./src/

RUN npm run build

FROM nginx:1.23-alpine AS production

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/build /usr/share/nginx/html

COPY nginx.conf /etc/ngnix/conf.d/default.conf

COPY ssl/ /etc/nginx/ssl/

RUN addgroup -g 1001 -S www-data && adduser -S www-data -G www-data

RUN chown -R www-data:www-data /usr/share/nginx/html && \
    chown -R www-data:www-data /var/cache/ngnix/ && \
    chown -R www-data:www-data /var/log/nginx && \
    chown -R www-data:www-data /etc/nginx/conf.d

RUN touch /var/run/nginx.pid && \
    chown -R www-data:www-data /var/run/nginx.pid

USER www-data

EXPOSE 80
EXPOSE 443

HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
