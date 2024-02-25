module "filters_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "filters"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.query" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.querystring.query" = "method.request.querystring.query"
      }
      integration_type                 = var.args.integration_type.HTTP
      integration_passthrough_behavior = var.args.passthrough_behavior.WHEN_NO_TEMPLATES
      integration_uri                  = "http://$${stageVariables.HWAHAE_SEARCH_SERVER}/$${stageVariables.HWAHAE_SEARCH_SERVER_VERSION}/reviews/meta"
      integration_response_map = {
        200 = {
          response_templates = {
            "application/json" = ""
          }
        }
      }
    }
  }
}
