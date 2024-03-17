FROM node:lts-alpine AS builder

RUN apk update
RUN npm install -g pnpm

WORKDIR /app
COPY . .

RUN pnpm install && pnpm run generate

FROM nginx:1.24-alpine3.17
COPY --from=builder /app/.output/public /usr/share/nginx/html
EXPOSE 80
