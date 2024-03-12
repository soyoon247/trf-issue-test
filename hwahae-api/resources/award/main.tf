module "award_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "award"
}

module "list" {
  source    = "./list"
  parent_id = module.award_resources.resource_id
  args      = var.args
}

module "award_id" {
  source    = "./{award_id}"
  parent_id = module.award_resources.resource_id
  args      = var.args
}






