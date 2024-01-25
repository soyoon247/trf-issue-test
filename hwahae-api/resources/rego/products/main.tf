module "products_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "products"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_request_parameters = {
        "method.request.querystring.category_id"          = "false"
        "method.request.querystring.has_passing_score"    = "false"
        "method.request.querystring.limit"                = "false"
        "method.request.querystring.offset"               = "false"
        "method.request.querystring.ordering"             = "false"
        "method.request.querystring.product_attribute_id" = "false"
        "method.request.querystring.review_topic_id"      = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
        400 = {}
      }
      integration_request_parameters = {
        "integration.request.querystring.category_id"          = "method.request.querystring.category_id"
        "integration.request.querystring.has_passing_score"    = "method.request.querystring.has_passing_score"
        "integration.request.querystring.limit"                = "method.request.querystring.limit"
        "integration.request.querystring.offset"               = "method.request.querystring.offset"
        "integration.request.querystring.ordering"             = "method.request.querystring.ordering"
        "integration.request.querystring.product_attribute_id" = "method.request.querystring.product_attribute_id"
        "integration.request.querystring.review_topic_id"      = "method.request.multivaluequerystring.review_topic_id"
      }

      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/rego/products"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
          selection_pattern = "200"
        }
        400 = {
          selection_pattern = "400"
        }
      }
    }
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Origin,Authorization,Content-Type,Content-Range,Content-Disposition,Content-Description,X-Requested-With,X-ACCESS_TOKEN,X-Amz-Date,X-Api-Key,X-Amz-Security-Token,Hwahae-User-Id,Hwahae-App-Version,Hwahae-Device-Scale,Hwahae-Timestamp,Hwahae-Platform,Hwahae-Signature,Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}
