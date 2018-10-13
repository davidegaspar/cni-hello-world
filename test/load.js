'use strict';

var loadtest = require('loadtest');

var options = {
  url: 'http://stack-helloworld-lb-78743140.us-east-1.elb.amazonaws.com',
  concurrent: 1,
  method: 'GET',
  requestsPerSecond:1,
  maxSeconds:10*60,
  keepalive: true,
  timeout: 5000
};

loadtest.loadTest(options);
