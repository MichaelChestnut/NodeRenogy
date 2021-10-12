const cli = require('./cli');
const mqtt = require('async-mqtt');
const logger = require('./logger');
const args = cli.args;

const mqttOptions = {
    username: args.mqttuser,
    password: args.mqttpass,
    clientId: `nodeRenogy_${Math.random().toString(16).substr(2,8)}`    
};

logger.trace('Connecting to MQTT broker...');
logger.trace(mqttOptions, 'With MQTT options...');
const client = await mqtt.connect(`tcp://${args.mqttbroker}`, mqttOptions)

if(client.connected) {
    logger.info('Connected to MQTT Broker!');
}

module.exports = {
    publish: async function(data) {
        try {
            logger.trace('Publishing to MQTT!');
            await client.publish(`${args.mqtttopic}/state`, JSON.stringify(data));
            await client.end();
        } catch (e){
            logger.error(e);
        }
    }
}
