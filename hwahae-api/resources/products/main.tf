module "products_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "products"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.brand_id"             = "false"
        "method.request.querystring.category_id"          = "false"
        "method.request.querystring.product_attribute_id" = "false"
        "method.request.querystring.review_topic_id"      = "false"
        "method.request.querystring.ordering"             = "false"
        "method.request.querystring.offset"               = "false"
        "method.request.querystring.limit"                = "false"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }

      integration_request_parameters = {
        "integration.request.querystring.brand_id"             = "method.request.querystring.brand_id"
        "integration.request.querystring.category_id"          = "method.request.querystring.category_id"
        "integration.request.querystring.product_attribute_id" = "method.request.querystring.product_attribute_id"
        "integration.request.querystring.review_topic_id"      = "method.request.querystring.review_topic_id"
        "integration.request.querystring.ordering"             = "method.request.querystring.ordering"
        "integration.request.querystring.offset"               = "method.request.querystring.offset"
        "integration.request.querystring.limit"                = "method.request.querystring.limit"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products"
    }
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = var.args.cors_allowed_headers
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}



module "awards" {
  source    = "./awards"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "compare" {
  source    = "./compare"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "favorites" {
  source    = "./favorites"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "foods" {
  source    = "./foods"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "home-product-list" {
  source    = "./home-product-list"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "product-request-update" {
  source    = "./product-request-update"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "product-request-validate" {
  source    = "./product-request-validate"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "review" {
  source    = "./review"
  parent_id = module.products_resources.resource_id
  args      = var.args
}


module "search" {
  source    = "./search"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "shop" {
  source    = "./shop"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "similar-ingredient" {
  source    = "./similar-ingredient"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "similar-ingredient-hints" {
  source    = "./similar-ingredient-hints"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "encrypted_product_id" {
  source    = "./{encrypted_product_id}"
  parent_id = module.products_resources.resource_id
  args      = var.args
}



