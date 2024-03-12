module "cart_count_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "cart_count"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_auth_authorizer
      method_request_parameters = {
        "method.request.path.id" = "true"
      }
      method_response_map = {
        200 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/cart_count"
      integration_response_map = {
        200 = {}
        500 = { selection_pattern : "500" }
      }
    }
  }
}
