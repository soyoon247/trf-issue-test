module "products_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "products"

  common_values = {
    authorization = var.args.authorization.CUSTOM
    authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
    method_request_parameters = {
      "method.request.path.product_favorite_folder_id" = "true"
    }
    method_response_map = {
      200 = { response_models = var.args.empty_response_models }
    }
    integration_request_parameters = {
      "integration.request.path.product_favorite_folder_id" = "method.request.path.product_favorite_folder_id"
    }
  }
  method_values = {
    DELETE = {
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/favorite/product-folders/{product_favorite_folder_id}/products"
    }
    GET = {
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/favorite/product-folders/{product_favorite_folder_id}"
    }
    POST = {
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/favorite/product-folders/{product_favorite_folder_id}/products"
    }

  }
}
