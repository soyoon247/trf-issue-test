"""
api gateway 배포를 위해 필요한 파일 및 내용들을 자동 생성해줍니다.

ex) python create_new_resource_script.py --path users/favorite/brands

- endpoint path에 해당하는 디렉토리에 main.tf, variables.tf를 생성합니다.
- main.tf는 샘플 내용이 작성되어 생성됩니다. 추가하고자 하는 내용을 넣어서 사용하세요.
- variables.tf 는 수정하지 않아도 됩니다.
- main.tf 생성시 parent_path에서 생성한 모듈을 호출합니다.
"""
import argparse
import os
import re
from shutil import copyfile
from string import Template

CURRENT_PATH = os.getcwd()
RESOURCE_DIR_PATH = "/hwahae-api/resources"
REGEX = re.compile("{([^+]*)\+?}")
# 참고: https://docs.python.org/3/library/string.html#template-strings
MAIN_TEMPLATE = Template(
    """module "${resource_name}" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "${current_path_part}"

  method_values = {
    GET = {
      integration_uri = "http://$$$${stageVariables.HWAHAE_SERVER_API_ALB}/{proxy}"
    }
  }
}
"""
)

PARENT_MAIN_TEMPLATE = Template(
    """module "${resource_name}" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "${current_path_part}"
}
"""
)

VARIABLE_CONNECT_TEMPLATE = Template(
    """
module "${module_name}" {
  source    = "./${source}"
  parent_id = module.${parent_resource_name}.resource_id
  args      = var.args
}
"""
)


def create_new_resource(
    current_path: str,
    current_path_part: str,
    dynamic_path: str,
    _is_last_path: bool,
):
    """
    새로운 리소스 생성

    :param current_path: 테라폼 파일을 만들고 있는 현재 경로
    :param current_path_part: 현재 경로의 part
    :param _is_last_path: 마지막 경로인지 여부
    """
    if os.path.exists(current_path):
        print(f"Already exists {current_path}")
        return

    print(f"Create main.tf, variables.tf in {RESOURCE_DIR_PATH}{dynamic_path}")
    os.makedirs(current_path)

    modified_name = (
        f"{REGEX.search(current_path_part)[1]}"
        if REGEX.search(current_path_part)
        else f"{current_path_part}"
    )
    resource_name = f"{modified_name}_resources"
    main_template = MAIN_TEMPLATE if _is_last_path else PARENT_MAIN_TEMPLATE
    # main.tf 모듈 업데이트
    with open(f"{current_path}/main.tf", "w") as f:
        f.write(
            main_template.substitute(
                resource_name=resource_name,
                current_path_part=current_path_part,
            )
        )

    # 샘플 variables.tf 복사
    copyfile(f"{CURRENT_PATH}/sample/variables.tf", f"{current_path}/variables.tf")
    # 부모 경로에 있는 main.tf 에 모듈 추가
    add_module_in_parent_path_main_tf(current_path, modified_name, current_path_part)


def add_module_in_parent_path_main_tf(
    current_path: str,
    module_name: str,
    source: str,
):
    """
    부모 경로에 있는 main.tf 에 리소스 추가

    :param current_path: 테라폼 파일을 만들고 있는 경로
    :param module_name: 모듈 네임
    :param source: 리소스 경로
    """
    parent_path = "/".join(current_path.split("/")[:-1])
    parent_main_tf_path = f"{parent_path}/main.tf"
    parent_current_path_part = current_path.split("/")[-2:-1][0]
    parent_resource_name = (
        f"{REGEX.search(parent_current_path_part)[1]}_resources"
        if REGEX.search(parent_current_path_part)
        else f"{parent_current_path_part}_resources"
    )
    with open(parent_main_tf_path, "a") as f:
        f.write(
            VARIABLE_CONNECT_TEMPLATE.substitute(
                module_name=module_name,
                source=source,
                parent_resource_name=parent_resource_name,
            )
        )


def create_resources(target_path: str):
    path_parts = target_path.split("/")
    # main.tf 파일이 존재하는지 확인
    if os.path.isfile(f"{CURRENT_PATH}/hwahae-api/resources/{target_path}/main.tf"):
        print(f"Resource already exists! Just update {target_path}/main.tf")

    path_depth = len(path_parts)  # 리소스 경로 깊이 (ex: a/b/c -> 3)
    dynamic_path: str = ""  # target_path의 첫번째 depth부터 마지막 depth까지 순차적으로 추가되는 경로
    current_making_path: str  # 현재 테라폼 파일을 만들고 있는 경로

    for idx in range(path_depth):
        path_part = path_parts[idx]
        dynamic_path += f"/{path_part}"
        current_making_path = f"{CURRENT_PATH}{RESOURCE_DIR_PATH}{dynamic_path}"
        is_last_path = idx == path_depth - 1

        create_new_resource(
            current_path=current_making_path,
            current_path_part=path_part,
            dynamic_path=dynamic_path,
            _is_last_path=is_last_path,
        )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="api gateway 배포를 위해 필요한 파일 및 내용들을 자동 생성해줍니다."
    )
    parser.add_argument(
        "--path", type=str, help="api path를 입력하세요. ex) users/favorite/brands"
    )

    args = parser.parse_args()
    create_resources(args.path)
