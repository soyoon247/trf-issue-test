module "giveaway-records_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "giveaway-records"

  method_values = {
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/makeup/giveaway-records"
    }
  }
}

module "event" {
  source    = "./event"
  parent_id = module.giveaway-records_resources.resource_id
  args      = var.args
}

module "me" {
  source    = "./me"
  parent_id = module.giveaway-records_resources.resource_id
  args      = var.args
}

module "validate" {
  source    = "./validate"
  parent_id = module.giveaway-records_resources.resource_id
  args      = var.args
}

module "makeup_giveaway_record_id" {
  source    = "./{makeup_giveaway_record_id}"
  parent_id = module.giveaway-records_resources.resource_id
  args      = var.args
}

