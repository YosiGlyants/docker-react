FROM node:alpine as builder     
# Tagging this as a builder phase (installing dependencies) FOR PRODUCTION ENVIORMENT

WORKDIR '/app'


COPY package.json .
RUN npm install

COPY . .

RUN npm run build


# Second phase (second container)

FROM nginx 
# Elastic beanstalk (AWS) will look at what port is exposed is the port that will get mapped automaticly
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
# Copy from the first container we tagged as builder from app build to nginx/html

# the default command of nginx will start it

