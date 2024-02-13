module "categories_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "categories"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.award_id" = "true"
      }
      method_response_map = {
        200 = {}
        400 = {}
        404 = {}
      }
      integration_request_parameters = {
        "integration.request.path.award_id" = "method.request.path.award_id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/award/{award_id}/categories"
    }
  }
}
