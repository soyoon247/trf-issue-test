module "sale_goods_resources" {
  source      = "app.terraform.io/sy_trf_test/api-gateway-modules-test/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "sale_goods"

  method_values = {
    GET = {
      ##############################################

      ##############################################
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
            "method.response.header.Set-Cookie"                  = "false"
          }
        }
      }
      integration_uri = "http://naver.com"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
            "method.response.header.Set-Cookie"                  = "integration.response.header.Set-Cookie"
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
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}

