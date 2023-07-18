FROM node:latest AS BUILDER
WORKDIR /app
COPY ./lession_3.pdf .

FROM ubuntu:latest
WORKDIR /app
COPY --from=BUILDER /app/lession_3.pdf ./from_builder/