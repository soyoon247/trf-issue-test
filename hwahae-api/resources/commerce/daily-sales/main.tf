module "daily-sales_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "daily-sales"
}

module "md-picks" {
  source    = "./md-picks"
  parent_id = module.daily-sales_resources.resource_id
  args      = var.args
}

module "home" {
  source    = "./home"
  parent_id = module.daily-sales_resources.resource_id
  args      = var.args
}

module "ai-picks" {
  source    = "./ai-picks"
  parent_id = module.daily-sales_resources.resource_id
  args      = var.args
}

module "scheduled" {
  source    = "./scheduled"
  parent_id = module.daily-sales_resources.resource_id
  args      = var.args
}

module "meta" {
  source    = "./meta"
  parent_id = module.daily-sales_resources.resource_id
  args      = var.args
}
