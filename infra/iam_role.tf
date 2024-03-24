resource "aws_iam_role" "yt-gen-ms_lambda_role" {
  name = "yt-gen-ms_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy_attachment" "yt-gen-ms_lambda_role_policy_attachment" {
  name       = "yt-gen-ms_lambda_role_policy_attachment"
  roles      = [aws_iam_role.yt-gen-ms_lambda_role.name]
  policy_arn = "arn:aws:iam:aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
