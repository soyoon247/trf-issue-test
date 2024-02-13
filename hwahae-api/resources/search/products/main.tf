module "products_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "products"
}

module "predictions" {
  source    = "./predictions"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "tag" {
  source    = "./tag"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "text" {
  source    = "./text"
  parent_id = module.products_resources.resource_id
  args      = var.args
}
