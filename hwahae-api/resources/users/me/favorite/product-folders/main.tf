module "product-folders_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "product-folders"
}

module "product_favorite_folder_id" {
  source    = "./{product_favorite_folder_id}"
  parent_id = module.product-folders_resources.resource_id
  args      = var.args
}
