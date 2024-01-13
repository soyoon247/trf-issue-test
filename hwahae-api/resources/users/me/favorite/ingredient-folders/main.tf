module "ingredient-folders_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "ingredient-folders"

  method_values = {
    GET = {
      method_response_map = {
        200 = { response_models = var.args.response_models_empty }
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/favorite/ingredient-folders"
    }
  }
}

module "ingredient_favorite_folder_id" {
  source    = "./{ingredient_favorite_folder_id}"
  parent_id = module.ingredient-folders_resources.resource_id
  args      = var.args
}
