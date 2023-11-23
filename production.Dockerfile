FROM node:19-alpine3.15 as dev-deps
WORKDIR /app
COPY package.json package.json
RUN yarn install --frozen-lockfile

FROM node:19-alpine3.15 as test
WORKDIR /app
COPY ./tests .
COPY --from=dev-deps /app/node_modules ./node_modules
COPY . .
RUN yarn test

FROM node:19-alpine3.15 as prod-deps
WORKDIR /app
COPY package.json package.json
RUN yarn install --prod --frozen-lockfile

FROM node:19-alpine3.15 as prod
WORKDIR /app
COPY --from=prod-deps /app/node_modules  ./node_modules  
COPY . .
CMD [ "yarn","start" ]