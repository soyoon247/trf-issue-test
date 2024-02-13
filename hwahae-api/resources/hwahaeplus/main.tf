module "hwahaeplus_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "hwahaeplus"
}

module "collections" {
  source    = "./collections"
  parent_id = module.hwahaeplus_resources.resource_id
  args      = var.args
}
module "contents" {
  source    = "./contents"
  parent_id = module.hwahaeplus_resources.resource_id
  args      = var.args
}
module "editors" {
  source    = "./editors"
  parent_id = module.hwahaeplus_resources.resource_id
  args      = var.args
}

module "hwahaeplus_id" {
  source    = "./{hwahaeplus_id}"
  parent_id = module.hwahaeplus_resources.resource_id
  args      = var.args
}


