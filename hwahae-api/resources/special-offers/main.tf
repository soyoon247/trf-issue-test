module "special-offers_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "special-offers"

  method_values = {
    GET = {
      method_response_map = {
        200 = {
          response_models = var.args.response_models_empty
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/special-offers"
    }
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Origin,Authorization,Content-Type,Content-Range,Content-Disposition,Content-Description,X-Requested-With,X-ACCESS_TOKEN,X-Amz-Date,X-Api-Key,X-Amz-Security-Token,Hwahae-User-Id,Hwahae-App-Version,Hwahae-Device-Scale,Hwahae-Timestamp,Hwahae-Platform,Hwahae-Signature,Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods" = var.args.all_methods
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}

module "users" {
  source    = "./users"
  parent_id = module.special-offers_resources.resource_id
  args      = var.args
}

module "special_offer_id" {
  source    = "./{special_offer_id}"
  parent_id = module.special-offers_resources.resource_id
  args      = var.args
}


