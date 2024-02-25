module "orders_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "orders"
}

module "prepare" {
  source    = "./prepare"
  parent_id = module.orders_resources.resource_id
  args      = var.args
}

module "calculate" {
  source    = "./calculate"
  parent_id = module.orders_resources.resource_id
  args      = var.args
}
