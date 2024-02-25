module "order_code_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{order_code}"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.order_code" = "true"
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
        "integration.request.path.order_code" = "method.request.path.order_code"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/orders/{order_code}"
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
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}

module "return" {
  source    = "./return"
  parent_id = module.order_code_resources.resource_id
  args      = var.args
}

module "send-notice" {
  source    = "./send-notice"
  parent_id = module.order_code_resources.resource_id
  args      = var.args
}

module "cancel" {
  source    = "./cancel"
  parent_id = module.order_code_resources.resource_id
  args      = var.args
}

module "item" {
  source    = "./item"
  parent_id = module.order_code_resources.resource_id
  args      = var.args
}

module "pay-complete" {
  source    = "./pay-complete"
  parent_id = module.order_code_resources.resource_id
  args      = var.args
}

module "pay-status" {
  source    = "./pay-status"
  parent_id = module.order_code_resources.resource_id
  args      = var.args
}

module "exchange" {
  source    = "./exchange"
  parent_id = module.order_code_resources.resource_id
  args      = var.args
}

module "pay-queue" {
  source    = "./pay-queue"
  parent_id = module.order_code_resources.resource_id
  args      = var.args
}
