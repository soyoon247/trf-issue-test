module "content_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{content_index}"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer

      method_request_parameters = {
        "method.request.header.hwahae-user-id" = "true"
        "method.request.path.content_index"    = "true"
      }
      method_response_map = {
        200 = {}
        401 = {}
        404 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.header.hwahae-user-id" = "method.request.header.hwahae-user-id"
        "integration.request.path.content_index"    = "method.request.path.content_index"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/hwahaeplus/contents/{content_index}"
      integration_response_map = {
        200 = { selection_pattern = "200" }
        401 = { selection_pattern = "401" }
        404 = { selection_pattern = "404" }
        500 = { selection_pattern = "500" }
      }
    }
  }
}



