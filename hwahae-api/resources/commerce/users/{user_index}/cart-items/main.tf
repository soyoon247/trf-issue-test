module "cart-items_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "cart-items"

  method_values = {
    DELETE = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.user_index"             = "true"
        "method.request.querystring.cart_index_list" = "false"
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
        404 = {
          response_models = {
            "application/json" = "Error"
          }
        }
      }
      integration_request_parameters = {
        "integration.request.path.user_index" = "method.request.path.user_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/users/{user_index}/cart-items"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }

    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.user_index"           = "true"
        "method.request.querystring.checked_items" = "false"
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
        "integration.request.path.user_index" = "method.request.path.user_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/users/{user_index}/cart-items"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }

    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Origin, Authorization, Content-Type, Content-Range, Content-Disposition, Content-Description, X-Requested-With, X-ACCESS_TOKEN, X-Amz-Date, X-Api-Key, X-Amz-Security-Token, Hwahae-User-Id, Hwahae-App-Version, Hwahae-Device-Scale, Hwahae-Timestamp, Hwahae-Platform, Hwahae-Signature, Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,OPTIONS,POST'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }

    POST = {
      authorization         = var.args.authorization.CUSTOM
      authorizer_id         = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_operation_name = "addGoodsToCart"
      method_request_parameters = {
        "method.request.path.user_index"     = "true"
        "method.request.querystring.force"   = "false"
        "method.request.querystring.is_temp" = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
      }
      integration_request_parameters = {
        "integration.request.path.user_index" = "method.request.path.user_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/users/{user_index}/cart-items"
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

module "cart_index" {
  source    = "./{cart_index}"
  parent_id = module.cart-items_resources.resource_id
  args      = var.args
}


