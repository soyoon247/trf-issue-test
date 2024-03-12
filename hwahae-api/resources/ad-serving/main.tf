module "ad-serving_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "ad-serving"
}

module "internal" {
  source    = "./internal"
  parent_id = module.ad-serving_resources.resource_id
  args      = var.args
}

module "proxy" {
  source    = "./{proxy+}"
  parent_id = module.ad-serving_resources.resource_id
  args      = var.args
}
