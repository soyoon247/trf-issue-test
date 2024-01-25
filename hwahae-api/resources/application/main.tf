module "application_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "application"
}

module "landing-data" {
  source    = "./landing-data"
  parent_id = module.application_resources.resource_id
  args      = var.args
}


