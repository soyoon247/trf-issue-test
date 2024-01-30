module "crew_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{crew_id}"
}

module "leave" {
  source    = "./leave"
  parent_id = module.crew_id_resources.resource_id
  args      = var.args
}


