exports.handler = async (event) => {
    try {

        const requestBody = JSON.parse(event.body)
        const responseData = {
            message: 'Received data:',
            data: requestBody
        };

        // Prepare the HTTP response
        const response = {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*' // Enable CORS
            },
            body: JSON.stringify(responseData)
        };

        return response;
    } catch (error) {
        console.log("error", error);

        const errorResponse = {
            statusCode: 500,
            headers: {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            body: JSON.stringify({ error: "internal server error" })
        }

        return errorResponse
    }
}