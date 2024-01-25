module "collections_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "collections"

  method_values = {
    GET = {
      method_response_map = {
        200 = {}
        500 = {}
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/hwahaeplus/collections"
      integration_response_map = {
        200 = { selection_pattern = "200" }
        500 = { selection_pattern = "500" }
      }
    }
  }
}


