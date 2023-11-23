
FROM  node:18.8.0-alpine3.16
COPY . .
RUN npm install
CMD [ "node", "app.js" ]


