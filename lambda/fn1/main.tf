

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/"
  output_path = "archives/handler_fn1.zip"
}

resource "aws_lambda_function" "lambda" {
  filename          = "${var.name}.zip"
  source_code_hash  = "${data.archive_file.lambda_zip.output_base64sha256}"
  function_name     = "${var.function_name}"
  role              = "${var.role}"
  handler           = "${var.entrypoint}"
  runtime           = "${var.runtime}"
}

output "name" {
  value = "${aws_lambda_function.lambda.function_name}"
}
