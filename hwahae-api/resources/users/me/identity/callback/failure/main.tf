module "failure_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "failure"

  method_values = {
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token,hwahae-user-id,hwahae-timestamp,hwahae-signature,hwahae-device-id,hwahae-app-version,hwahae-device-scale,hwahae-platform'"
            "method.response.header.Access-Control-Allow-Methods" = var.args.all_methods
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_request_parameters = {
        "method.request.header.hwahae-user-id" = "true"
      }
      method_response_map = {
        200 = { response_models = var.args.response_models_empty }
      }

      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/identity/callback/failure"
    }
  }
}
