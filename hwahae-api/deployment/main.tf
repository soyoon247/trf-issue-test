resource "aws_api_gateway_deployment" "release_test" {
  rest_api_id = var.rest_api_id
  description = "test"
#
#  lifecycle {
#    create_before_destroy = true
#  }
}
