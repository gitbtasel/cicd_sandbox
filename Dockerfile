FROM node:7 as node
RUN yarn global add @angular/cli
RUN ng set --global packageManager=yarn
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app
RUN npm install
COPY . /usr/src/app
RUN yarn
RUN ng build
FROM nginx
COPY --from=node /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80
