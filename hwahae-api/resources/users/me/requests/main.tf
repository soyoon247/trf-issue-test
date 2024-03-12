module "requests_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "requests"
}

module "products" {
  source    = "./products"
  parent_id = module.requests_resources.resource_id
  args      = var.args
}
