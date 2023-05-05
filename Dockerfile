# set base image (host OS)
#FROM debian:bullseye-slim
#FROM python:3.10-slim-bullseye

# now using the prebuilt image which is on the runners.
#FROM dbt_docker_image:latest
FROM ghcr.io/ces-data-analytics/dbt_docker_image:latest

# set the working directory in the container
WORKDIR /code

# copy the dependencies file to the working directory
#COPY requirements.txt .
#RUN apt-get update && apt-get install -y git && apt-get clean

# install git
#RUN apt-get install -y git
#RUN apt-get install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev asciidoc xmlto docbook2x
#RUN apt-get install dh-autoreconf libcurl4-gnutls-dev libexpat1-dev \
#  gettext libz-dev libssl-dev
#RUN whereis git

# install dependencies
#RUN pip install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY . .
#RUN mkdir src
#COPY src/ /src/

# command to run on container start
#CMD [ "python", "./app.py" ] 
ENTRYPOINT ["/bin/bash","./entrypoint.sh"]
