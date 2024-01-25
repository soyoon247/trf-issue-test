module "tag_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "tag"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.filterQuery"          = "false"
        "method.request.querystring.orderType"            = "false"
        "method.request.querystring.pageNum"              = "false"
        "method.request.querystring.selectedCategoryCode" = "false"
        "method.request.querystring.tag"                  = "true"
      }
      method_response_map = {
        200 = {}
        500 = {}
      }

      integration_request_parameters = {
        "integration.request.querystring.filterQuery"          = "method.request.querystring.filterQuery"
        "integration.request.querystring.orderType"            = "method.request.querystring.orderType"
        "integration.request.querystring.pageNum"              = "method.request.querystring.pageNum"
        "integration.request.querystring.selectedCategoryCode" = "method.request.querystring.selectedCategoryCode"
        "integration.request.querystring.tag"                  = "method.request.querystring.tag"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_JSP}/HwaHae3.0/Search/SearchProductTag.jsp"

      integration_response_map = {
        200 = {}
        500 = {
          selection_pattern = "5\\d{2}"
        }
      }
    }
  }
}

