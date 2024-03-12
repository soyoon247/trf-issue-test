module "plannings_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "plannings"
}

module "relations" {
  source    = "./relations"
  parent_id = module.plannings_resources.resource_id
  args      = var.args
}

module "summary" {
  source    = "./summary"
  parent_id = module.plannings_resources.resource_id
  args      = var.args
}
module "event_index" {
  source    = "./{event_index}"
  parent_id = module.plannings_resources.resource_id
  args      = var.args
}


