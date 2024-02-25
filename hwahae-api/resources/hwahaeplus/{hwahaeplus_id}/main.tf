module "hwahaeplus_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{hwahaeplus_id}"
}

module "comments" {
  source    = "./comments"
  parent_id = module.hwahaeplus_id_resources.resource_id
  args      = var.args
}

module "like" {
  source    = "./like"
  parent_id = module.hwahaeplus_id_resources.resource_id
  args      = var.args
}

module "scrap" {
  source    = "./scrap"
  parent_id = module.hwahaeplus_id_resources.resource_id
  args      = var.args
}

