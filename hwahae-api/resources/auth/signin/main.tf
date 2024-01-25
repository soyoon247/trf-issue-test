module "signin_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "signin"

  method_values = {
    POST = {
      integration_uri     = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/auth/signin"
      method_response_map = {}
    }
  }
}


