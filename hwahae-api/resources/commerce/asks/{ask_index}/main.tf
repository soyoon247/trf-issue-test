module "ask_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{ask_index}"

  method_values = {
    DELETE = {
      authorization         = var.args.authorization.CUSTOM
      authorizer_id         = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_operation_name = "deleteQnaBoardItem"
      method_request_parameters = {
        "method.request.path.ask_index" = "true"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
        400 = {}
        404 = {
          response_models = {
            "application/json" = "Error"
          }
        }
        409 = {}
      }
      integration_request_parameters = {
        "integration.request.path.ask_index" = "method.request.path.ask_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/asks/{ask_index}"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }

    GET = {
      authorization         = var.args.authorization.CUSTOM
      authorizer_id         = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_operation_name = "getQnaBoardItem"
      method_request_parameters = {
        "method.request.path.ask_index" = "true"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
        404 = {
          response_models = {
            "application/json" = "Error"
          }
        }
      }
      integration_request_parameters = {
        "integration.request.path.ask_index" = "method.request.path.ask_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/asks/{ask_index}"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }

    OPTIONS = {
      method_response_map = {
        200 = {
          response_parameters = var.args.option_method_response_parameters
        }
      }
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Origin, Authorization, Content-Type, Content-Range, Content-Disposition, Content-Description, X-Requested-With, X-ACCESS_TOKEN, X-Amz-Date, X-Api-Key, X-Amz-Security-Token, Hwahae-User-Id, Hwahae-App-Version, Hwahae-Device-Scale, Hwahae-Timestamp, Hwahae-Platform, Hwahae-Signature, Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,OPTIONS,PUT'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }

    PUT = {
      authorization         = var.args.authorization.CUSTOM
      authorizer_id         = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_operation_name = "updateQnaBoardItem"
      method_request_parameters = {
        "method.request.path.ask_index" = "true"
      }

      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
        400 = {
          response_models = {
            "application/json" = "Error"
          }
        }
        404 = {}
        409 = {}
      }
      integration_request_parameters = {
        "integration.request.path.ask_index" = "method.request.path.ask_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/asks/{ask_index}"
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
