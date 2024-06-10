module "sale_goods_resources" {
  source      = "app.terraform.io/sy_trf_test/api-gateway-modules-test/aws"
  version     = "1.0.19"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "sale_goods"

  method_values = {
    GET = {
      ##############################################
      method_request_parameters = {
        "method.request.header.Cookie"                      = "false"
        "method.request.header.hwahae-user-id"              = "false"
        "method.request.querystring.category_code"          = "false"
        "method.request.querystring.current_item_count"     = "false"
        "method.request.querystring.is_discounted"          = "false"
        "method.request.querystring.is_limited_price_badge" = "false"
        "method.request.querystring.is_only_hwahae"         = "false"
        "method.request.querystring.is_soldout"             = "false"
        "method.request.querystring.is_square_image"        = "false"
        "method.request.querystring.limit"                  = "false"
        "method.request.querystring.partner_index"          = "false"
        "method.request.querystring.product_index"          = "false"
        "method.request.querystring.sort"                   = "false"
        "method.request.querystring.product_attribute_id"   = "false"
      }
      integration_request_parameters = {
        "integration.request.header.Cookie"                      = "method.request.header.Cookie"
        "integration.request.header.hwahae-user-id"              = "method.request.header.hwahae-user-id"
        "integration.request.querystring.category_code"          = "method.request.querystring.category_code"
        "integration.request.querystring.current_item_count"     = "method.request.querystring.current_item_count"
        "integration.request.querystring.is_discounted"          = "method.request.querystring.is_discounted"
        "integration.request.querystring.is_limited_price_badge" = "method.request.querystring.is_limited_price_badge"
        "integration.request.querystring.is_only_hwahae"         = "method.request.querystring.is_only_hwahae"
        "integration.request.querystring.is_soldout"             = "method.request.querystring.is_soldout"
        "integration.request.querystring.is_square_image"        = "method.request.querystring.is_square_image"
        "integration.request.querystring.limit"                  = "method.request.querystring.limit"
        "integration.request.querystring.partner_index"          = "method.request.querystring.partner_index"
        "integration.request.querystring.product_index"          = "method.request.querystring.product_index"
        "integration.request.querystring.sort"                   = "method.request.querystring.sort"
        "integration.request.querystring.product_attribute_id"   = "method.request.querystring.product_attribute_id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
            "method.response.header.Set-Cookie"                  = "integration.response.header.Set-Cookie"
          }
        }
      }
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


    }
#    OPTIONS = {
#      method_response_map = {
#        200 = {
#          response_parameters = var.args.option_method_response_parameters
#        }
#      }
#      integration_response_map = {
#        200 = {
#          response_parameters = {
#            "method.response.header.Access-Control-Allow-Headers" = "'Origin, Authorization, Content-Type, Content-Range, Content-Disposition, Content-Description, X-Requested-With, X-ACCESS_TOKEN, X-Amz-Date, X-Api-Key, X-Amz-Security-Token, Hwahae-User-Id, Hwahae-App-Version, Hwahae-Device-Scale, Hwahae-Timestamp, Hwahae-Platform, Hwahae-Signature, Hwahae-Device-Id'"
#            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
#            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
#          }
#        }
#      }
#    }
  }
}

