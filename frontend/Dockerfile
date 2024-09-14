FROM node:alpine AS build
WORKDIR /client
COPY ./package-lock.json ./package.json /client/
RUN npm install
COPY . /client/
RUN npm run build

FROM nginx:alpine
COPY --from=build /client/dist /usr/share/nginx/html
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]