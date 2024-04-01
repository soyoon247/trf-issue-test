module "login_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "login"

  common_values = {
    integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/auth/email/login"
  }

  method_values = {
    POST = {}
    OPTIONS = {
      integration_type = var.args.integration_type.HTTP_PROXY
    }
  }
}
