module "product_topic_detail_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{product_topic_detail_id}"
}

module "reviews" {
  source    = "./reviews"
  parent_id = module.product_topic_detail_id_resources.resource_id
  args      = var.args
}


