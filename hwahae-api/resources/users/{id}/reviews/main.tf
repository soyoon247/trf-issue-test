module "reviews_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "reviews"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.header.hwahae-device-scale"   = "true"
        "method.request.header.hwahae-legacy-request" = "false"
        "method.request.header.hwahae-user-id"        = "false"
        "method.request.path.id"                      = "true"
        "method.request.querystring.currentItemCount" = "false"
        "method.request.querystring.limit"            = "false"
        "method.request.querystring.offset"           = "false"
        "method.request.querystring.orderType"        = "false"
        "method.request.querystring.userId"           = "false"
      }
      method_response_map = {
        200 = {}
        400 = {}
        401 = {}
        404 = {}
        500 = {}
      }
      integration_passthrough_behavior = var.args.passthrough_behavior.WHEN_NO_TEMPLATES
      integration_request_parameters = {
        "integration.request.header.hwahae-device-scale"   = "method.request.header.hwahae-device-scale"
        "integration.request.header.hwahae-legacy-request" = "method.request.header.hwahae-legacy-request"
        "integration.request.header.hwahae-user-id"        = "method.request.header.hwahae-user-id"
        "integration.request.path.id"                      = "method.request.path.id"
        "integration.request.querystring.currentItemCount" = "method.request.querystring.currentItemCount"
        "integration.request.querystring.filterUserId"     = "method.request.path.id"
        "integration.request.querystring.limit"            = "method.request.querystring.limit"
        "integration.request.querystring.offset"           = "method.request.querystring.offset"
        "integration.request.querystring.orderType"        = "method.request.querystring.orderType"
        "integration.request.querystring.userId"           = "method.request.querystring.userId"
      }
      integration_request_templates = {
        "application/json" = "#set($HwahaeLegacyRequestOverride = \"1\")\n#set($HwahaeLegacyRequest = $input.params('hwahae-legacy-request'))\n$input.json(\"$\")\n#if($HwahaeLegacyRequest == \"\")\n  #set($context.requestOverride.header.hwahae-legacy-request = $HwahaeLegacyRequestOverride)\n#end"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/reviews"
      integration_response_map = {
        200 = { selection_pattern : "200" }
        400 = { selection_pattern : "400" }
        401 = { selection_pattern : "401" }
        404 = { selection_pattern : "404" }
        500 = { selection_pattern : "500" }
      }
    }
  }
}
