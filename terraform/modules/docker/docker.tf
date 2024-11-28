resource "null_resource" "ecr_auth" {
  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 548951595836.dkr.ecr.us-east-1.amazonaws.com
    EOT
  }
}

#resource "null_resource" "ecr_auth" {
#  provisioner "local-exec" {
#    command = "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 548951595836.dkr.ecr.us-east-1.amazonaws.com"
#    command = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${var.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
#  }
#
#  triggers = {
#    always_run = timestamp() # Fuerza la ejecución
#  }
#}

# Construir imágenes Docker
resource "docker_image" "build" {
  for_each = toset(var.applications)

  # Construye la imagen con el tag `<registry_url>/<app_name>:<commit_short_sha>`
  name = "${var.registry_url}/${each.key}:${var.commit_short_sha}"

  build {
    context    = "../butique-online/src/${each.key}"
#    dockerfile = "../butique-online/src/${each.key}/Dockerfile"
  }
}

# Crear un tag adicional `latest` para cada imagen
resource "docker_tag" "latest" {
  for_each = docker_image.build

#  # Repositorio y nombre de la aplicación
#  target_repository = "${var.registry_url}/${each.key}"

  # ID de la imagen construida previamente
  source_image = each.value.image_id

  # Imagen destino con el tag `latest`
  target_image = "${var.registry_url}/${each.key}:latest"
}

# Push del tag `<commit_short_sha>`
resource "docker_registry_image" "push_sha" {

  depends_on = [null_resource.ecr_auth]

#  registry_auth {
#    address      = var.registry_url
#    config_file  = "~/.docker/config.json" # Usa el archivo de configuración existente
#  }

 for_each = docker_image.build

  name = each.value.name
}

# Push del tag `latest`
resource "docker_registry_image" "push_latest" {

  depends_on = [null_resource.ecr_auth]

#  registry_auth {
#    address      = var.registry_url
#    config_file  = "~/.docker/config.json" # Usa el archivo de configuración existente
#  }

 for_each = docker_tag.latest

  name = each.value.target_image
}

