module "commerce_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "commerce"
}

module "orders" {
  source    = "./orders"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "products" {
  source    = "./products"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "samples" {
  source    = "./samples"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "users" {
  source    = "./users"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "shopping-tabs" {
  source    = "./shopping-tabs"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "goods" {
  source    = "./goods"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "deal-events" {
  source    = "./deal-events"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "asks" {
  source    = "./asks"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "coupons" {
  source    = "./coupons"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "daily-sales" {
  source    = "./daily-sales"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "partner" {
  source    = "./partner"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "sample-top-banners" {
  source    = "./sample-top-banners"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "sample-categories" {
  source    = "./sample-categories"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "search" {
  source    = "./search"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "sample-tabs" {
  source    = "./sample-tabs"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "code" {
  source    = "./code"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "solutionitem" {
  source    = "./solutionitem"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "iamport-notice" {
  source    = "./iamport-notice"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "plannings" {
  source    = "./plannings"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "orderable-goods" {
  source    = "./orderable-goods"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "badges" {
  source    = "./badges"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}

module "brand-halls" {
  source    = "./brand-halls"
  parent_id = module.commerce_resources.resource_id
  args      = var.args
}
