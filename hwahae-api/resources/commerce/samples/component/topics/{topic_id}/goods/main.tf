module "goods_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "goods"
}

module "sale_goods_id" {
  source    = "./{sale_goods_id}"
  parent_id = module.goods_resources.resource_id
  args      = var.args
}
