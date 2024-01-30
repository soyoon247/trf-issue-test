module "event_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{event_index}"

  method_values = {
    GET = {

      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer

      method_request_parameters = {
        "method.request.header.hwahae-app-version" = "false"
        "method.request.header.hwahae-platform"    = "false"
        "method.request.path.event_index"          = "true"
        "method.request.querystring.creative_id"   = "false"
        "method.request.querystring.userId"        = "false"
        "method.request.querystring.viewCount"     = "false"
      }
      integration_request_parameters = {
        "integration.request.path.event_index" = "method.request.path.event_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/events/{event_index}"
    }
  }
}

module "applies" {
  source    = "./applies"
  parent_id = module.event_index_resources.resource_id
  args      = var.args
}


module "comments" {
  source    = "./comments"
  parent_id = module.event_index_resources.resource_id
  args      = var.args
}

module "terms" {
  source    = "./terms"
  parent_id = module.event_index_resources.resource_id
  args      = var.args
}

module "winners" {
  source    = "./winners"
  parent_id = module.event_index_resources.resource_id
  args      = var.args
}
