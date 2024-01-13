module "reviews_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "reviews"
}

module "summary" {
  source    = "./summary"
  parent_id = module.reviews_resources.resource_id
  args      = var.args
}


