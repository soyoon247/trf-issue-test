module "review-topic-filters_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "review-topic-filters"

  method_values = {
    GET = {

      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.querystring.category_id"          = "false"
        "method.request.querystring.limit"                = "false"
        "method.request.querystring.offset"               = "false"
        "method.request.querystring.ordering"             = "false"
        "method.request.querystring.product_attribute_id" = "false"
      }
      method_response_map = {
        200 = {}
        400 = {}
      }
      integration_request_parameters = {
        "integration.request.querystring.category_id"          = "method.request.querystring.category_id"
        "integration.request.querystring.limit"                = "method.request.querystring.limit"
        "integration.request.querystring.offset"               = "method.request.querystring.offset"
        "integration.request.querystring.ordering"             = "method.request.querystring.ordering"
        "integration.request.querystring.product_attribute_id" = "method.request.querystring.product_attribute_id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/review-topic/review-topic-filters"
      integration_response_map = {
        200 = { selection_pattern = "200" }
        400 = { selection_pattern = "400" }
      }
    }
  }
}

