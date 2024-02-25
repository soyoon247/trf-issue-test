module "deal_event_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{deal_event_id}"
}

module "components" {
  source    = "./components"
  parent_id = module.deal_event_id_resources.resource_id
  args      = var.args
}

module "meta" {
  source    = "./meta"
  parent_id = module.deal_event_id_resources.resource_id
  args      = var.args
}
