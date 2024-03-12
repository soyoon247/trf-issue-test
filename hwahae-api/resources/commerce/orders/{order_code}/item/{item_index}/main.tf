module "item_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{item_index}"
}

module "confirm" {
  source    = "./confirm"
  parent_id = module.item_index_resources.resource_id
  args      = var.args
}
