module "e_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "e"

  method_values = {
    GET = {
      integration_uri = "https://jsonplaceholder.typicode.com/users/6"
    }
  }
}
