output "registry_url" {
  description = "URL base del registro ECR"
value = split("/", values(aws_ecr_repository.app_repository)[0].repository_url)[0]
}

