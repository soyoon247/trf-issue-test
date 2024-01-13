module "products_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "products"
}

module "product_id" {
  source    = "./{product_id}"
  parent_id = module.products_resources.resource_id
  args      = var.args
}
