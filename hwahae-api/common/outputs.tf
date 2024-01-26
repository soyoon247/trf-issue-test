output "authorization" {
  value = {
    NONE               = "NONE",
    CUSTOM             = "CUSTOM",
    AWS_IAM            = "AWS_IAM",
    COGNITO_USER_POOLS = "COGNITO_USER_POOLS"
  }
}


output "integration_type" {
  value = {
    AWS        = "AWS",
    AWS_PROXY  = "AWS_PROXY",
    HTTP       = "HTTP",
    HTTP_PROXY = "HTTP_PROXY",
    MOCK       = "MOCK"
  }
}

output "connection_type" {
  value = {
    INTERNET = "INTERNET",
    VPC_LINK = "VPC_LINK"
  }
}

output "passthrough_behavior" {
  value = {
    WHEN_NO_MATCH     = "WHEN_NO_MATCH",
    WHEN_NO_TEMPLATES = "WHEN_NO_TEMPLATES",
    NEVER             = "NEVER"
  }
}

output "empty_response_models" {
  value = {
    "application/json" = "Empty"
  }
}

output "status_200_request_templates" {
  value = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

output "option_method_response_parameters" {
  value = {
    "method.response.header.Access-Control-Allow-Headers" = "false"
    "method.response.header.Access-Control-Allow-Methods" = "false"
    "method.response.header.Access-Control-Allow-Origin"  = "false"
  }
}

output "all_methods" {
  value = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
}

output "all_headers" {
  value = "'*'"
}

output "cors_allowed_headers" {
    value = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,Hwahae-User-Id,Hwahae-Device-Id,Hwahae-Platform,Hwahae-App-Version,Hwahae-Device-Scale,Hwahae-Timestamp,Hwahae-Signature,User-Agent'"
}

output "all_origin" {
  value = "'*'"
}

