
resource "aws_apigatewayv2_api" "API-cities" {
  name          = "api-cities"
  protocol_type = "HTTP"
  cors_configuration {              
                allow_headers = ["*"]
                allow_methods = ["*"]
                allow_origins = ["*"]
                # "expose_headers": [
                #   "*"
                # ],
                # "allow_credentials": false,
                # "max_age": 0
              }
}

resource "aws_apigatewayv2_stage" "default" {
  # api_id = "aws_apigatewayv2_api.API-cities"
  # api_id = "API-cities"
  api_id = aws_apigatewayv2_api.API-cities.id
  name   = "$default"
  auto_deploy = true

}

resource "aws_apigatewayv2_integration" "lambda_handler-POST-city" {
  api_id = aws_apigatewayv2_api.API-cities.id
  integration_type = "AWS_PROXY"
  # integration_uri  = aws_lambda_function.handler.invoke_arn
  integration_uri  = "arn:aws:lambda:eu-central-1:${var.aws_account_id}:function:POST-city"
}

resource "aws_apigatewayv2_integration" "lambda_handler-GET-cities" {
  api_id = aws_apigatewayv2_api.API-cities.id
  integration_type = "AWS_PROXY"
  # integration_uri  = aws_lambda_function.handler.invoke_arn
  integration_uri  = "arn:aws:lambda:eu-central-1:${var.aws_account_id}:function:GET-cities"
}

resource "aws_apigatewayv2_route" "POST_handler" {
  api_id    = aws_apigatewayv2_api.API-cities.id
  route_key = "POST /"

  target = "integrations/${aws_apigatewayv2_integration.lambda_handler-POST-city.id}"
}

resource "aws_apigatewayv2_route" "GET_handler" {
  api_id    = aws_apigatewayv2_api.API-cities.id
  route_key = "GET /cities"

  target = "integrations/${aws_apigatewayv2_integration.lambda_handler-GET-cities.id}"
}

resource "aws_lambda_permission" "api_gw-POST-city" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  # function_name = aws_lambda_function.handler.function_name
  function_name = "POST-city"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.API-cities.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_gw-GET-cities" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  # function_name = aws_lambda_function.handler.function_name
  function_name = "GET-cities"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.API-cities.execution_arn}/*/*"
}
