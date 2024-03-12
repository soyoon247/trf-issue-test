module "users_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "users"
}

module "user_index" {
  source    = "./{user_index}"
  parent_id = module.users_resources.resource_id
  args      = var.args
}

module "me" {
  source    = "./me"
  parent_id = module.users_resources.resource_id
  args      = var.args
}
