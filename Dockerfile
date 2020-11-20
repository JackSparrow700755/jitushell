FROM lzzy12/mega-sdk-python:latest

# Install all the required packages
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
RUN apt-get -qq update
RUN apt-get -qq install -y aria2 python3 python3-pip \
    git bash build-essential curl wget \
    nodejs npm aria2 p7zip-full zip unzip qbittorrent-nox ruby python-minimal python-pip locales pv jq ffmpeg mediainfo

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# rclone and gclone
RUN curl https://rclone.org/install.sh | bash

#install rmega
RUN gem install rmega

# Copies config(if it exists)
COPY . .
RUN chmod +x g && chmod +x db.sh

# Install requirements and start the bot
RUN npm install

#install requirements
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# setup workdir

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y dist-upgrade

CMD ["node", "server"]
