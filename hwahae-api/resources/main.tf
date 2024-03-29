module "ad-serving" {
  source    = "./ad-serving"
  parent_id = var.parent_id
  args      = var.args
}

module "application" {
  source    = "./application"
  parent_id = var.parent_id
  args      = var.args
}

module "attendances" {
  source    = "./attendances"
  parent_id = var.parent_id
  args      = var.args
}

module "auth" {
  source    = "./auth"
  parent_id = var.parent_id
  args      = var.args
}

module "award" {
  source    = "./award"
  parent_id = var.parent_id
  args      = var.args
}

module "awards" {
  source    = "./awards"
  parent_id = var.parent_id
  args      = var.args
}

module "braze" {
  source    = "./braze"
  parent_id = var.parent_id
  args      = var.args
}

module "commerce" {
  source    = "./commerce"
  parent_id = var.parent_id
  args      = var.args
}

module "common" {
  source    = "./common"
  parent_id = var.parent_id
  args      = var.args
}

module "contents" {
  source    = "./contents"
  parent_id = var.parent_id
  args      = var.args
}

module "events" {
  source    = "./events"
  parent_id = var.parent_id
  args      = var.args
}

module "goods" {
  source    = "./goods"
  parent_id = var.parent_id
  args      = var.args
}

module "hwahaeplus" {
  source    = "./hwahaeplus"
  parent_id = var.parent_id
  args      = var.args
}

module "ingredients" {
  source    = "./ingredients"
  parent_id = var.parent_id
  args      = var.args
}

module "keywords" {
  source    = "./keywords"
  parent_id = var.parent_id
  args      = var.args
}

module "makeup" {
  source    = "./makeup"
  parent_id = var.parent_id
  args      = var.args
}

module "plannings" {
  source    = "./plannings"
  parent_id = var.parent_id
  args      = var.args
}

module "presigned-urls" {
  source    = "./presigned-urls"
  parent_id = var.parent_id
  args      = var.args
}

module "product-categories" {
  source    = "./product-categories"
  parent_id = var.parent_id
  args      = var.args
}

module "product-goods-pair" {
  source    = "./product-goods-pair"
  parent_id = var.parent_id
  args      = var.args
}

module "products" {
  source    = "./products"
  parent_id = var.parent_id
  args      = var.args
}

module "products-sale-requests" {
  source    = "./products-sale-requests"
  parent_id = var.parent_id
  args      = var.args
}

module "question" {
  source    = "./question"
  parent_id = var.parent_id
  args      = var.args
}

module "questions" {
  source    = "./questions"
  parent_id = var.parent_id
  args      = var.args
}

module "rankings" {
  source    = "./rankings"
  parent_id = var.parent_id
  args      = var.args
}

module "recommends" {
  source    = "./recommends"
  parent_id = var.parent_id
  args      = var.args
}

module "referrals" {
  source    = "./referrals"
  parent_id = var.parent_id
  args      = var.args
}

module "rego" {
  source    = "./rego"
  parent_id = var.parent_id
  args      = var.args
}

module "review-topic" {
  source    = "./review-topic"
  parent_id = var.parent_id
  args      = var.args
}

module "reviews" {
  source    = "./reviews"
  parent_id = var.parent_id
  args      = var.args
}

module "sale_goods" {
  source    = "./sale_goods"
  parent_id = var.parent_id
  args      = var.args
}

module "search" {
  source    = "./search"
  parent_id = var.parent_id
  args      = var.args
}

module "shop" {
  source    = "./shop"
  parent_id = var.parent_id
  args      = var.args
}

module "special-offers" {
  source    = "./special-offers"
  parent_id = var.parent_id
  args      = var.args
}

module "status" {
  source    = "./status"
  parent_id = var.parent_id
  args      = var.args
}

module "support" {
  source    = "./support"
  parent_id = var.parent_id
  args      = var.args
}

module "users" {
  source    = "./users"
  parent_id = var.parent_id
  args      = var.args
}

module "weather-check" {
  source    = "./weather-check"
  parent_id = var.parent_id
  args      = var.args
}

module "recommendations" {
  source    = "./recommendations"
  parent_id = var.parent_id
  args      = var.args
}

module "categories" {
  source    = "./categories"
  parent_id = var.parent_id
  args      = var.args
}

module "beautyon" {
  source    = "./beautyon"
  parent_id = var.parent_id
  args      = var.args
}
