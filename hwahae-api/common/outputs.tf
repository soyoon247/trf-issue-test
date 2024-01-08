output "authorization" {
  value = {
    NONE               = "NONE",
    CUSTOM             = "CUSTOM",
    AWS_IAM            = "AWS_IAM",
    COGNITO_USER_POOLS = "COGNITO_USER_POOLS"
  }
}

output "http_method" {
  value = {
    GET     = "GET",
    POST    = "POST",
    PUT     = "PUT",
    DELETE  = "DELETE",
    PATCH   = "PATCH",
    OPTIONS = "OPTIONS",
    HEAD    = "HEAD",
    ANY     = "ANY"
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

output "response_models_empty" {
  value = {
    "application/json" = "Empty"
  }
}

output "request_templates_status_200" {
  value = {
    "application/json" = "{\"statusCode\": 200}"
  }
}
