terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "sy_trf_test"

    workspaces {
      name = "trf-issue-test"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "ap-northeast-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  token      = var.AWS_SESSION_TOKEN
}


# aws_api_gateway_resource 이하 리소스 추가
module "hwahae-rest-api-resources" {
  source     = "./resources"
  args       = local.args
  parent_id  = data.aws_api_gateway_rest_api.hwahae_api.root_resource_id
  depends_on = [data.aws_api_gateway_rest_api.hwahae_api]
}

# aws_api_gateway_deployment 리소스 추가
module "deployment" {
  source      = "./deployment"
  rest_api_id = data.aws_api_gateway_rest_api.hwahae_api.id
  depends_on  = [module.hwahae-rest-api-resources]
}
