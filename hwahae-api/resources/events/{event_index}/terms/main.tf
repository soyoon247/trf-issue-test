module "terms_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "terms"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.Accept"    = "false"
        "method.request.path.event_index" = "true"
        "method.request.querystring.v"    = "false"
      }

      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Content-Type" = "false"
          }
        }
      }
      integration_request_parameters = {
        "integration.request.header.Accept"    = "method.request.header.Accept"
        "integration.request.path.event_index" = "method.request.path.event_index"
        "integration.request.querystring.v"    = "method.request.querystring.v"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/events/{event_index}/terms"

      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Content-Type" = "integration.response.header.Content-Type"
          }
        }
      }

    }
  }
}
