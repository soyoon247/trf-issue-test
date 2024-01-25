module "ingredient-info_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "ingredient-info"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.encrypted_product_id" = "true"
      }
      method_response_map = {}
      integration_request_parameters = {
        "integration.request.path.encrypted_product_id" = "method.request.path.encrypted_product_id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/{encrypted_product_id}/ingredient-info"
    }
  }
}
