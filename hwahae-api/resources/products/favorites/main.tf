module "favorites_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "favorites"
}

module "folders" {
  source    = "./folders"
  parent_id = module.favorites_resources.resource_id
  args      = var.args
}
