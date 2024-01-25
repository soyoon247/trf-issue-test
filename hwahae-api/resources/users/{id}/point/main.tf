module "point_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "point"

  common_values = {
    authorization    = var.args.authorization.CUSTOM
    authorizer_id    = var.args.hwahae_authorizer_id_map.hwahae_authorizer
    integration_type = var.args.integration_type.HTTP
  }

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.id"            = "true"
        "method.request.querystring.offset" = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
          response_models = {
            "application/json; charset=utf-8" = "UserPoint"
          }
        }
        500 = {}
      }

      integration_passthrough_behavior = var.args.passthrough_behavior.WHEN_NO_TEMPLATES
      integration_request_parameters = {
        "integration.request.path.id"            = "method.request.path.id"
        "integration.request.querystring.offset" = "method.request.querystring.offset"
      }

      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/point_v2"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
        500 = { selection_pattern : "500" }
      }
    }
    POST = {
      method_request_parameters = {
        "method.request.path.id"                        = "true"
        "method.request.querystring.checkFirstPurchase" = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        },
      }

      integration_request_parameters = {
        "integration.request.path.id"                        = "method.request.path.id"
        "integration.request.querystring.checkFirstPurchase" = "method.request.querystring.checkFirstPurchase"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/point"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }
  }
}
