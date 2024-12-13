# Stage 1: Build the React app
FROM node:lts AS build

WORKDIR /
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# Stage 2: Serve the build with Nginx
FROM nginx:alpine

COPY --from=build /build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]