module "reviews_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "reviews"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer

      method_request_parameters = {
        "method.request.header.hwahae-device-scale"   = "false"
        "method.request.header.hwahae-user-id"        = "false"
        "method.request.path.encrypted_product_id"    = "true"
        "method.request.querystring.ageGroup"         = "false"
        "method.request.querystring.currentItemCount" = "false"
        "method.request.querystring.gender"           = "false"
        "method.request.querystring.keywordIndex"     = "false"
        "method.request.querystring.limit"            = "false"
        "method.request.querystring.orderType"        = "false"
        "method.request.querystring.rating"           = "false"
        "method.request.querystring.skinTrouble"      = "false"
        "method.request.querystring.skinType"         = "false"
        "method.request.querystring.userId"           = "false"
      }
      integration_request_parameters = {
        "integration.request.path.encrypted_product_id"      = "method.request.path.encrypted_product_id"
        "integration.request.querystring.encryptedProductId" = "method.request.path.encrypted_product_id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_JSP}/HwaHae3.0/Review/ProductReviewListGetter_3.11.jsp"
    }
  }
}

module "images_resources" {
  source    = "./images"
  parent_id = module.reviews_resources.resource_id
  args      = var.args
}

module "summary_resources" {
  source    = "./summary"
  parent_id = module.reviews_resources.resource_id
  args      = var.args
}


