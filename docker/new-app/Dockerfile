FROM node:20-alpine AS BUILDER
WORKDIR /app
COPY ./package.json .
COPY ./package-lock.json .
COPY ./tsconfig.json .
RUN npm install
COPY ./src ./src
COPY ./public ./public
RUN npm run build

FROM nginx:latest
WORKDIR /nginx
COPY --from=BUILDER /app/build /usr/share/nginx/html
EXPOSE 80