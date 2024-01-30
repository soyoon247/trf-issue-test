module "reviews_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "reviews"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.product_topic_id" = "true"
        "method.request.querystring.limit"     = "false"
        "method.request.querystring.offset"    = "false"
        "method.request.querystring.ordering"  = "false"
      }
      method_response_map = {
        200 = {}
        400 = {}
      }
      integration_request_parameters = {
        "integration.request.path.product_topic_id" = "method.request.path.product_topic_id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/review-topic/product-topics/{product_topic_id}/reviews"
    }
  }
}
