module "event_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{event_index}"

  method_values = {
    GET = {
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
      }
      method_request_parameters = {
        "method.request.path.event_index" = "true"
      }
      integration_request_parameters = {
        "integration.request.path.event_index" = "method.request.path.event_index"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/plannings/{event_index}"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }

    OPTIONS = {
      method_response_map = {
        200 = {
          response_parameters = var.args.option_method_response_parameters
        }
      }
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
        } }
      }
    }
  }
}

module "informations" {
  source    = "./informations"
  parent_id = module.event_index_resources.resource_id
  args      = var.args
}

module "products" {
  source    = "./products"
  parent_id = module.event_index_resources.resource_id
  args      = var.args
}

module "relations" {
  source    = "./relations"
  parent_id = module.event_index_resources.resource_id
  args      = var.args
}

