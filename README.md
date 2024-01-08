# terraform-aws-api-gateway
AWS API Gateway를 코드 기반으로 관리하기 위한 Terraform module 및 live 코드

### Structures
모든 리소스가 아닌 example앱으로 표시하였습니다.
```
terraform-aws-api-gateway
├── README.md
├── add_new_deployment_script.py
├── hwahae-rest-api
│   ├── common
│   │   ├── authorizer
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── gateway-response
│   │   │   ├── main.tf
│   │   │   └── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── rest-api
│   │       ├── main.tf
│   │       └── outputs.tf
│   ├── resources
│   │   ├── deployment
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── path_resources
│   │       ├── example
│   │       │   ├── a
│   │       │   │   ├── main.tf
│   │       │   │   └── variables.tf
│   │       │   ├── b
│   │       │   │   ├── c
│   │       │   │   │   ├── main.tf
│   │       │   │   │   └── variables.tf
│   │       │   │   ├── main.tf
│   │       │   │   └── variables.tf
│   │       │   ├── main.tf
│   │       │   └── variables.tf
│   │       ├── main.tf
│   │       └── variables.tf
│   └── stages
│       ├── dev
│       │   ├── main.tf
│       │   └── variables.tf
│       ├── prd
│       │   ├── main.tf
│       │   └── variables.tf
│       ├── stg
│       │   ├── main.tf
└────── └── └── variables.tf

```


### How to use
- 코드 작업 방식 및 배포 프로세스는 [confluence](https://birdview.atlassian.net/wiki/spaces/HWAH/pages/3438379118/Terraform+Api+Gateway) 문서를 참고하시기 바랍니다.

#### api-gateway-modules parameters 설명

| Parameter                          | Description                                                                                                                                                                                                                                          | Type                                                                                                                                          | Default           | Example                                                                                                                                                                                                                                                                                                                                                  |
|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `rest_api_id`                      | aws_api_gateway_rest_api의 ID, 주로 변수로 사용.                                                                                                                                                                                                             | string                                                                                                                                        | -                 | `var.rest_api_id`                                                                                                                                                                                                                                                                                                                                        |
| `parent_id`                        | aws_api_gateway_resource의 부모 resource의 ID, 주로 변수로 사용.                                                                                                                                                                                                | string                                                                                                                                        | -                 | `var.parent_id`                                                                                                                                                                                                                                                                                                                                          |
| `path_part`                        | aws_api_gateway_resource의 path_part, "users/favorite/brands 리소스를 생성한다면, "brands"                                                                                                                                                                     | string                                                                                                                                        | -                 | `"users"`                                                                                                                                                                                                                                                                                                                                                |
| `method_values`                    | method별로 aws_api_gateway_method, aws_api_gateway_method_response, aws_api_gateway_integration, aws_api_gateway_interation_response의 attribute를 나타내는 map, 키 값으로 aws_api_gateway_method의 HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY)를 갖는다 | any                                                                                                                                           | `{}`              | `{GET = { ... }, POST = { ... }}`                                                                                                                                                                                                                                                                                                                        |
| `common_values`                    | method가 공통으로 갖는 aws_api_gateway_method, aws_api_gateway_method_response, aws_api_gateway_integration, aws_api_gateway_interation_response의 attribute를 나타내는 map                                                                                       | any                                                                                                                                           | `{}`              | `{ response_models = {...} }`                                                                                                                                                                                                                                                                                                                            |

#### method_values, common_values 에 들어가는 parameters 설명

