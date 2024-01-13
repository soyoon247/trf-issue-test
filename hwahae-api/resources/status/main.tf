module "status_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "status"
}

module "counts" {
  source    = "./counts"
  parent_id = module.status_resources.resource_id
  args      = var.args
}

module "homepage" {
  source    = "./homepage"
  parent_id = module.status_resources.resource_id
  args      = var.args
}

module "landing" {
  source    = "./landing"
  parent_id = module.status_resources.resource_id
  args      = var.args
}

module "versions" {
  source    = "./versions"
  parent_id = module.status_resources.resource_id
  args      = var.args
}

