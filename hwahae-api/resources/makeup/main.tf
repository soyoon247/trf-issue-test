module "makeup_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "makeup"
}

module "collections" {
  source    = "./collections"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "coupon_codes" {
  source    = "./coupon-codes"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "giveaway_records" {
  source    = "./giveaway-records"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "makeuplab" {
  source    = "./makeuplab"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "peer_votes" {
  source    = "./peer-votes"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "pigment_image_review_requests" {
  source    = "./pigment-image-review-requests"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "pigment_images" {
  source    = "./pigment-images"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "pigment_review_collections" {
  source    = "./pigment-review-collections"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "product_categories" {
  source    = "./product-categories"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "search" {
  source    = "./search"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "similar_products" {
  source    = "./similar-products"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}

module "tabs" {
  source    = "./tabs"
  parent_id = module.makeup_resources.resource_id
  args      = var.args
}



