module "ingredient-id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{ingredient-id}"

  method_values = {
    DELETE = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.temp_hwahae_authorizer
      method_request_parameters = {
        "method.request.path.ingredient-id" = "true"
      }
      method_response_map = {
        200 = { response_models = var.args.empty_response_models }
      }

      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/favorite/ingredients/{ingredient-id}"
      integration_request_parameters = {
        "integration.request.path.ingredient-id" = "method.request.path.ingredient-id"
      }
    }
  }
}
