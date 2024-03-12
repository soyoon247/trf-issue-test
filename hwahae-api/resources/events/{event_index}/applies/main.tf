module "applies_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "applies"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.event_index"     = "true"
        "method.request.querystring.deviceId" = "false"
      }
      integration_request_parameters = {
        "integration.request.path.event_index"     = "method.request.path.event_index"
        "integration.request.querystring.deviceId" = "method.request.querystring.deviceId"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/events/{event_index}/applies"
    }
  }
}
