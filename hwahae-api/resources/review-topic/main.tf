module "review-topic_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "review-topic"
}

module "product-topic-detail" {
  source    = "./product-topic-details"
  parent_id = module.review-topic_resources.resource_id
  args      = var.args
}

module "product-topics" {
  source    = "./product-topics"
  parent_id = module.review-topic_resources.resource_id
  args      = var.args
}

module "review-topic-filters" {
  source    = "./review-topic-filters"
  parent_id = module.review-topic_resources.resource_id
  args      = var.args
}

module "review-topic-sets" {
  source    = "./review-topic-sets"
  parent_id = module.review-topic_resources.resource_id
  args      = var.args
}

