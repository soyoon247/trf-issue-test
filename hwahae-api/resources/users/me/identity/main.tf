module "identity_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "identity"
}

module "callback" {
  source    = "./callback"
  parent_id = module.identity_resources.resource_id
  args      = var.args
}

module "request" {
  source    = "./request"
  parent_id = module.identity_resources.resource_id
  args      = var.args
}

module "result" {
  source    = "./result"
  parent_id = module.identity_resources.resource_id
  args      = var.args
}

module "status" {
  source    = "./status"
  parent_id = module.identity_resources.resource_id
  args      = var.args
}
