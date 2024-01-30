module "review_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "review"
}

module "check" {
  source    = "./check"
  parent_id = module.review_resources.resource_id
  args      = var.args
}

module "guide" {
  source    = "./guide"
  parent_id = module.review_resources.resource_id
  args      = var.args
}
module "write" {
  source    = "./write"
  parent_id = module.review_resources.resource_id
  args      = var.args
}

module "id" {
  source    = "./{id}"
  parent_id = module.review_resources.resource_id
  args      = var.args
}
