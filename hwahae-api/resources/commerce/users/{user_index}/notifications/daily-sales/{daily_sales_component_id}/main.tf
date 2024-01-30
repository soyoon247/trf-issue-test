module "daily_sales_component_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{daily_sales_component_id}"

  method_values = {
    PUT = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.daily_sales_component_id" = "true"
        "method.request.path.user_index"               = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.daily_sales_component_id" = "method.request.path.daily_sales_component_id"
        "integration.request.path.user_index"               = "method.request.path.user_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/$${stageVariables.HWAHAE_COMMERCE_SERVER_VERSION}/users/{user_index}/notifications/daily-sales/{daily_sales_component_id}"
      integration_response_map = {
        200 = {}
      }
    }
  }
}

