module "proxy_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{proxy+}"

  method_values = {
    ANY = {
      method_request_parameters = {
        "method.request.path.proxy" = true
      }
      method_response_map = {
        404 = {}
      }
      integration_type = var.args.integration_type.MOCK
      integration_response_map = {
        404 = {}
      }
    }
  }
}
