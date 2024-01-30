module "extra_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "extra"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.id" = "true"
      }
      integration_request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/review/{id}/modify_extra"
    }
  }
}
