module "blocks_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "blocks"

  method_values = {
    GET = {
      method_response_map = {
        200 = {}
        400 = {}
        401 = {}
        409 = {}
      }
      integration_response_map = {
        200 = { selection_pattern : "200" }
        400 = { selection_pattern : "400" }
        401 = { selection_pattern : "401" }
        409 = { selection_pattern : "409" }
      }
    }
    POST = {
      method_response_map = {
        200 = {}
        201 = {}
        400 = {}
        401 = {}
        409 = {}
      }
      integration_response_map = {
        200 = { selection_pattern : "200" }
        201 = { selection_pattern : "201" }
        400 = { selection_pattern : "400" }
        401 = { selection_pattern : "401" }
        409 = { selection_pattern : "409" }
      }
    }
  }

  common_values = {
    authorization = var.args.authorization.CUSTOM
    authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
    method_request_parameters = {
      "method.request.header.hwahae-user-id" : "false"
      "method.request.path.id" : "true"
    }
    integration_request_parameters = {
      "integration.request.header.hwahae-user-id" : "method.request.header.hwahae-user-id"
      "integration.request.path.id" : "method.request.path.id"
    }
    integration_type = var.args.integration_type.HTTP
    integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/blocks"
  }
}


module "block_id" {
  source    = "./{block_id}"
  parent_id = module.blocks_resources.resource_id
  args      = var.args
}
