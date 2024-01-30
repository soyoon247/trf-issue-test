module "weather-check_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "weather-check"

  method_values = {
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
            "method.response.header.Access-Control-Allow-Methods" = var.args.all_methods
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}

module "point-types" {
  source    = "./point-types"
  parent_id = module.weather-check_resources.resource_id
  args      = var.args
}

module "recommend" {
  source    = "./recommend"
  parent_id = module.weather-check_resources.resource_id
  args      = var.args
}

module "users" {
  source    = "./users"
  parent_id = module.weather-check_resources.resource_id
  args      = var.args
}

module "weather" {
  source    = "./weather"
  parent_id = module.weather-check_resources.resource_id
  args      = var.args
}

