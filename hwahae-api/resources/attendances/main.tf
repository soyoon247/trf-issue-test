module "attendances_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "attendances"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/attendances"
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
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }

      }
    }
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/attendances"
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

module "coupon" {
  source    = "./coupon"
  parent_id = module.attendances_resources.resource_id
  args      = var.args
}

module "crews" {
  source    = "./crews"
  parent_id = module.attendances_resources.resource_id
  args      = var.args
}

module "push" {
  source    = "./push"
  parent_id = module.attendances_resources.resource_id
  args      = var.args
}

module "users" {
  source    = "./users"
  parent_id = module.attendances_resources.resource_id
  args      = var.args
}




