module "info_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "info"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_response_map = {
        200 = { response_models = var.args.response_models_empty }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/info"
    }
    PATCH = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_response_map = {
        200 = {
          response_models = var.args.response_models_empty
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/info"
    }
    PUT = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_response_map = {
        200 = { response_models = var.args.response_models_empty }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me/info"
    }
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,Hwahae-User-Id,Hwahae-Device-Id,Hwahae-Platform,Hwahae-App-Version,Hwahae-Device-Scale,Hwahae-Timestamp,Hwahae-Signature,User-Agent'"
            "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,PATCH'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}
module "photos" {
  source    = "./photos"
  parent_id = module.info_resources.resource_id
  args      = var.args
}