| Parameter                          | Description                                                                                                             | Type                                                                                                                                          | Default           | Example                                                                                                                                                                                                                                                                                                                                                  |
|------------------------------------|-------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `resource_id`                      | aws_api_gateway_resource의 ID, 주로 변수로 사용                                                                                 | string                                                                                                                                        | -                 | `var.resource_id`                                                                                                                                                                                                                                                                                                                                        |
| `api_key_required`                 | aws_api_gateway_method가 ApiKey를 필요로 하는지 여부                                                                              | bool                                                                                                                                          | `false`           | `true`                                                                                                                                                                                                                                                                                                                                                   |
| `authorization`                    | aws_api_gateway_method의 authorization type (NONE, AWS_IAM, CUSTOM, COGNITO_USER_POOLS), 주로 변수로 사용                       | string                                                                                                                                        | `"NONE"`          | `var.args.authorization.CUSTOM`                                                                                                                                                                                                                                                                                                                          |
| `authorizer_id`                    | aws_api_gateway_method가 사용하는 custom authorizer의 ID, 주로 변수로 사용                                                           | string                                                                                                                                        | -                 | `var.args.hwahae_authorizer_id_map.default`                                                                                                                                                                                                                                                                                                              |
| `method_request_parameters`        | aws_api_gateway_method의 request parameters 정보를 나타내는 map                                                                 | map(string)                                                                                                                                   | -                 | `{"method.request.querystring.userId" = "false"}`                                                                                                                                                                                                                                                                                                        |
| `method_response_map`              | aws_api_gateway_method_response의 status_code별 response parameters, response_models 정보를 나타내는 map                         | map(object({response_parameters = optional(map(string)) response_models = optional(map(string))}))                                            | -                 | `{ 200 = { response_parameters = { ... } } }`                                                                                                                                                                                                                                                                                                            |
| `integration_request_parameters`   | aws_api_gateway_integration의 request_paremeters 정보를 나타내는 map                                                            | map(string)                                                                                                                                   | -                 | `{"integration.request.path.award_id" = "method.request.path.award_id"}`                                                                                                                                                                                                                                                                                 |
| `integration_connection_type`      | aws_api_gateway_integration의 connection_type (INTERNET, VPC_LINK)                                                       | string                                                                                                                                        | `"INTERNET"`      | `"INTERNET"`                                                                                                                                                                                                                                                                                                                                             |
| `integration_http_method`          | aws_api_gateway_integration의 HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY)                                   | string                                                                                                                                        | -                 | `"POST"`                                                                                                                                                                                                                                                                                                                                                 |
| `integration_passthrough_behavior` | aws_api_gateway_integration의 passthrough_behavior (WHEN_NO_MATCH, WHEN_NO_TEMPLATES, NEVER)                             | string                                                                                                                                        | `"WHEN_NO_MATCH"` | `"WHEN_NO_MATCH"`                                                                                                                                                                                                                                                                                                                                        |
| `integration_timeout_milliseconds` | aws_api_gateway_integration의 timeout_milliseconds (50 ~ 29000)                                                          | number                                                                                                                                        | `29000`           | `5000`                                                                                                                                                                                                                                                                                                                                                   |
| `integration_type`                 | aws_api_gateway_integration의 type (AWS, AWS_PROXY, HTTP, HTTP_PROXY, MOCK)                                              | string                                                                                                                                        | `"HTTP_PROXY"`    | `"HTTP"`                                                                                                                                                                                                                                                                                                                                                 |
| `integration_uri`                  | aws_api_gateway_integration의 uri                                                                                        | string                                                                                                                                        | -                 | `"http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/braze/user/attribute"`                                                                                                                                                                                                                                                      |
| `integration_request_templates`    | aws_api_gateway_integration의 request_templates, 주로 변수로 사용                                                               | map(string)                                                                                                                                   | -                 | `var.args.request_templates_status_200`, `{ "application/json" = "#set($$HwahaeLegacyRequestOverride = \"1\")\n#set($$HwahaeLegacyRequest = $$input.params('hwahae-legacy-request'))\n$$input.json(\"$$\")\n#if($$HwahaeLegacyRequest == \"\")\n  #set($$context.requestOverride.header.hwahae-legacy-request = $$HwahaeLegacyRequestOverride)\n#end" }` |
| `integration_response_map`         | aws_api_gateway_integration_response의 status_code별 response_models, response parameters, selection_pattern 정보를 나타내는 map | map(object({response_models     = optional(map(string)) response_parameters = optional(map(string)) selection_pattern   = optional(string)})) | -                 | `{ 200 = { selection_pattern = "pattern1", response_models = { ... } } }`                                                                                                                                                                                                                                                                                |



#### 예시 (HTTP_PROXY 만 하는 경우)
```hcl
module "nickname_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "0.0.1"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "nickname"

  method_values = {
    GET = {
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/users/nickname"
    }
  }
}
```
#### 예시 (복합 케이스) 
```hcl
module "brands_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "0.0.1"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "brands"
  
  common_values = {
    authorization = var.args.authorization.CUSTOM
    authorizer_id = var.args.hwahae_authorizer_id_map.default
  }

  method_values = {
    GET = {
      method_response_map = {
        200 = {
          response_models = var.args.response_models_empty
          response_parameters = {
              "method.response.header.Content-Type" : "false"
          },
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/search/brands"
      integration_request_templates = var.args.request_templates_status_200
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "'*'"
          }
        }
        400 = { selection_pattern : "400" },
        401 = { selection_pattern : "401" },
        409 = { selection_pattern : "409" },
      }
    }
    
    POST = {
      method_request_parameters = {
        "method.request.header.Content-Type" = "false"
        "method.request.path.id"             = "true"
      }
      integration_request_parameters = {
        "integration.request.header.Content-Type" = "method.request.header.Content-Type"
        "integration.request.path.id"             = "method.request.path.id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/search/brands2"
    }
  }
}



```
