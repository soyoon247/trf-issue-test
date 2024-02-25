module "request_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{request_id}"

  method_values = {
    PATCH = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.request_id" = "true"
      }
      method_response_map = {
        200 = {}
        400 = {}
        409 = {}
        500 = {}
      }
      integration_request_parameters = {
        "integration.request.path.request_id" = "method.request.path.request_id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products-sale-requests/{request_id}"
      integration_response_map = {
        200 = { selection_pattern = "200" }
        400 = { selection_pattern = "400" }
        409 = { selection_pattern = "409" }
        500 = { selection_pattern = "500" }
      }
    }
  }
}
