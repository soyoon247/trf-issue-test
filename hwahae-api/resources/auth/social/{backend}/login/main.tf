module "login_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "login"

  method_values = {
    POST = {
      method_request_parameters = {
        "method.request.path.backend" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.backend" = "method.request.path.backend"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/auth/social/{backend}/login"
    }

    OPTIONS = {
      method_request_parameters = {
        "method.request.path.backend" = "true"
      }
      integration_type = var.args.integration_type.HTTP_PROXY
      integration_request_parameters = {
        "integration.request.path.backend" = "method.request.path.backend"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/auth/social/{backend}/login"
    }
  }
}
