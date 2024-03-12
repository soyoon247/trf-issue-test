module "count_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "count"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.filters"                     = "false"
        "method.request.querystring.query"                       = "true"
        "method.request.querystring.selected_age_group"          = "false"
        "method.request.querystring.selected_personal_color_key" = "false"
        "method.request.querystring.selected_skin_type_key"      = "false"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.querystring.filters"                     = "method.request.querystring.filters"
        "integration.request.querystring.query"                       = "method.request.querystring.query"
        "integration.request.querystring.selected_age_group"          = "method.request.querystring.selected_age_group"
        "integration.request.querystring.selected_personal_color_key" = "method.request.querystring.selected_personal_color_key"
        "integration.request.querystring.selected_skin_type_key"      = "method.request.querystring.selected_skin_type_key"
      }
      integration_type                 = var.args.integration_type.HTTP
      integration_passthrough_behavior = var.args.passthrough_behavior.WHEN_NO_TEMPLATES
      integration_uri                  = "http://$${stageVariables.HWAHAE_SEARCH_SERVER}/$${stageVariables.HWAHAE_SEARCH_SERVER_VERSION}/reviews/count"
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
