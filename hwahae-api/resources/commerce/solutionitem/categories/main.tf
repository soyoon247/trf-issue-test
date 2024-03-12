module "categories_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "categories"

  method_values = {
    GET = {
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_type = var.args.integration_type.MOCK
      integration_request_templates = {
        "application/json" = "{\"statusCode\": 200}"
      }
      integration_response_map = {
        200 = {
          response_templates = {
            "application/json" = "#set($inputRoot = $input.path('$'))\n{\n    \"meta\": {\n        \"code\": 200,\n        \"message\": \"OK\"\n    },\n    \"data\": [\n        {\n            \"id\": 16,\n            \"code\": \"001:001:001\",\n            \"name\": \"스킨/토너\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/16.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 1,\n                    \"name\": \"수분공급\"\n                },\n                {\n                    \"id\": 2,\n                    \"name\": \"속건조해결\"\n                },\n                {\n                    \"id\": 3,\n                    \"name\": \"보습케어\"\n                },\n                {\n                    \"id\": 4,\n                    \"name\": \"피부진정\"\n                },\n                {\n                    \"id\": 5,\n                    \"name\": \"피부결정리\"\n                },\n                {\n                    \"id\": 6,\n                    \"name\": \"모공고민\"\n                },\n                {\n                    \"id\": 7,\n                    \"name\": \"지성고민\"\n                },\n                {\n                    \"id\": 8,\n                    \"name\": \"산뜻한마무리\"\n                }\n            ]\n        },\n        {\n            \"id\": 17,\n            \"code\": \"001:001:002\",\n            \"name\": \"로션/에멀젼\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/17.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 1,\n                    \"name\": \"수분공급\"\n                },\n                {\n                    \"id\": 2,\n                    \"name\": \"속건조해결\"\n                },\n                {\n                    \"id\": 3,\n                    \"name\": \"보습케어\"\n                },\n                {\n                    \"id\": 4,\n                    \"name\": \"피부진정\"\n                },\n                {\n                    \"id\": 8,\n                    \"name\": \"산뜻한마무리\"\n                }\n            ]\n        },\n        {\n            \"id\": 18,\n            \"code\": \"001:001:003\",\n            \"name\": \"에센스/앰플/세럼\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/18.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 1,\n                    \"name\": \"수분공급\"\n                },\n                {\n                    \"id\": 2,\n                    \"name\": \"속건조해결\"\n                },\n                {\n                    \"id\": 3,\n                    \"name\": \"보습케어\"\n                },\n                {\n                    \"id\": 4,\n                    \"name\": \"피부진정\"\n                },\n                {\n                    \"id\": 8,\n                    \"name\": \"산뜻한마무리\"\n                },\n                {\n                    \"id\": 9,\n                    \"name\": \"브라이트닝\"\n                },\n                {\n                    \"id\": 6,\n                    \"name\": \"모공고민\"\n                }\n            ]\n        },\n        {\n            \"id\": 20,\n            \"code\": \"001:001:005\",\n            \"name\": \"크림\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/20.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 1,\n                    \"name\": \"수분공급\"\n                },\n                {\n                    \"id\": 2,\n                    \"name\": \"속건조해결\"\n                },\n                {\n                    \"id\": 3,\n                    \"name\": \"보습케어\"\n                },\n                {\n                    \"id\": 4,\n                    \"name\": \"피부진정\"\n                },\n                {\n                    \"id\": 8,\n                    \"name\": \"산뜻한마무리\"\n                },\n                {\n                    \"id\": 10,\n                    \"name\": \"영양공급\"\n                },\n                {\n                    \"id\": 11,\n                    \"name\": \"피부밀착\"\n                }\n            ]\n        },\n        {\n            \"id\": 23,\n            \"code\": \"001:002:001\",\n            \"name\": \"클렌징 폼\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/23.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 2,\n                    \"name\": \"속건조해결\"\n                },\n                {\n                    \"id\": 12,\n                    \"name\": \"딥클렌징\"\n                },\n                {\n                    \"id\": 13,\n                    \"name\": \"저자극\"\n                }\n            ]\n        },\n        {\n            \"id\": 26,\n            \"code\": \"001:002:004\",\n            \"name\": \"클렌징 오일\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/26.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 2,\n                    \"name\": \"속건조해결\"\n                },\n                {\n                    \"id\": 12,\n                    \"name\": \"딥클렌징\"\n                },\n                {\n                    \"id\": 13,\n                    \"name\": \"저자극\"\n                }\n            ]\n        },\n        {\n            \"id\": 32,\n            \"code\": \"001:003:001\",\n            \"name\": \"시트마스크\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/32.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 1,\n                    \"name\": \"수분공급\"\n                },\n                {\n                    \"id\": 3,\n                    \"name\": \"보습케어\"\n                },\n                {\n                    \"id\": 4,\n                    \"name\": \"피부진정\"\n                },\n                {\n                    \"id\": 8,\n                    \"name\": \"산뜻한마무리\"\n                },\n                {\n                    \"id\": 10,\n                    \"name\": \"영양공급\"\n                }\n            ]\n        },\n        {\n            \"id\": 58,\n            \"code\": \"001:008:001\",\n            \"name\": \"바디워시\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/58.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 2,\n                    \"name\": \"속건조해결\"\n                },\n                {\n                    \"id\": 21,\n                    \"name\": \"쫀쫀거품\"\n                },\n                {\n                    \"id\": 12,\n                    \"name\": \"딥클렌징\"\n                }\n            ]\n        },\n        {\n            \"id\": 70,\n            \"code\": \"001:009:001\",\n            \"name\": \"샴푸\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/70.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 14,\n                    \"name\": \"건조한두피\"\n                },\n                {\n                    \"id\": 15,\n                    \"name\": \"지성두피\"\n                },\n                {\n                    \"id\": 16,\n                    \"name\": \"손상모발\"\n                },\n                {\n                    \"id\": 17,\n                    \"name\": \"두피진정\"\n                },\n                {\n                    \"id\": 18,\n                    \"name\": \"쿨링\"\n                },\n                {\n                    \"id\": 19,\n                    \"name\": \"두피건강\"\n                }\n            ]\n        },\n        {\n            \"id\": 71,\n            \"code\": \"001:009:002\",\n            \"name\": \"린스/트리트먼트/팩\",\n            \"image_url\": \"https://img.hwahae.co.kr/shopping/solutionitem_category/71.jpg\",\n            \"topic_groups\": [\n                {\n                    \"id\": 14,\n                    \"name\": \"건조한두피\"\n                },\n                {\n                    \"id\": 16,\n                    \"name\": \"손상모발\"\n                }\n            ]\n        }\n    ]\n}"
          }
        }
      }
    }
  }
}