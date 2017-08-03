
data "aws_iam_policy_document" "lamda_role_json" {
  statement {
    sid = ""
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

}

resource "aws_iam_role" "huemul_iam" {
  name = "huemul_iam"
  assume_role_policy = "${data.aws_iam_policy_document.lamda_role_json.json}"
}