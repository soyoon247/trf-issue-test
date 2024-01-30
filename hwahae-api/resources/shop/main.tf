module "shop_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "shop"
}

module "banners" {
  source    = "./banners"
  parent_id = module.shop_resources.resource_id
  args      = var.args
}

module "mdpick" {
  source    = "./mdpick"
  parent_id = module.shop_resources.resource_id
  args      = var.args
}

module "sellers" {
  source    = "./sellers"
  parent_id = module.shop_resources.resource_id
  args      = var.args
}

module "tabs" {
  source    = "./tabs"
  parent_id = module.shop_resources.resource_id
  args      = var.args
}


