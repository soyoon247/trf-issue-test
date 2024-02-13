module "support_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "support"
}

module "type" {
  source    = "./{type}"
  parent_id = module.support_resources.resource_id
  args      = var.args
}

module "join-routes" {
  source    = "./join-routes"
  parent_id = module.support_resources.resource_id
  args      = var.args
}

module "faqs" {
  source    = "./faqs"
  parent_id = module.support_resources.resource_id
  args      = var.args
}
