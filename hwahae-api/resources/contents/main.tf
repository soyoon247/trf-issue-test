module "contents_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "contents"
}

module "award" {
  source    = "./award"
  parent_id = module.contents_resources.resource_id
  args      = var.args
}

module "home" {
  source    = "./home"
  parent_id = module.contents_resources.resource_id
  args      = var.args
}

module "hwahaeplus" {
  source    = "./hwahaeplus"
  parent_id = module.contents_resources.resource_id
  args      = var.args
}

