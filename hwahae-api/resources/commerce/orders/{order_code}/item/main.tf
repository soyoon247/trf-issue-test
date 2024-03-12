module "item_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "item"
}

module "item_index" {
  source    = "./{item_index}"
  parent_id = module.item_resources.resource_id
  args      = var.args
}