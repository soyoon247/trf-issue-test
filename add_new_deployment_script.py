"""
api gateway 배포를 위해 필요한 파일 및 내용들을 자동 생성해줍니다.

ex) python add_new_deployment_script.py --path users/favorite/brands --description "/users/favorite/brands 리소스 추가"

- path 경로에 맞는 main.tf, variables.tf를 생성합니다.
- main.tf는 샘플 내용이 작성되어 생성됩니다. 추가하고자 하는 내용을 넣어서 사용하세요.
- variables.tf 는 수정하지 않아도 됩니다.
- main.tf 생성시 parent_path에서 생성한 모듈을 호출합니다.
- aws_api_gateway_deployment 리소스를 자동으로 생성하고, deployment_version_map에 추가합니다. (main.tf 가 이미 생성되어 있는 경우, 이 작업만 진행됩니다)
"""
import argparse
import os
from shutil import copyfile
import re

CURRENT_PATH = os.getcwd()
RESOURCE_DIR_PATH = '/hwahae-api/resources'
REGEX = re.compile('{?([^+]*)\+?}?')


def convert_version_to_deployment_name(version_str):
    return f"version_{version_str.replace('.', '_')}"


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='api gateway 배포를 위해 필요한 파일 및 내용들을 자동 생성해줍니다.')
    parser.add_argument('--path', type=str, help='api path를 입력하세요. ex) users/favorite/brands')
    parser.add_argument('--description', type=str, help='배포시 남길 설명을 입력하세요. ex) users/favorite/brands 리소스 추가')
    args = parser.parse_args()
    target_path = args.path
    description = args.description
    path_parts = target_path.split('/')

    # main.tf 파일이 존재하는지 확인
    target_main_tf_full_path = f'{CURRENT_PATH}/hwahae-api/resources/{target_path}/main.tf'
    if os.path.isfile(target_main_tf_full_path):
        print(f'Resource already exists! Just update {target_path}/main.tf')

    else:
        for idx in range(len(path_parts)):
            path = '/'.join(path_parts[0:idx + 1])
            main_path = f'{CURRENT_PATH}{RESOURCE_DIR_PATH}/{path}'
            main_tf_path = f'{main_path}/main.tf'
            variables_tf_path = f'{main_path}/variables.tf'

            last_path = path_parts[idx]
            resource_name = f'{REGEX.search(last_path)[1]}_resources' if REGEX.search(
                last_path) else f'{last_path}_resources'

            if not os.path.exists(main_path):
                print(f"Create main.tf, variables.tf in {RESOURCE_DIR_PATH}/{path}")

                # main.tf 생성 및 내용 입력
                os.makedirs(main_path)
                if idx == len(path_parts) - 1:
                    with open(main_tf_path, 'w') as f:
                        f.write(f'''module "{resource_name}" {{
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "0.0.1"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{last_path}"

  method_values = {{
    GET = {{
      integration_uri = "http://$${{stageVariables.AD_SERVING_SERVER_API_ALB}}/{{proxy}}"
    }}
  }}
}}
''')
                else:
                    with open(main_tf_path, 'w') as f:
                        f.write(f'''module "{resource_name}" {{
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "0.0.1"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{last_path}"
}}
''')

                # variables.tf 파일 복사
                copyfile(f'{CURRENT_PATH}/sample/variables.tf', variables_tf_path)

                # parent_path에서 생성한 모듈 호출
                parent_path = '/'.join(main_path.split('/')[:-1])
                parent_main_tf_path = f'{parent_path}/main.tf'
                parent_last_path = main_path.split('/')[-2:-1][0]
                parent_resource_name = f'{REGEX.search(parent_last_path)[1]}_resources' if REGEX.search(
                    parent_last_path) else f'{parent_last_path}_resources'

                with open(parent_main_tf_path, 'a') as f:
                    f.write(f'''
module "{resource_name}" {{
  source    = "./{last_path}"
  parent_id = module.{parent_resource_name}.resource_id
  args = var.args
}}
''')

    # deployment 생성
    deployment_file_path = f'{CURRENT_PATH}/hwahae-api/resources/deployment/main.tf'
    deployment_outputs_path = f'{CURRENT_PATH}/hwahae-api/resources/deployment/outputs.tf'
