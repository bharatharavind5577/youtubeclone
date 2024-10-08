# Build stage
FROM node:16 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM node:16

WORKDIR /app
COPY --from=build /app/build ./build
COPY package*.json ./
RUN npm install --only=production

EXPOSE 3030
CMD ["npm", "start"]
