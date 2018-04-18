FROM node:8.9.4-alpine

RUN mkdir /opt/app
WORKDIR /opt/app

# ENV variables like export
ENV NODE_ENV=development

# COPY vs ADD
# copy from build context, into
COPY package.json package.json
COPY yarn.lock yarn.lock

# RUN (command / change) the file system
# intermediate containers are used to build images
RUN yarn

# we'll do something different with this later
COPY tsconfig.json tsconfig.json
COPY tslint.json tslint.json
COPY .angular-cli.json .angular-cli.json
COPY src src

EXPOSE 4200

# CMD vs ENTRYPOINT
ENTRYPOINT [ "yarn", "serve" ]