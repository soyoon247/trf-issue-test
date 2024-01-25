module "comment_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{comment_index}"

  method_values = {
    DELETE = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_request_parameters = {
        "method.request.path.comment_index" = "true"
        "method.request.path.review_index"  = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.response_models_empty
        }
      }
      integration_request_parameters = {
        "integration.request.path.comment_index" = "method.request.path.comment_index"
        "integration.request.path.review_index"  = "method.request.path.review_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/reviews/{review_index}/comments/{comment_index}"
    }
  }
}
