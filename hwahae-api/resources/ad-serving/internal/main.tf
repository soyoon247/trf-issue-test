module "internal_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "internal"
}

module "proxy" {
  source    = "./{proxy+}"
  parent_id = module.internal_resources.resource_id
  args      = var.args
}


