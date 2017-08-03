module "lambda_fn1" {
  source  = "./lambda/fn1"
  name    = "./lambda/fn1/handler"
  runtime = "nodejs6.10"
  entrypoint = "lambda/fn1/index.handler"
  role    = "${aws_iam_role.huemul_iam.arn}"
}

resource "aws_api_gateway_resource" "huemul_api_res_fn1" {
  rest_api_id = "${aws_api_gateway_rest_api.huemul_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.huemul_api.root_resource_id}"
  path_part   = "fn1"
}

module "fn1_get" {
  source      = "./apigateway"
  rest_api_id = "${aws_api_gateway_rest_api.huemul_api.id}"
  resource_id = "${aws_api_gateway_resource.huemul_api_res_fn1.id}"
  method      = "GET"
  path        = "${aws_api_gateway_resource.huemul_api_res_fn1.path}"
  lambda      = "${module.lambda_fn1.name}"
  region      = "${var.aws_region}"
  account_id  = "${var.aws_account_id}"
}





