module "reviews_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "reviews"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.header.hwahae-device-scale"   = "true"
        "method.request.path.id"                      = "true"
        "method.request.querystring.currentItemCount" = "false"
      }

      integration_request_parameters = {
        "integration.request.header.hwahae-device-scale"   = "method.request.header.hwahae-device-scale"
        "integration.request.path.id"                      = "method.request.path.id"
        "integration.request.querystring.currentItemCount" = "method.request.querystring.currentItemCount"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/scrap/reviews"
    }
  }
}
