module "predictions_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "predictions"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.query" = "true"
      }
      method_response_map = {
        200 = {}
        400 = {}
        500 = {}
      }
      integration_request_parameters = {
        "integration.request.querystring.query" = "method.request.querystring.query"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SEARCH_SERVER}/$${stageVariables.HWAHAE_SEARCH_SERVER_VERSION}/autocomplete"
      integration_response_map = {
        200 = {}
        400 = {
          selection_pattern = "4\\d{2}"
        }
        500 = {
          selection_pattern = "5\\d{2}"
        }
      }
    }

  }
}


