resource "aws_lambda_function" "yt-gen-ms_lambda" {
  function_name    = "yt-gen-ms-lambda"
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  filename         = "../server/lambda_function2.zip"
  source_code_hash = filebase64sha256("../server/lambda_function2.zip")
  role             = aws_iam_role.lambda_exec.arn
}
