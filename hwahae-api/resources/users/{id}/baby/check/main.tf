module "check_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "check"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.id" = "true"
      }

      integration_request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/users/{id}/baby/check"
    }
  }
}
