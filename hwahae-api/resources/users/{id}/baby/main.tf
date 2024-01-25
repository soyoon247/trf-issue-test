module "baby_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "baby"
}

module "check" {
  source    = "./check"
  parent_id = module.baby_resources.resource_id
  args      = var.args
}
