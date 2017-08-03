variable "name" {
  description = "The name of the lambda to create, which also defines(i) the archive name (.zip), (ii) the file name, and (iii) the function name"
}

variable "runtime" {
  description = "The runtime of the lambda to create"
  default     = "<nodejs | nodejs4.3 | nodejs6.10 | java8 | python2.7 | python3.6 | dotnetcore1.0 | nodejs4.3-edge>"
}

variable "handler" {
  description = "The handler name of the lambda (a function defined in your lambda)"
  default     = "handler"
}

variable "role" {
  description = "IAM role attached to the Lambda Function (ARN)"
}

variable "function_name" {
  description = "Name for this fucntion"
  default     = "<name function>"
}

variable "entrypoint" {
  description = "Value for the entrypoint resource to route lambda function"
}

resource "aws_lambda_function" "lambda" {
  filename      = "${var.name}.zip"
  function_name = "${var.function_name}"
  role          = "${var.role}"
  handler       = "${var.entrypoint}"
  runtime       = "${var.runtime}"
}

output "name" {
  value = "${aws_lambda_function.lambda.function_name}"
}