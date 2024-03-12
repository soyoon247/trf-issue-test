module "status_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "status"
}

module "events" {
  source    = "./events"
  parent_id = module.status_resources.resource_id
  args      = var.args
}
