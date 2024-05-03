module "products-sale-requests_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "products-sale-requests"

  common_values = {
    authorization    = var.args.authorization.CUSTOM
    authorizer_id    = var.args.hwahae_authorizer_id_map.temp_hwahae_authorizer
    integration_type = var.args.integration_type.HTTP
    integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products-sale-requests"
  }

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.limit"      = "false"
        "method.request.querystring.offset"     = "false"
        "method.request.querystring.product_id" = "false"
        "method.request.querystring.user_id"    = "false"
      }
      method_response_map = {
        200 = {}
        400 = {}
        409 = {}
        500 = {}
      }
      integration_request_parameters = {
        "integration.request.querystring.limit"      = "method.request.querystring.limit"
        "integration.request.querystring.offset"     = "method.request.querystring.offset"
        "integration.request.querystring.product_id" = "method.request.querystring.product_id"
        "integration.request.querystring.user_id"    = "method.request.querystring.user_id"
      }
      integration_response_map = {
        200 = { selection_pattern = "200" }
        400 = { selection_pattern = "400" }
        409 = { selection_pattern = "409" }
        500 = { selection_pattern = "500" }
      }

    }
    POST = {
      method_response_map = {
        200 = {}
        201 = {}
        400 = {}
        409 = {}
        500 = {}
      }
      integration_response_map = {
        200 = { selection_pattern = "200" }
        201 = { selection_pattern = "201" }
        400 = { selection_pattern = "400" }
        409 = { selection_pattern = "409" }
        500 = { selection_pattern = "500" }
      }
    }
  }
}

module "request_id" {
  source    = "./{request_id}"
  parent_id = module.products-sale-requests_resources.resource_id
  args      = var.args
}


