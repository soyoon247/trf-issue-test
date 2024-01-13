module "pigment-image-review-requests_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "pigment-image-review-requests"
}

module "me" {
  source    = "./me"
  parent_id = module.pigment-image-review-requests_resources.resource_id
  args      = var.args
}

module "move-product" {
  source    = "./move-product"
  parent_id = module.pigment-image-review-requests_resources.resource_id
  args      = var.args
}

module "id" {
  source    = "./{id}"
  parent_id = module.pigment-image-review-requests_resources.resource_id
  args      = var.args
}



