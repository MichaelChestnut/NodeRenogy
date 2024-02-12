FROM node:latest

WORKDIR /usr/app

COPY ./ ./

RUN npm install -g npm

RUN npm update

RUN npm install async-mqtt modbus-serial mqtt pino pino-pretty yargs

RUN mkdir -p /Data

# Install timezone dependencies and establish docker container timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
ENV TZ=America/Phoenix
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN npm link

# sleep command to give mosquitto time to start before using.
CMD node-renogy -s /dev/ttyUSB0 \
    && bash
