module "stats_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "stats"

  method_values = {
    GET = {
      method_response_map = {
        200 = {
          response_models = var.args.response_models_empty
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/makeup/coupon-codes/stats"
    }
    OPTIONS = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,Hwahae-User-Id,Hwahae-App-Version,Hwahae-Device-Scale,Hwahae-Timestamp,Hwahae-Platform,Hwahae-Signature,Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods" = var.args.all_methods
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin

          }
        }
      }
    }
  }
}


