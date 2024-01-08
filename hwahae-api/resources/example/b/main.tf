module "b_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "0.0.1"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "b"
}


module "c_module" {
  source      = "./c"
  parent_id   = module.b_resources.resource_id
  args = var.args
}
