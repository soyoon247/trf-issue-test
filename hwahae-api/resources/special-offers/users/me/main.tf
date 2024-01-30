module "me_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "me"
}

module "check-crew-member-type" {
  source    = "./check-crew-member-type"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "special-offer-crews" {
  source    = "./special-offer-crews"
  parent_id = module.me_resources.resource_id
  args      = var.args
}


