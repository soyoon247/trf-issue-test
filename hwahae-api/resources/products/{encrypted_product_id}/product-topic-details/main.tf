module "product-topic-details_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "product-topic-details"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer

      method_request_parameters = {
        "method.request.path.encrypted_product_id"  = "true"
        "method.request.querystring.is_positive"    = "false"
        "method.request.querystring.limit"          = "false"
        "method.request.querystring.ordering"       = "false"
        "method.request.querystring.skin_trouble"   = "false"
        "method.request.querystring.skin_type"      = "false"
        "method.request.querystring.user_age_group" = "false"
      }
      method_response_map = {
        200 = {}
        400 = {}
        404 = {}
      }
      integration_request_parameters = {
        "integration.request.path.encrypted_product_id"  = "method.request.path.encrypted_product_id"
        "integration.request.querystring.is_positive"    = "method.request.querystring.is_positive"
        "integration.request.querystring.limit"          = "method.request.querystring.limit"
        "integration.request.querystring.ordering"       = "method.request.querystring.ordering"
        "integration.request.querystring.skin_trouble"   = "method.request.querystring.skin_trouble"
        "integration.request.querystring.skin_type"      = "method.request.querystring.skin_type"
        "integration.request.querystring.user_age_group" = "method.request.querystring.user_age_group"
      }

      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/{encrypted_product_id}/product-topic-details"
      integration_response_map = {
        200 = { selection_pattern = "200" }
        400 = { selection_pattern = "400" }
        404 = { selection_pattern = "404" }
      }

    }
  }
}
