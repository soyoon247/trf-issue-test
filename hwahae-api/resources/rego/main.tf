module "rego_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "rego"
}

module "products" {
  source    = "./products"
  parent_id = module.rego_resources.resource_id
  args      = var.args
}

module "ranking" {
  source    = "./ranking"
  parent_id = module.rego_resources.resource_id
  args      = var.args
}

module "regos" {
  source    = "./regos"
  parent_id = module.rego_resources.resource_id
  args      = var.args
}

