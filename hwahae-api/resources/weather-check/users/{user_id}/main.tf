module "user_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{user_id}"

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

module "location-information-agreement" {
  source    = "./location-information-agreement"
  parent_id = module.user_id_resources.resource_id
  args      = var.args
}

module "message" {
  source    = "./message"
  parent_id = module.user_id_resources.resource_id
  args      = var.args
}

module "rewards" {
  source    = "./rewards"
  parent_id = module.user_id_resources.resource_id
  args      = var.args
}

module "total-point" {
  source    = "./total-point"
  parent_id = module.user_id_resources.resource_id
  args      = var.args
}
