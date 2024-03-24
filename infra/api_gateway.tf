resource "aws_api_gateway_rest_api" "yt-gen-ms" {
  name        = "yt-gen-ms"
  description = "youtube video generator microservice"
}

resource "aws_api_gateway_resource" "yt-gen-ms_resource" {
  rest_api_id = aws_api_gateway_rest_api.yt-gen-ms.id
  parent_id   = aws_api_gateway_rest_api.yt-gen-ms.root_resource_id
  path_part   = "yt-gen"
}

resource "aws_api_gateway_method" "yt-gen-ms_method" {
  rest_api_id   = aws_api_gateway_rest_api.yt-gen-ms.id
  resource_id   = aws_api_gateway_resource.yt-gen-ms_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "yt-gen-ms_integration" {
  rest_api_id             = aws_api_gateway_rest_api.yt-gen-ms.id
  resource_id             = aws_api_gateway_resource.yt-gen-ms_resource.id
  http_method             = aws_api_gateway_method.yt-gen-ms_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.yt-gen-ms_lambda.invoke_arn
}


resource "aws_api_gateway_method_response" "yt-gen-ms_method_response" {
  rest_api_id = aws_api_gateway_rest_api.yt-gen-ms.id
  resource_id = aws_api_gateway_resource.yt-gen-ms_resource.id
  http_method = aws_api_gateway_method.yt-gen-ms_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}


resource "aws_api_gateway_integration_response" "yt-gen-ms_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.yt-gen-ms.id
  resource_id = aws_api_gateway_resource.yt-gen-ms_resource.id
  http_method = aws_api_gateway_method.yt-gen-ms_method.http_method
  status_code = aws_api_gateway_method_response.yt-gen-ms_method_response.status_code

  response_parameters = {
    "application/json" = jsonencode({ message = "$input.path('$.errorMessage')" })
  }
}

resource "aws_api_gateway_deployment" "yt-gen-ms_deployment" {
  depends_on  = [aws_api_gateway_integration.yt-gen-ms_integration]
  rest_api_id = aws_api_gateway_rest_api.yt-gen-ms.id
  stage_name  = "nonprod"
}
