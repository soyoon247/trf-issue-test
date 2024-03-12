module "product-topic-details_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "product-topic-details"
}

module "product_topic_detail_id" {
  source    = "./{product_topic_detail_id}"
  parent_id = module.product-topic-details_resources.resource_id
  args      = var.args
}


