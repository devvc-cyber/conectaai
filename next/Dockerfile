# nextjs/Dockerfile

# Etapa de build
FROM node:16-alpine AS builder

WORKDIR /usr/src/app

COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn build

# Etapa de produção
FROM node:16-alpine

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/.next ./.next
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/package.json ./
COPY --from=builder /usr/src/app/public ./public

EXPOSE 3000

CMD ["yarn", "start"]
