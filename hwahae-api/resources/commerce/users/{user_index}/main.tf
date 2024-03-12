module "user_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{user_index}"
}

module "notifications" {
  source    = "./notifications"
  parent_id = module.user_index_resources.resource_id
  args      = var.args
}

module "cart-items" {
  source    = "./cart-items"
  parent_id = module.user_index_resources.resource_id
  args      = var.args
}

module "orders" {
  source    = "./orders"
  parent_id = module.user_index_resources.resource_id
  args      = var.args
}

module "wishes" {
  source    = "./wishes"
  parent_id = module.user_index_resources.resource_id
  args      = var.args
}

module "addresses" {
  source    = "./addresses"
  parent_id = module.user_index_resources.resource_id
  args      = var.args
}

module "preference" {
  source    = "./preference"
  parent_id = module.user_index_resources.resource_id
  args      = var.args
}
