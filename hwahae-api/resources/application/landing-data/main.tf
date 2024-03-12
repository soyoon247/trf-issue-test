module "landing-data_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "landing-data"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-app-version"    = "true"
        "method.request.header.hwahae-device-scale"   = "true"
        "method.request.header.hwahae-legacy-request" = "false"
        "method.request.header.hwahae-platform"       = "true"
        "method.request.header.hwahae-user-id"        = "false"
        "method.request.querystring.osVersion"        = "false"
      }
      integration_passthrough_behavior = var.args.passthrough_behavior.WHEN_NO_TEMPLATES

      integration_request_parameters = {
        "integration.request.header.hwahae-app-version"    = "method.request.header.hwahae-app-version"
        "integration.request.header.hwahae-device-scale"   = "method.request.header.hwahae-device-scale"
        "integration.request.header.hwahae-legacy-request" = "method.request.header.hwahae-legacy-request"
        "integration.request.header.hwahae-platform"       = "method.request.header.hwahae-platform"
        "integration.request.querystring.appVersion"       = "method.request.header.hwahae-app-version"
        "integration.request.querystring.osVersion"        = "method.request.querystring.osVersion"
        "integration.request.querystring.platform"         = "method.request.header.hwahae-platform"
      }


      integration_request_templates = {
        "application/json" = "#set($HwahaeLegacyRequestOverride = \"1\")\n#set($HwahaeLegacyRequest = $input.params('hwahae-legacy-request'))\n$input.json(\"$\")\n#if($HwahaeLegacyRequest == \"\")\n  #set($context.requestOverride.header.hwahae-legacy-request = $HwahaeLegacyRequestOverride)\n#end"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/status/landing"
    }
  }
}



