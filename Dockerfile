FROM node:alpine as builder     
# Tagging this as a builder phase (installing dependencies) FOR PRODUCTION ENVIORMENT

WORKDIR '/app'


COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# /app/build <<<<< where the build phase will be stored

FROM nginx 
# Second phase (second container)
COPY --from=builder /app/build /usr/share/nginx/html
# Copy from the first container we tagged as builder from app build to nginx/html

# the default command of nginx will start it

