module "topic_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{topic_id}"
}

module "goods" {
  source    = "./goods"
  parent_id = module.topic_id_resources.resource_id
  args      = var.args
}

module "brands" {
  source    = "./brands"
  parent_id = module.topic_id_resources.resource_id
  args      = var.args
}
