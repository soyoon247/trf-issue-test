module "id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{id}"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.id" = "true"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
          response_models = {
            "application/json;charset=utf-8" = "GoodsItem"
          }
        }
      }
      integration_request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/shop/goods/{id}"

      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }
  }
}

module "banner" {
  source    = "./banner"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "point_event" {
  source    = "./point_event"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "reviews" {
  source    = "./reviews"
  parent_id = module.id_resources.resource_id
  args      = var.args
}


