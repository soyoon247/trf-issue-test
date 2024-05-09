module "brand-halls_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "brand-halls"
}

module "deal-events" {
  source    = "./deal-events"
  parent_id = module.brand-halls_resources.resource_id
  args      = var.args
}

module "coupons" {
  source    = "./coupons"
  parent_id = module.brand-halls_resources.resource_id
  args      = var.args
}

module "samples" {
  source    = "./samples"
  parent_id = module.brand-halls_resources.resource_id
  args      = var.args
}

module "best-goods" {
  source    = "./best-goods"
  parent_id = module.brand-halls_resources.resource_id
  args      = var.args
}
