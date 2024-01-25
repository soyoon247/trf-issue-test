module "search_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "search"
}

module "autocomplete" {
  source    = "./autocomplete"
  parent_id = module.search_resources.resource_id
  args      = var.args
}

module "keyword" {
  source    = "./keyword"
  parent_id = module.search_resources.resource_id
  args      = var.args
}


