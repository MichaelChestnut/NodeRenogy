FROM node:latest

WORKDIR /usr/app

COPY ./ ./

RUN npm install -g npm

RUN npm update

RUN npm install async-mqtt modbus-serial mqtt pino pino-pretty yargs

RUN mkdir -p /Data

CMD node-renogy -s /dev/ttyUSB0 -m hatsup1.iot.nau.edu \
    && bash
