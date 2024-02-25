module "callback_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "callback"
}

module "failure" {
  source    = "./failure"
  parent_id = module.callback_resources.resource_id
  args      = var.args
}

module "success" {
  source    = "./success"
  parent_id = module.callback_resources.resource_id
  args      = var.args
}
