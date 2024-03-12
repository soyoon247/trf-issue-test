module "goods_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "goods"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.category"    = "true"
        "method.request.querystring.topic_group" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/solutionitem/goods"
    }
  }
}

