module "search_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "search"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.query" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_passthrough_behavior = var.args.passthrough_behavior.WHEN_NO_TEMPLATES
      integration_request_parameters = {
        "integration.request.querystring.query" = "method.request.querystring.query"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SEARCH_SERVER}/$${stageVariables.HWAHAE_SEARCH_SERVER_VERSION}/integrate"
    }
  }
}

module "banners" {
  source    = "./banners"
  parent_id = module.search_resources.resource_id
  args      = var.args
}

module "brands" {
  source    = "./brands"
  parent_id = module.search_resources.resource_id
  args      = var.args
}

module "goods" {
  source    = "./goods"
  parent_id = module.search_resources.resource_id
  args      = var.args
}

module "products" {
  source    = "./products"
  parent_id = module.search_resources.resource_id
  args      = var.args
}

module "reviews" {
  source    = "./reviews"
  parent_id = module.search_resources.resource_id
  args      = var.args
}
