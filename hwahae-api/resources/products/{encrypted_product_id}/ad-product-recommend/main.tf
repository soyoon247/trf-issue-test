module "ad-product-recommend_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "ad-product-recommend"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-platform"    = "false"
        "method.request.path.encrypted_product_id" = "true"
        "method.request.querystring.testType"      = "false"
      }

      method_response_map = {
        200 = {}
        404 = {}
      }
      integration_request_parameters = {
        "integration.request.header.hwahae-platform"    = "method.request.header.hwahae-platform"
        "integration.request.path.encrypted_product_id" = "method.request.path.encrypted_product_id"
        "integration.request.querystring.testType"      = "method.request.querystring.testType"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/{encrypted_product_id}/ad-product-recommend"
      integration_response_map = {
        200 = {}
        404 = { selection_pattern = "404" }
      }
    }
  }
}



