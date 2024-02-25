module "text_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "text"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.filterQuery"          = "false"
        "method.request.querystring.orderType"            = "false"
        "method.request.querystring.pageNum"              = "false"
        "method.request.querystring.query"                = "true"
        "method.request.querystring.selectedCategoryCode" = "false"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SEARCH_SERVER}/$${stageVariables.HWAHAE_SEARCH_SERVER_VERSION}/product"
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
        500 = {}
      }
    }
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}

module "count" {
  source    = "./count"
  parent_id = module.text_resources.resource_id
  args      = var.args
}

module "filter" {
  source    = "./filters"
  parent_id = module.text_resources.resource_id
  args      = var.args
}

module "meta" {
  source    = "./meta"
  parent_id = module.text_resources.resource_id
  args      = var.args
}


