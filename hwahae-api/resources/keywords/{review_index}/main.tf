module "review_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{review_index}"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.review_index" = "true"
      }
      integration_request_parameters = {
        "integration.request.path.review_index" = "method.request.path.review_index"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/keywords/{review_index}"
    }
  }
}
