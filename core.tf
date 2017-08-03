resource "aws_api_gateway_rest_api" "huemul_api" {
  name = "Huemul API"
  description = "API Example for beerjs"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.huemul_api.id}"
  stage_name  = "deploy"
  description = "Deploy methods: ${module.fn1_get.http_method} ${module.fn2_get.http_method}"
}

resource "aws_api_gateway_stage" "test" {
  stage_name = "prod"
  rest_api_id = "${aws_api_gateway_rest_api.huemul_api.id}"
  deployment_id = "${aws_api_gateway_deployment.api_deployment.id}"
  cache_cluster_enabled = true
  cache_cluster_size = 0.5

}

resource "aws_api_gateway_usage_plan" "huemul_usage_plan" {
  name         = "huemul-usage-plan"
  description  = "Usage plan for huemul (it is not a whore)"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.huemul_api.id}"
    stage  = "${aws_api_gateway_deployment.api_deployment.stage_name}"
  }

  api_stages {
    api_id = "${aws_api_gateway_rest_api.huemul_api.id}"
    stage  = "${aws_api_gateway_stage.test.stage_name}"
  }


  quota_settings {
    limit  = 20
    offset = 2
    period = "WEEK"
  }

  throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }
}