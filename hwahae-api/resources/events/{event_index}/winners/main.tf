module "winners_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "winners"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.event_index"   = "true"
        "method.request.querystring.userId" = "false"
      }
      integration_request_parameters = {
        "integration.request.path.event_index"   = "method.request.path.event_index"
        "integration.request.querystring.userId" = "method.request.querystring.userId"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/events/{event_index}/winners"

    }
  }
}
