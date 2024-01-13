module "address_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "address"
  common_values = {
    authorization    = var.args.authorization.CUSTOM
    authorizer_id    = var.args.hwahae_authorizer_id_map.default
    integration_type = var.args.integration_type.HTTP
    integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/address"
  }
  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.id" = "true"
      }
      integration_request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
      }
    }

    POST = {
      method_request_parameters = {
        "method.request.header.Content-Type" = "false"
        "method.request.path.id"             = "true"
      }
      integration_request_parameters = {
        "integration.request.header.Content-Type" = "method.request.header.Content-Type"
        "integration.request.path.id"             = "method.request.path.id"
      }
    }
  }
}
