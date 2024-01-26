module "nickname_check_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "nickname_check"

  method_values = {
    POST = {
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/nickname_check"
    }
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,Hwahae-User-Id,Hwahae-Device-Id,Hwahae-Platform,Hwahae-App-Version,Hwahae-Device-Scale,Hwahae-Timestamp,Hwahae-Signature,User-Agent'"
            "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}
