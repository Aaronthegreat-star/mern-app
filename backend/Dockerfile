FROM node:alpine3.14
ENV NODE_ENV=production
WORKDIR /client
COPY ["package*.json", "npm-shrinkwrap.json*", "package-lock.json", "./"]
RUN npm install --production -s && mv node_modules ../
COPY . .
EXPOSE 5000
RUN chown -R node /client
USER node
CMD ["npm", "start"]

