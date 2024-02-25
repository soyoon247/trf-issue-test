module "daily-sales_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "daily-sales"
}

module "daily_sales_component_id" {
  source    = "./{daily_sales_component_id}"
  parent_id = module.daily-sales_resources.resource_id
  args      = var.args
}
