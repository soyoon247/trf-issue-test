module "send-change-login-type-email_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "send-change-login-type-email"

  method_values = {
    POST = {
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/auth/send-change-login-type-email"
    }
  }
}
