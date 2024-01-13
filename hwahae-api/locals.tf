# api 생성 시 필요한 인자를 넘겨주기 위해 common 모듈 및 콘솔에서 생성한 리소스 정보를 가져오는 data 리소스 추가
module "common" {
  source = "./common"
}

data "aws_api_gateway_rest_api" "hwahae_api" {
  name = "Hwahae API"
}

data "aws_api_gateway_authorizers" "hwahae_authorizers" {
  rest_api_id = data.aws_api_gateway_rest_api.hwahae_api.id
}

locals {
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
}
