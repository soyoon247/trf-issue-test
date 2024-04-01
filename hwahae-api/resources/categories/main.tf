module "categories_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "categories"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.brand_id" = "false"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }

      integration_request_parameters = {
        "integration.request.querystring.brand_id" = "method.request.querystring.brand_id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/categories"
    }
  }
}
