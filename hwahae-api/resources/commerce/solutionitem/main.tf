module "solutionitem_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "solutionitem"
}

module "goods" {
  source    = "./goods"
  parent_id = module.solutionitem_resources.resource_id
  args      = var.args
}

module "categories" {
  source    = "./categories"
  parent_id = module.solutionitem_resources.resource_id
  args      = var.args
}
