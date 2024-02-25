module "products_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "products"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.award_id"             = "true"
        "method.request.querystring.category_code" = "false"
      }
      method_response_map = {
        200 = {}
        400 = {}
        404 = {}
      }
      integration_request_parameters = {
        "integration.request.path.award_id"             = "method.request.path.award_id"
        "integration.request.querystring.category_code" = "method.request.querystring.category_code"
      }
      integration_type = "HTTP"
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/award/{award_id}/products"
    }
  }
}

