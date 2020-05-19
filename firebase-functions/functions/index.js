const functions = require('firebase-functions');
const {WebhookClient} = require('dialogflow-fulfillment');
const express = require('express');
const app = express();

app.get('/test', (request, response) => {
    response.status(200).send("hello");
})

app.post('/dialogFlowFirebaseFulfillment', (request, response) => {
    const algoliasearch = require('algoliasearch');
    const client = algoliasearch('XVRTA8E4T1', '0aea7af85bc7d1e6d2b09586ff31333e');
    const index = client.initIndex('prod_courses');
    const agent = new WebhookClient({ request, response });

    function courseLookup(agent) {
        console.log(agent.parameters);
        return index.search(`${agent.parameters.course}`).then(({ hits }) => {
            var sendThis = JSON.stringify(hits[0]);
            agent.add(`${sendThis}`);
            return Promise.resolve('Write complete');
        }).catch(error => { console.log(error) });
    }

    let intentMap = new Map();
    intentMap.set('Course Lookup', courseLookup);
    agent.handleRequest(intentMap);
})

exports.api = functions.https.onRequest(app);
