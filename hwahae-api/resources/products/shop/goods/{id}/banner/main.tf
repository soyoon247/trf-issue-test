module "banner_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "banner"
  common_values = {
    method_request_parameters = {
      "method.request.header.hwahae-user-id" = "false"
      "method.request.path.id"               = "true"
    }
  }

  method_values = {
    GET = {
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
      }
      integration_request_parameters = {
        "integration.request.header.hwahae-user-id" = "method.request.header.hwahae-user-id"
        "integration.request.path.id"               = "method.request.path.id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/shop/goods/{id}/banner"
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
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,hwahae-device-scale,hwahae-user-id'"
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}


