module "migrate_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "migrate"

  method_values = {
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.header.hwahae-platform" = "false"
        "method.request.path.id"                = "true"
      }
      method_response_map = {
        200 = {}
        400 = {}
        500 = {}
      }
      integration_request_parameters = {
        "integration.request.header.hwahae-platform" = "method.request.header.hwahae-platform"
        "integration.request.path.id"                = "method.request.path.id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/push/subscriptions/migrate"
      integration_response_map = {
        200 = {
          selection_pattern = "200"
        }
        400 = {
          selection_pattern = "400"
        }
        500 = {
          selection_pattern = "5\\d{2}"
        }
      }
    }
  }
}
