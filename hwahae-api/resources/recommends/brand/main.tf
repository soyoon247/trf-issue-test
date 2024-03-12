module "brand_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "brand"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-app-version" = "false"
        "method.request.header.hwahae-platform"    = "false"
        "method.request.querystring.userId"        = "false"
      }
      integration_request_parameters = {
        "integration.request.header.hwahae-app-version" = "method.request.header.hwahae-app-version"
        "integration.request.header.hwahae-platform"    = "method.request.header.hwahae-platform"
        "integration.request.querystring.userId"        = "method.request.querystring.userId"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/recommends/brand"
    }
  }
}
