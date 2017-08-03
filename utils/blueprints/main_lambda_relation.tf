variable "folder_path" {
  description = ""
  default = "change his value for <folder_path_function>"
}

module "lambda_fn1" {
  source  = "${var.folder_path}"
  name    = "./lambda/fn1/handler"
  runtime = "nodejs6.10"
  entrypoint = "lambda/fn1/index.handler"
  role    = "${aws_iam_role.global_lambda.arn}"
}


resource "aws_api_gateway_resource" "eclass_api_res_<name_function>" {
  rest_api_id = "${aws_api_gateway_rest_api.eclass_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.eclass_api.root_resource_id}"
  path_part   = "<name_path>"
}

module "fn1_get" {
  source      = "./apigateway"
  rest_api_id = "${aws_api_gateway_rest_api.eclass_api.id}"
  resource_id = "${aws_api_gateway_resource.eclass_api_res_fn1.id}"
  method      = "GET"
  path        = "${aws_api_gateway_resource.eclass_api_res_fn1.path}"
  lambda      = "${module.lambda_fn1.name}"
  region      = "${var.aws_region}"
  account_id  = "${var.aws_account_id}"
}