module "samples_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "samples"

  method_values = {
    GET = {
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/samples"
      integration_response_map = {
        200 = {}
      }
    }

    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
            "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}


module "component" {
  source    = "./component"
  parent_id = module.samples_resources.resource_id
  args      = var.args
}

module "extra-topics" {
  source    = "./extra-topics"
  parent_id = module.samples_resources.resource_id
  args      = var.args
}

module "sale_goods_id" {
  source    = "./{sale_goods_id}"
  parent_id = module.samples_resources.resource_id
  args      = var.args
}
