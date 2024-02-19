# Specifies a parent image
FROM hugomods/hugo
# RUN apt-get update
# RUN apt install -y snapd
 
# Creates an app directory to hold your app’s source code
WORKDIR /src
 
#ADD . .
 
# Installs Go dependencies
#RUN go mod download
 
# Builds your app with optional configuration
# RUN go build -o /godocker
 
# Tells Docker which network port your container listens on
# EXPOSE 1313
 
# Specifies the executable command that runs when the container starts
# CMD [ “/godocker” ]

