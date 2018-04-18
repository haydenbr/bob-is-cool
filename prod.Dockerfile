FROM node:8.9.4-alpine as build

ENV NODE_ENV=development

RUN mkdir /opt/app
WORKDIR /opt/app

COPY package.json package.json
COPY yarn.lock yarn.lock
RUN yarn
COPY . .
RUN yarn build

FROM nginx:1.13.12-alpine as prod

COPY --from=build /opt/app/dist /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
