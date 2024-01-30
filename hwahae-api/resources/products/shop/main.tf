module "shop_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "shop"
}

module "goods" {
  source    = "./goods"
  parent_id = module.shop_resources.resource_id
  args      = var.args
}

module "price-info" {
  source    = "./price-info"
  parent_id = module.shop_resources.resource_id
  args      = var.args
}


