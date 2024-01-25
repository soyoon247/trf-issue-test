module "auth_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "auth"
}

module "email-validation-check" {
  source    = "./email-validation-check"
  parent_id = module.auth_resources.resource_id
  args      = var.args
}


module "leave" {
  source    = "./leave"
  parent_id = module.auth_resources.resource_id
  args      = var.args
}

module "pw-reset" {
  source    = "./pw-reset"
  parent_id = module.auth_resources.resource_id
  args      = var.args
}

module "pw-reset-email-send" {
  source    = "./pw-reset-email-send"
  parent_id = module.auth_resources.resource_id
  args      = var.args
}

module "signin" {
  source    = "./signin"
  parent_id = module.auth_resources.resource_id
  args      = var.args
}

module "signup" {
  source    = "./signup"
  parent_id = module.auth_resources.resource_id
  args      = var.args
}

module "change-login-type" {
  source    = "./change-login-type"
  parent_id = module.auth_resources.resource_id
  args      = var.args
}

module "send-change-login-type-email" {
  source    = "./send-change-login-type-email"
  parent_id = module.auth_resources.resource_id
  args      = var.args
}

module "token" {
  source    = "./token"
  parent_id = module.auth_resources.resource_id
  args      = var.args
}
