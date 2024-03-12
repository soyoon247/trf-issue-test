module "send-notice_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "send-notice"

  method_values = {
    POST = {
      method_request_parameters = {
        "method.request.path.order_code" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.order_code" = "method.request.path.order_code"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/orders/{order_code}/send-notice"
      integration_response_map = {
        200 = {}
      }
    }
  }
}

