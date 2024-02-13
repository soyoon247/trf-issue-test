module "contents_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "contents"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-app-version"    = "false"
        "method.request.header.hwahae-platform"       = "false"
        "method.request.querystring.currentItemCount" = "false"
        "method.request.querystring.editorIndex"      = "false"
        "method.request.querystring.themeIndex"       = "false"
      }
      method_response_map = {
        200 = {}
        400 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.header.hwahae-app-version"    = "method.request.header.hwahae-app-version"
        "integration.request.header.hwahae-platform"       = "method.request.header.hwahae-platform"
        "integration.request.querystring.currentItemCount" = "method.request.querystring.currentItemCount"
        "integration.request.querystring.editorIndex"      = "method.request.querystring.editorIndex"
        "integration.request.querystring.themeIndex"       = "method.request.querystring.themeIndex"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/hwahaeplus/contents"
      integration_response_map = {
        200 = { selection_pattern = "200" }
        400 = { selection_pattern = "400" }
        500 = { selection_pattern = "500" }
      }

    }
  }
}

module "content_index_resources" {
  source    = "./{content_index}"
  parent_id = module.contents_resources.resource_id
  args      = var.args
}


