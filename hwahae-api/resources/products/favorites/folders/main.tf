module "folders_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "folders"
  common_values = {
    authorization       = var.args.authorization.CUSTOM
    authorizer_id       = var.args.hwahae_authorizer_id_map.hwahae_authorizer
    method_response_map = {}
    integration_uri     = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/favorites/folders"
  }
  method_values = {
    GET  = {}
    POST = {}
  }
}

module "product_favorite_folder_id" {
  source    = "./{product_favorite_folder_id}"
  parent_id = module.folders_resources.resource_id
  args      = var.args
}


