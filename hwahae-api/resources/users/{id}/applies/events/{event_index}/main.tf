module "event-index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{event_index}"

  common_values = {
    authorization    = var.args.authorization.CUSTOM
    authorizer_id    = var.args.hwahae_authorizer_id_map.hwahae_authorizer
    integration_type = var.args.integration_type.HTTP
    integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/applies/events/{event_index}"
  }
  method_values = {
    DELETE = {
      method_request_parameters = {
        "method.request.path.event_index" = "true"
        "method.request.path.id"          = "true"
      }
      method_response_map = {
        200 = {}
        204 = {}
        400 = {}
        404 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.path.event_index" = "method.request.path.event_index"
        "integration.request.path.id"          = "method.request.path.id"
      }

      integration_response_map = {
        200 = {}
        204 = {
          selection_pattern : "204"
        }
        400 = {
          selection_pattern : "400"
        }
        404 = {
          selection_pattern : "(?!400)(4\\d{2})"
        }
        500 = {
          selection_pattern : "5\\d{2}"
        }
      }
    }

    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-app-version" = "false"
        "method.request.header.hwahae-platform"    = "false"
        "method.request.path.event_index"          = "true"
        "method.request.path.id"                   = "true"
      }

      integration_request_parameters = {
        "integration.request.header.hwahae-app-version" = "method.request.header.hwahae-app-version"
        "integration.request.header.hwahae-platform"    = "method.request.header.hwahae-platform"
        "integration.request.path.event_index"          = "method.request.path.event_index"
        "integration.request.path.id"                   = "method.request.path.id"
      }
    }
  }
}

