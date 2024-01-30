module "subscriptions_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "subscriptions"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.id" = "true"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          },
        }
        400 = {}
        404 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/push/subscriptions"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
          selection_pattern : "200"
        }
        400 = { selection_pattern : "400" }
        404 = { selection_pattern : "404" }
        500 = {
          "selection_pattern" = "5\\d{2}"
        }
      }
    }

    OPTIONS = {
      method_request_parameters = {
        "method.request.path.id" = "true"
      }
      method_response_map = {
        200 = {
          response_parameters = var.args.option_method_response_parameters,
          response_models     = var.args.empty_response_models
        },
      }

      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Origin, Authorization, Content-Type, Content-Range, Content-Disposition, Content-Description, X-Requested-With, X-ACCESS_TOKEN, X-Amz-Date, X-Api-Key, X-Amz-Security-Token, Hwahae-User-Id, Hwahae-App-Version, Hwahae-Device-Scale, Hwahae-Timestamp, Hwahae-Platform, Hwahae-Signature, Hwahae-Device-Id, Hwahae-Session-Id'"
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        },
      }
    }

    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.header.hwahae-platform" = "false"
        "method.request.path.id"                = "true"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        },
        400 = {}
        404 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.header.hwahae-platform" = "method.request.header.hwahae-platform"
        "integration.request.path.id"                = "method.request.path.id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/push/subscriptions"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          },
          selection_pattern : "200"
        }
        400 = { selection_pattern : "400" }
        404 = { selection_pattern : "404" }
        500 = { selection_pattern : "5\\d{2}" }
      }
    }
  }
}

module "marketing" {
  source    = "./marketing"
  parent_id = module.subscriptions_resources.resource_id
  args      = var.args
}

module "migrate" {
  source    = "./migrate"
  parent_id = module.subscriptions_resources.resource_id
  args      = var.args
}
