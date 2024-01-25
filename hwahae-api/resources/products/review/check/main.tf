module "check_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "check"

  method_values = {
    GET = {

      method_request_parameters = {
        "method.request.querystring.encryptedProductId" = "true"
        "method.request.querystring.userId"             = "true"
      }
      integration_request_parameters = {
        "integration.request.querystring.encryptedProductId" = "method.request.querystring.encryptedProductId"
        "integration.request.querystring.userId"             = "method.request.querystring.userId"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/review/review_check"

    }
  }
}


