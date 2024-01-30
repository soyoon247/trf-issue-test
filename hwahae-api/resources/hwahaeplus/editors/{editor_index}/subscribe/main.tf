module "subscribe_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "subscribe"

  method_values = {
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer

      method_request_parameters = {
        "method.request.header.hwahae-user-id" = "true"
        "method.request.path.editor_index"     = "true"
      }
      method_response_map = {
        200 = {}
        401 = {}
        404 = {}
        500 = {}
      }
      integration_request_parameters = {
        "integration.request.header.hwahae-user-id" = "method.request.header.hwahae-user-id"
        "integration.request.path.editor_index"     = "method.request.path.editor_index"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/hwahaeplus/editors/{editor_index}/subscribe"
      integration_response_map = {
        200 = { selection_pattern = "200" }
        401 = { selection_pattern = "401" }
        404 = { selection_pattern = "404" }
        500 = { selection_pattern = "500" }
      }
    }
  }
}


