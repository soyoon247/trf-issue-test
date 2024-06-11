resource "aws_api_gateway_deployment" "release_test" {
  rest_api_id = var.rest_api_id
  description = "test"
#
#  lifecycle {
#    create_before_destroy = true
#  }
}


resource "aws_api_gateway_deployment" "release_test_4" {
  rest_api_id = var.rest_api_id
  description = "test 4"

  triggers = {
    redeployment = 4
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_test_6" {
  rest_api_id = var.rest_api_id
  description = "test 6"
}

resource "aws_api_gateway_deployment" "release_test_8" {
  rest_api_id = var.rest_api_id
  description = "test 10"

  triggers = {
    redeployment = 2
  }
}
