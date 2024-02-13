module "images_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "images"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-device-scale" = "false"
        "method.request.header.hwahae-user-id"      = "false"
        "method.request.path.encrypted_product_id"  = "true"
        "method.request.querystring.limit"          = "false"
        "method.request.querystring.order"          = "false"
        "method.request.querystring.type"           = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
      }
      integration_request_parameters = {
        "integration.request.path.encrypted_product_id" = "method.request.path.encrypted_product_id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/{encrypted_product_id}/reviews/images"
    }
    OPTIONS = {
      method_request_parameters = {
        "method.request.path.encrypted_product_id" = "true"
      }
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

module "before-after_resources" {
  source    = "./before-after"
  parent_id = module.images_resources.resource_id
  args      = var.args
}


