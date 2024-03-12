module "keyword_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "keyword"

  method_values = {
    POST = {
      method_response_map = {
        200 = {}
        204 = {}
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/search/keyword"
      integration_response_map = {
        200 = {}
        204 = { selection_pattern = "204" }
      }
    }
  }
}

