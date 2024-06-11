resource "aws_api_gateway_deployment" "release_test" {
  rest_api_id = var.rest_api_id
  description = "test"
#
#  lifecycle {
#    create_before_destroy = true
#  }
}


resource "aws_api_gateway_deployment" "release_test_3" {
  rest_api_id = var.rest_api_id
  description = "test 3"

  triggers = {
    redeployment = 1
  }

  lifecycle {
    create_before_destroy = true
  }
}
