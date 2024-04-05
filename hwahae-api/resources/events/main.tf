module "events_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "events"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.Cookie"                = "false"
        "method.request.header.hwahae-app-version"    = "false"
        "method.request.header.hwahae-platform"       = "false"
        "method.request.querystring.categoryIndex"    = "false"
        "method.request.querystring.currentItemCount" = "false"
        "method.request.querystring.limit"            = "false"
        "method.request.querystring.listType"         = "false"
        "method.request.querystring.userId"           = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Set-Cookie" = "false"
          }
        }
        400 = {}
        404 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.header.Cookie"                = "method.request.header.Cookie"
        "integration.request.header.hwahae-app-version"    = "method.request.header.hwahae-app-version"
        "integration.request.header.hwahae-platform"       = "method.request.header.hwahae-platform"
        "integration.request.querystring.categoryIndex"    = "method.request.querystring.categoryIndex"
        "integration.request.querystring.currentItemCount" = "method.request.querystring.currentItemCount"
        "integration.request.querystring.limit"            = "method.request.querystring.limit"
        "integration.request.querystring.listType"         = "method.request.querystring.listType"
        "integration.request.querystring.userId"           = "method.request.querystring.userId"
      }

      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/events"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Set-Cookie" = "integration.response.header.Set-Cookie"
          }
        }
        400 = { selection_pattern = "400" }
        404 = { selection_pattern = "(?!400)(4\\d{2})" }
        500 = { selection_pattern = "500"
        }
      }

    }
  }
}

module "categories" {
  source    = "./categories"
  parent_id = module.events_resources.resource_id
  args      = var.args
}

module "first-purchase-info" {
  source    = "./first-purchase-info"
  parent_id = module.events_resources.resource_id
  args      = var.args
}
module "event_index" {
  source    = "./{event_index}"
  parent_id = module.events_resources.resource_id
  args      = var.args
}
