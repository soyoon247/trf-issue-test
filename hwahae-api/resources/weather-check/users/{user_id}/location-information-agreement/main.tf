module "location-information-agreement_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "location-information-agreement"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_request_parameters = {
        "method.request.path.user_id" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.response_models_empty
        }
      }
      integration_request_parameters = {
        "integration.request.path.user_id" = "method.request.path.user_id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/weather-check/users/{user_id}/location-information-agreement"
    }
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Origin,Authorization,Content-Type,Content-Range,Content-Disposition,Content-Description,X-Requested-With,X-ACCESS_TOKEN,X-Amz-Date,X-Api-Key,X-Amz-Security-Token,Hwahae-User-Id,Hwahae-App-Version,Hwahae-Device-Scale,Hwahae-Timestamp,Hwahae-Platform,Hwahae-Signature,Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods" = var.args.all_methods
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_request_parameters = {
        "method.request.path.user_id" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.response_models_empty
        }
      }
      integration_request_parameters = {
        "integration.request.path.user_id" = "method.request.path.user_id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/weather-check/users/{user_id}/location-information-agreement"
    }
  }
}


