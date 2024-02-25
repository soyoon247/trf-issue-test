module "comments_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "comments"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.event_index" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.event_index" = "method.request.path.event_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/events/{event_index}/comments"
    }
  }
}
