module "search_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "search"

  method_values = {
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,Hwahae-User-Id,Hwahae-App-Version,Hwahae-Device-Scale,Hwahae-Timestamp,Hwahae-Platform,Hwahae-Signature,Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }


    }
    POST = {
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
      }
      integration_uri = "https://similar-product-api.hwahae.co.kr/makeup/similar-products/search"
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

module "search_id" {
  source    = "./{search_id}"
  parent_id = module.search_resources.resource_id
  args      = var.args
}


