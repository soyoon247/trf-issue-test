module "award_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{award_id}"
}

module "categories" {
  source    = "./categories"
  parent_id = module.award_id_resources.resource_id
  args      = var.args
}

module "products" {
  source    = "./products"
  parent_id = module.award_id_resources.resource_id
  args      = var.args
}






