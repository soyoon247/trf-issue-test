module "goods_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{goods_index}"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.goods_index" = "true"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.goods_index" = "method.request.path.goods_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/$${stageVariables.HWAHAE_COMMERCE_SERVER_VERSION}/goods/{goods_index}"
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
          response_parameters = {
            "method.response.header.Access-Control-Allow-Credentials" = "false"
            "method.response.header.Access-Control-Allow-Headers"     = "false"
            "method.response.header.Access-Control-Allow-Methods"     = "false"
            "method.response.header.Access-Control-Allow-Origin"      = "false"
          }
          response_models = var.args.empty_response_models
        }
      }
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Credentials" = "'true'"
            "method.response.header.Access-Control-Allow-Headers"     = "'Origin, Authorization, Content-Type, Content-Range, Content-Disposition, Content-Description, X-Requested-With, X-ACCESS_TOKEN, X-Amz-Date, X-Api-Key, X-Amz-Security-Token, Hwahae-User-Id, Hwahae-App-Version, Hwahae-Device-Scale, Hwahae-Timestamp, Hwahae-Platform, Hwahae-Signature, Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods"     = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"      = var.args.all_origin
          }
        }
      }
    }
  }
}

module "return-guide" {
  source    = "./return-guide"
  parent_id = module.goods_index_resources.resource_id
  args      = var.args
}

module "asks" {
  source    = "./asks"
  parent_id = module.goods_index_resources.resource_id
  args      = var.args
}

module "maximum-benefits" {
  source    = "./maximum-benefits"
  parent_id = module.goods_index_resources.resource_id
  args      = var.args
}

module "options" {
  source    = "./options"
  parent_id = module.goods_index_resources.resource_id
  args      = var.args
}

module "information-provision-notice" {
  source    = "./information-provision-notice"
  parent_id = module.goods_index_resources.resource_id
  args      = var.args
}

module "relation-goods" {
  source    = "./relation-goods"
  parent_id = module.goods_index_resources.resource_id
  args      = var.args
}

module "products" {
  source    = "./products"
  parent_id = module.goods_index_resources.resource_id
  args      = var.args
}
