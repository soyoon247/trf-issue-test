module "faq_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "faq"

  method_values = {
    GET = {
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Content-Type" : "false"
          },
        }
      }

      integration_type = var.args.integration_type.HTTP
      integration_uri  = "https://static.hwahae.co.kr/docs/users/sign/faq.html"
      integration_response_map = {
        200 = {
          "response_parameters" = {
            "method.response.header.Content-Type" = "'text/html'"
          },
        }
      }
    }
  }
}
