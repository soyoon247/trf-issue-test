module "deal-events_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "deal-events"

  method_values = {
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
            "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}

module "popularity" {
  source    = "./popularity"
  parent_id = module.deal-events_resources.resource_id
  args      = var.args
}

module "deal_event_id" {
  source    = "./{deal_event_id}"
  parent_id = module.deal-events_resources.resource_id
  args      = var.args
}

module "plannings" {
  source    = "./plannings"
  parent_id = module.deal-events_resources.resource_id
  args      = var.args
}

module "shopping-tabs" {
  source    = "./shopping-tabs"
  parent_id = module.deal-events_resources.resource_id
  args      = var.args
}
