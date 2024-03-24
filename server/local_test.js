const testJSON = {
    "body": "{\"name\": \"John\"}",
    "httpMethod": "POST",
    "path": "/",
    "headers": {
        "Content-Type": "application/json"
    }
}

// local_test.js
const lambdaFunction = require('./index.js'); // Assuming your Lambda function code is in index.js

// Simulate Lambda execution by calling the handler function
lambdaFunction.handler(testJSON, {}, (error, response) => {
    if (error) {
        console.error('Error:', error);
    } else {
        console.log('Response:', response);
    }
});