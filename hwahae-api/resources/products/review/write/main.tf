module "write_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "write"

  method_values = {
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.temp_hwahae_authorizer

      method_request_parameters = {
        "method.request.header.Content-Type" = "false"
      }
      method_response_map = {
        200 = {}
        500 = {}
      }
      integration_uri = "http://$${stageVariables.HWAHAE_JSP}/HwaHae3.0/Review/ReviewUpdate_3.10.2.jsp"
    }
  }
}

