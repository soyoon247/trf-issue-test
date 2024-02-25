# terraform-aws-api-gateway
AWS API Gateway를 코드 기반으로 관리하기 위한 Terraform live 코드입니다.

** aws_api_gateway_resource 이하 리소스들을 생성하기 위한 모듈은 [terraform-aws-api-gateway-modules](https://github.com/birdviewdev/terraform-aws-api-gateway-modules)에서 관리합니다.


## How to work
** 구체적인 코드 작업 방식 및 배포 프로세스는 [confluence](https://birdview.atlassian.net/wiki/spaces/HWAH/pages/3438379118/Terraform+Api+Gateway) 문서에서도 확인할 수 있습니다.
- [Hwahae API](https://ap-northeast-2.console.aws.amazon.com/apigateway/main/apis/xxd0dl0q2f/resources?api=xxd0dl0q2f&region=ap-northeast-2)는 `hwahae-api` 하위에서 작업합니다.
- `hwahae-api/resources` 디렉토리 하위에서 `api-gateway-modules` 를 사용하여 api 생성에 필요한 리소스를 생성합니다.
- `hwahae-api/deployment` 디렉토리 하위에서 `aws_api_gateway_deployment`를 추가합니다.
  - 이는 배포될 리소스를 스냅샷 뜨는 과정일 뿐이고, 해당 리소스를 실제 환경에 배포하기 위해서는 aws 콘솔에서 스테이지에 활성 배포(active deployment)를 변경해주어야 합니다.

### 1.create_new_resource_script.py 스크립트를 실행합니다.
- 해당 스크립트를 통해 api gateway 배포를 위해 필요한 파일 및 내용들을 자동 생성할 수 있습니다. 
- `python create_new_resource_script.py --path {path} --description {deployment description}`
  - path : api path를 입력하세요. ex) “users/favorite/brands”
  - description : 배포시 남길 설명을 입력하세요. ex) “users/favorite/brands 리소스 추가”
- 위의 명령어를 실행하면, 
  - `hwahae-api/resources/{path}` 디렉토리에 `main.tf`, `variables.tf` 파일이 생성됩니다.
  - `hwahae-api/deployment/main.tf` 파일에 `aws_api_gateway_deployment` 리소스가 추가됩니다.
- `variables.tf` 파일은 수정하지 않습니다. 
### 2.`hwahae-api/resources/{path}/main.tf` 파일을 수정합니다. ([모듈 문서](https://github.com/birdviewdev/terraform-aws-api-gateway-modules/blob/main/README.md)를 참고하여 작업)
### 3.`hwahae-api/deployment/main.tf` 파일을 확인하고, 필요 시 버전 및 설명을 수정합니다.
### 4.`terraform fmt -recursive` 을 실행하여 포맷을 맞춰줍니다.


## 세부 작업 설명 
- 이 부분은 이해를 돕기 위한 설명이며, 실제 작업할 때는 create_new_resource.py 를 활용하여 필요한 부분만 수정하시면 됩니다. (디렉토리 및 factory 모듈 기본 호출, 상위 모듈 호출, deployment 등이 자동 생성됩니다.)
- `users/favorite/brands` api를 생성하는 케이스로 설명합니다.

#### 1) resources 디렉토리에서 작업 
  - endpoint path에 해당하는 디렉토리에 main.tf, variables.tf를 생성합니다. 
    - `users/favorite/brands` 디렉토리에 main.tf, variables.tf를 생성합니다.
    - 상위 경로인 `users`, `users/favorite` 경로에도 각각 main.tf, variables.tf를 생성합니다. 
    - 해당 경로들에 필요한 파일들이 이미 생성되어 있으면 패스하고, main.tf에서 필요한 작업을 수행합니다. ([모듈 문서](https://github.com/birdviewdev/terraform-aws-api-gateway-modules/blob/main/README.md)를 참고하여 작업)


  - `users/favorite/brands/main.tf` 에서 `api-gateway-modules` 를 사용하여 `aws_api_gateway_resource` 리소스를 생성하는 코드를 작성합니다.
    - 모든 variables.tf 파일은 sample/varables.tf 와 동일하게 생성해줍니다.
    - 부모 모듈의 main.tf에서 위의 main.tf에서 작업한 모듈을 호출합니다
      - resources/main.tf에서 resources/users 모듈을 호출합니다.
      - resources/users/main.tf에서 resources/users/favorite 모듈을 호출합니다.
      - resources/users/favorite/main.tf에서 resources/users/favorite/brands 모듈을 호출합니다.
      - 이미 호출하고 있다면 패스합니다.
        ```hcl
        # resources/users/favorite/main.tf
          module "favorite_resources" {
            source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
            version     = "1.0.6"
            rest_api_id = var.args.rest_api_id
            parent_id   = var.parent_id
            path_part   = "favorite"
        }
        # brands 모듈을 호출
        module "brands" {
          source    = "./brands"
          parent_id = module.sign_resources.resource_id
          args      = var.args
        }```
             
#### 2) deployment 디렉토리에서 작업
- aws_api_gateway_deployment 리소스를 생성합니다.
- 기존에 있는 리소스를 복사하여, 새로운 버전을 붙이고, description을 추가합니다.


## 리소스 생성 모듈 - api-gateway-modules 
- [terraform-aws-api-gateway-modules](https://github.com/birdviewdev/terraform-aws-api-gateway-modules)를 사용하여, aws_api_gateway_resource 이하 리소스들을 생성합니다.
- 구체적인 파라미터 및 사용법에 대한 설명은 [모듈 문서](https://github.com/birdviewdev/terraform-aws-api-gateway-modules/blob/main/README.md)를 통해 확인할 수 있습니다.


## How to deploy
** [confluence](https://birdview.atlassian.net/wiki/spaces/HWAH/pages/3438379118/Terraform+Api+Gateway) 문서를 통해 자세히 확인하실 수 있습니다.
- `feature/SV-XXXX.blahblah` 브랜치에서 위의 내용을 참고하여 작업합니다. 
- 피쳐 브랜치에서 push하거나, pull request를 생성하면 [github actions](https://github.com/birdviewdev/terraform-aws-api-gateway-live/actions)에서 plan 을 확인할 수 있습니다.
- pull request를 생성하여 2인 이상의 approval을 받고, github actions이 모두 통과되면 `main` 브랜치에 머지할 수 있습니다. 
- main 브랜치에 머지되면 깃헙 액션을 통해 aws api gateway에 자동으로 배포됩니다.
  - [aws api gateway](https://ap-northeast-2.console.aws.amazon.com/apigateway/main/apis/xxd0dl0q2f/resources?api=xxd0dl0q2f&region=ap-northeast-2) 에서 확인
- 리소스 변경을 콘솔에서 확인하였으면, 배포를 원하는 환경(스테이지)에 active deployment를 변경하여 배포합니다.


## Structures
모든 리소스가 아닌 example앱만 포함하여 표기하였습니다. 

```
terraform-aws-api-gateway-live
├── README.md
├── create_new_resource_script.py # api gateway 배포를 위한 파일 및 내용들을 자동 생성하는 스크립트
├── hwahae-api # Hwahae API를 위한 리소스들을 관리하는 디렉토리
│   ├── common # 공통 리소스들을 관리하는 디렉토리
│   │   └── outputs.tf
│   ├── deployment # 배포를 위한 리소스들을 관리하는 디렉토리
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── main.tf 
│   ├── resources # aws_api_gateway_resources 하위 리소스들을 관리하는 디렉토리
│   │   ├── example
│   │   │   ├── a
│   │   │   │   ├── main.tf
│   │   │   │   └── variables.tf
│   │   │   ├── b
│   │   │   │   ├── c
│   │   │   │   │   ├── main.tf
│   │   │   │   │   └── variables.tf
│   │   │   │   ├── main.tf
│   │   │   │   └── variables.tf
│   │   │   ├── main.tf
│   │   │   └── variables.tf
└── └── variables.tf
```
