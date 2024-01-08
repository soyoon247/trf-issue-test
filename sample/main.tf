module "example_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "0.0.1"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "example"
}

module "b" {
  source    = "./b"
  parent_id = module.example_resources.resource_id
  args      = var.args
}
