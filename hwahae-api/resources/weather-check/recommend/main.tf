module "recommend_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "recommend"
}

module "location_id" {
  source    = "./{location_id}"
  parent_id = module.recommend_resources.resource_id
  args      = var.args
}


