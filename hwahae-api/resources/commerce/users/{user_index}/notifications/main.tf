module "notifications_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "notifications"
}

module "daily-sales" {
  source    = "./daily-sales"
  parent_id = module.notifications_resources.resource_id
  args      = var.args
}