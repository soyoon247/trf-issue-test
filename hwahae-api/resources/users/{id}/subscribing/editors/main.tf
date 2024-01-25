module "editors_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "editors"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_request_parameters = {
        "method.request.header.hwahae-user-id" = "true"
        "method.request.path.id"               = "true"
      }
      method_response_map = {
        200 = {}
        401 = {}
        403 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.header.hwahae-user-id" = "method.request.header.hwahae-user-id"
        "integration.request.path.id"               = "method.request.path.id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/subscribing/editors"
      integration_response_map = {
        200 = { selection_pattern : "200" }
        401 = { selection_pattern : "401" }
        403 = { selection_pattern : "403" }
        500 = { selection_pattern : "500" }
      }
    }
  }
}
