module "relation-goods_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "relation-goods"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.goods_index" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.goods_index" = "method.request.path.goods_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/$${stageVariables.HWAHAE_COMMERCE_SERVER_VERSION}/goods/{goods_index}/relation-goods"
      integration_response_map = {
        200 = {}
      }
    }
  }
}
