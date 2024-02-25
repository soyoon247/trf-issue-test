module "blocks_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{block_id}"

  method_values = {
    DELETE = {
      method_request_parameters = {
        "method.request.header.hwahae-user-id" = "false"
        "method.request.path.block_id"         = "true"
        "method.request.path.id"               = "true"
      }
      method_response_map = {
        200 = {}
        400 = {}
        401 = {}
        404 = {}
        409 = {}
      }

      integration_request_parameters = {
        "integration.request.header.hwahae-user-id" = "method.request.header.hwahae-user-id"
        "integration.request.path.block_id"         = "method.request.path.block_id"
        "integration.request.path.id"               = "method.request.path.id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/blocks/{block_id}"
      integration_response_map = {
        200 = { selection_pattern : "200" }
        400 = { selection_pattern : "400" }
        401 = { selection_pattern : "401" }
        404 = { selection_pattern : "404" }
        409 = { selection_pattern : "409" }
      }
    }
  }
}
