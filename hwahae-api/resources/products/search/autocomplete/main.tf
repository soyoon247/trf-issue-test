module "autocomplete_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "autocomplete"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.keyword" = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
          response_models = {
            "application/json; charset=utf-8" = "AutoComplete"
          }
        }
        400 = {}
        500 = {}
      }
      integration_request_parameters = {
        "integration.request.querystring.keyword" = "method.request.querystring.keyword"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/search/autocomplete"


      integration_response_map = {
        200 = {
          selection_pattern = "200"
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
        400 = { selection_pattern = "400" }
        500 = { selection_pattern = "500" }
      }
    }
  }
}

