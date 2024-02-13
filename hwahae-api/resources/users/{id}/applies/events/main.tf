module "events_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "events"

  common_values = {
    authorization   = var.args.authorization.CUSTOM
    authorizer_id   = var.args.hwahae_authorizer_id_map.hwahae_authorizer
    integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/applies/events"
  }
  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-app-version"    = "false"
        "method.request.header.hwahae-platform"       = "false"
        "method.request.path.id"                      = "true"
        "method.request.querystring.currentItemCount" = "false"
        "method.request.querystring.isWon"            = "false"
        "method.request.querystring.limit"            = "false"
      }
      integration_type = var.args.integration_type.HTTP
      integration_request_parameters = {
        "integration.request.header.hwahae-app-version"    = "method.request.header.hwahae-app-version"
        "integration.request.header.hwahae-platform"       = "method.request.header.hwahae-platform"
        "integration.request.path.id"                      = "method.request.path.id"
        "integration.request.querystring.currentItemCount" = "method.request.querystring.currentItemCount"
        "integration.request.querystring.isWon"            = "method.request.querystring.isWon"
        "integration.request.querystring.limit"            = "method.request.querystring.limit"
      }
    }

    POST = {
      method_request_parameters = {
        "method.request.header.Content-Type"       = "false"
        "method.request.header.hwahae-app-version" = "false"
        "method.request.header.hwahae-device-id"   = "false"
        "method.request.header.hwahae-platform"    = "false"
        "method.request.path.id"                   = "true"
      }

      integration_request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
      }

    }

  }
}

module "event_index" {
  source    = "./{event_index}"
  parent_id = module.events_resources.resource_id
  args      = var.args
}


