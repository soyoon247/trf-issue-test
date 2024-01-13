module "d_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "d"

  method_values = {
    GET = {
      integration_uri = "https://jsonplaceholder.typicode.com/users/5"
    }
  }
}

module "e" {
  source    = "./e"
  parent_id = module.d_resources.resource_id
  args      = var.args
}
