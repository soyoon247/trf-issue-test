terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "hh-devops"

    workspaces {
      name = "hh-api-gateway"
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
}

#authorizer_uri = "arn:aws:apigateway:ap-northeast-2:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-2:345616581939:function:$${stageVariables.lambda_function_name}/invocations"

module "common" {
  source = "./common"
}

data "aws_api_gateway_rest_api" "hwahae_api" {
  name = "Hwahae API"
}

data "aws_api_gateway_authorizers" "hwahae_authorizers" {
  rest_api_id = data.aws_api_gateway_rest_api.hwahae_api.id
}

# aws_api_gateway_resource 이하 리소스 추가
module "hwahae-rest-api-resources" {
  source = "./resources"
  args = merge(
    module.common,
    {
      rest_api_id      = data.aws_api_gateway_rest_api.hwahae_api.id
      root_resource_id = data.aws_api_gateway_rest_api.hwahae_api.root_resource_id
      hwahae_authorizer_id_map = {
        default = data.aws_api_gateway_authorizers.hwahae_authorizers.ids[0]
      }
    }
  )
  parent_id  = data.aws_api_gateway_rest_api.hwahae_api.root_resource_id
  depends_on = [data.aws_api_gateway_rest_api.hwahae_api, data.aws_api_gateway_authorizers.hwahae_authorizers]
}

# aws_api_gateway_deployment 리소스 추가
module "deployment" {
  source      = "./deployment"
  rest_api_id = data.aws_api_gateway_rest_api.hwahae_api.id
  depends_on  = [module.hwahae-rest-api-resources]
}
