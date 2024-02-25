module "products_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "products"
}

module "awards" {
  source    = "./awards"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "compare" {
  source    = "./compare"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "favorites" {
  source    = "./favorites"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "foods" {
  source    = "./foods"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "home-product-list" {
  source    = "./home-product-list"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "product-request-update" {
  source    = "./product-request-update"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "product-request-validate" {
  source    = "./product-request-validate"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "review" {
  source    = "./review"
  parent_id = module.products_resources.resource_id
  args      = var.args
}


module "search" {
  source    = "./search"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "shop" {
  source    = "./shop"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "similar-ingredient" {
  source    = "./similar-ingredient"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "similar-ingredient-hints" {
  source    = "./similar-ingredient-hints"
  parent_id = module.products_resources.resource_id
  args      = var.args
}

module "encrypted_product_id" {
  source    = "./{encrypted_product_id}"
  parent_id = module.products_resources.resource_id
  args      = var.args
}



