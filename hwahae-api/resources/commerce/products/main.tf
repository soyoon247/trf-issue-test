module "products_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "products"
}

module "encrypted_product_id" {
  source    = "./{encrypted_product_id}"
  parent_id = module.products_resources.resource_id
  args      = var.args
}
