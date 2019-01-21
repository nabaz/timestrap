FROM node:8 AS build
WORKDIR /build

COPY . /build

RUN npm i -g npm
RUN npm i --production

RUN npx webpack


FROM python:3.6
ENV PYTHONUNBUFFERED 1
WORKDIR /app

COPY . /app

RUN pip install pipenv

COPY --from=build /build/client/static /app/client/static

RUN python manage.py collectstatic --noinput
