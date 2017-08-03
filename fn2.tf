module "lambda_fn2" {
  source  = "./lambda/fn2"
  name    = "./lambda/fn2/handler"
  runtime = "nodejs6.10"
  entrypoint = "lambda/fn2/index.handler"
  role    = "${aws_iam_role.huemul_iam.arn}"
}


resource "aws_api_gateway_resource" "huemul_api_res_fn2" {
  rest_api_id = "${aws_api_gateway_rest_api.huemul_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.huemul_api.root_resource_id}"
  path_part   = "fn2"
}

module "fn2_get" {
  source      = "./apigateway"
  rest_api_id = "${aws_api_gateway_rest_api.huemul_api.id}"
  resource_id = "${aws_api_gateway_resource.huemul_api_res_fn2.id}"
  method      = "GET"
  path        = "${aws_api_gateway_resource.huemul_api_res_fn2.path}"
  lambda      = "${module.lambda_fn2.name}"
  region      = "${var.aws_region}"
  account_id  = "${var.aws_account_id}"
}