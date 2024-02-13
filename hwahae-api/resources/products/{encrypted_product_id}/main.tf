module "encrypted_product_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{encrypted_product_id}"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-user-id"     = "true"
        "method.request.path.encrypted_product_id" = "true"
      }

      method_response_map = {
        200 = {}
        400 = {}
        500 = {}
      }
      integration_passthrough_behavior = var.args.passthrough_behavior.WHEN_NO_TEMPLATES

      integration_request_parameters = {
        "integration.request.header.hwahae-user-id"     = "method.request.header.hwahae-user-id"
        "integration.request.path.encrypted_product_id" = "method.request.path.encrypted_product_id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/{encrypted_product_id}"
      integration_response_map = {
        200 = {}
        400 = { selection_pattern = "4\\d{2}" }
        500 = { selection_pattern = "5\\d{2}" }
      }
    }
  }
}
module "ad-product-recommend" {
  source    = "./ad-product-recommend"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "award-history" {
  source    = "./award-history"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "buyable" {
  source    = "./buyable"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "corrections" {
  source    = "./corrections"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "favorite" {
  source    = "./favorite"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "food-material-functional-info" {
  source    = "./food-material-functional-info"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "ingredient-info" {
  source    = "./ingredient-info"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "product-topic-details" {
  source    = "./product-topic-details"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "product-topics" {
  source    = "./product-topics"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "related-products" {
  source    = "./related-products"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}

module "reviews" {
  source    = "./reviews"
  parent_id = module.encrypted_product_id_resources.resource_id
  args      = var.args
}




