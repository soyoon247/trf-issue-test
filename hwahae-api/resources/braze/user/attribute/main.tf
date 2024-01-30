module "attribute_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "attribute"

  method_values = {
    OPTIONS = {
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "false"
            "method.response.header.Access-Control-Allow-Origin"  = "false"
          }
        }
      }
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = var.args.all_headers
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }

    POST = {
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "false"
            "method.response.header.Access-Control-Allow-Origin"  = "false"
          }
        }
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/braze/user/attribute"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = var.args.all_headers
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
          response_templates = {
            "application/json" = ""
          }
        }
      }
    }
  }
}
