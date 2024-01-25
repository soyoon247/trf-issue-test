module "similar-products_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "similar-products"
}

module "search" {
  source    = "./search"
  parent_id = module.similar-products_resources.resource_id
  args      = var.args
}


