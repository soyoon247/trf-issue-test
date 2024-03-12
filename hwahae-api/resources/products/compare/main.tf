module "compare_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "compare"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.querystring.product_json" = "true"
      }
      method_response_map = {
        200 = {}
        400 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.querystring.product_json" = "method.request.querystring.product_json"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/util/compare"
      integration_response_map = {
        200 = {}
        400 = { selection_pattern = "400" }
        500 = { selection_pattern = "500" }
      }
    }
  }
}
