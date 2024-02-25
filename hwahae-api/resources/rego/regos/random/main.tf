module "random_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "random"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.querystring.category_id" = "false"
        "method.request.querystring.date"        = "false"
        "method.request.querystring.limit"       = "false"
        "method.request.querystring.offset"      = "false"
      }
      method_response_map = {
        200 = {}
        400 = {}
      }
      integration_request_parameters = {
        "integration.request.querystring.category_id" = "method.request.querystring.category_id"
        "integration.request.querystring.date"        = "method.request.querystring.date"
        "integration.request.querystring.limit"       = "method.request.querystring.limit"
        "integration.request.querystring.offset"      = "method.request.querystring.offset"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/rego/regos/random"
      integration_response_map = {
        200 = {
          selection_pattern = "200"
          response_templates = {
            "application/json" = ""
          }
        }
        400 = { selection_pattern = "400" }
      }
    }
  }
}

