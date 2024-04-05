module "partner_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "partner"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.Accept"    = "false"
        "method.request.querystring.type" = "false"
      }
      method_response_map = {
        200 = {
          response_models = {
            "text/html" = "Empty"
          }
        }
      }
      integration_request_parameters = {
        "integration.request.header.Accept"    = "method.request.header.Accept"
        "integration.request.querystring.type" = "method.request.querystring.type"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/partner"
      integration_response_map = {
        200 = {}
      }
    }
  }
}

module "partner_id" {
  source    = "./{partner_id}"
  parent_id = module.partner_resources.resource_id
  args      = var.args
}

module "brands" {
  source    = "./brands"
  parent_id = module.partner_resources.resource_id
  args      = var.args
}
