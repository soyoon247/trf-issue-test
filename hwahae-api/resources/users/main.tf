module "users_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "users"
}

module "me" {
  source    = "./me"
  parent_id = module.users_resources.resource_id
  args      = var.args
}

module "nickname" {
  source    = "./nickname"
  parent_id = module.users_resources.resource_id
  args      = var.args
}

module "nickname_check" {
  source    = "./nickname_check"
  parent_id = module.users_resources.resource_id
  args      = var.args
}

module "profile_info" {
  source    = "./profile-info"
  parent_id = module.users_resources.resource_id
  args      = var.args
}

module "register_confirm" {
  source    = "./register-confirm"
  parent_id = module.users_resources.resource_id
  args      = var.args
}

module "sign" {
  source    = "./sign"
  parent_id = module.users_resources.resource_id
  args      = var.args
}

module "id" {
  source    = "./{id}"
  parent_id = module.users_resources.resource_id
  args      = var.args
}

