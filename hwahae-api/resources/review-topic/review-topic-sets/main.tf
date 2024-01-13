module "review-topic-sets_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "review-topic-sets"

  method_values = {
    GET = {
      authorization       = var.args.authorization.CUSTOM
      authorizer_id       = var.args.hwahae_authorizer_id_map.default
      method_response_map = {}
      integration_uri     = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/review-topic/review-topic-sets"
    }
  }
}



