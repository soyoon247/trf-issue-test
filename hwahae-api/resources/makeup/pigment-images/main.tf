module "pigment-images_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "pigment-images"

  method_values = {
    GET = {
      method_response_map = {}
      integration_uri     = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/makeup/pigment-images"
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
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_response_map = {
        200 = {
          response_models = var.args.response_models_empty
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/makeup/pigment-images"
    }
  }
}

module "best-images" {
  source    = "./best-images"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "categories" {
  source    = "./categories"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "config" {
  source    = "./config"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "preview" {
  source    = "./preview"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "promotion-texts" {
  source    = "./promotion-texts"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "shade" {
  source    = "./shades"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "similar-color-products" {
  source    = "./similar-color-products"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "skin-tones" {
  source    = "./skin-tones"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "stats" {
  source    = "./stats"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "subscriptions" {
  source    = "./subscriptions"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "summary" {
  source    = "./summary"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "validate" {
  source    = "./validate"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}

module "write-guide" {
  source    = "./write-guide"
  parent_id = module.pigment-images_resources.resource_id
  args      = var.args
}
