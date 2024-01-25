module "duplicated_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "duplicated"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_request_parameters = {
        "method.request.path.product_id" = "true"

      }
      method_response_map = {
        200 = { response_models = var.args.response_models_empty }
      }
      integration_request_parameters = {
        "integration.request.path.product_id" = "method.request.path.product_id"

      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/products/{product_id}/reviews/duplicated"
    }
  }
}
