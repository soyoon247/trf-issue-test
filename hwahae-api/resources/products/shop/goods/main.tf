module "goods_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "goods"

  method_values = {
    OPTIONS = {
      method_request_parameters = {
        "method.request.header.hwahae-app-version" = "false"
        "method.request.header.hwahae-platform"    = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = var.args.option_method_response_parameters
        }
      }

      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,hwahae-device-scale,hwahae-app-version,hwahae-platform'"
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }

    }
  }
}

module "id" {
  source    = "./{id}"
  parent_id = module.goods_resources.resource_id
  args      = var.args
}


