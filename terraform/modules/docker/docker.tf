# Construir imágenes Docker
resource "docker_image" "build" {
  for_each = toset(var.applications)

  # Construye la imagen con el tag `<registry_url>/<app_name>:<commit_short_sha>`
  name = "${var.registry_url}/${each.key}:${var.commit_short_sha}"

  build {
    context    = "../boutique-online/src/${each.key}"
  }

  # Solo se reconstruye si cambia el commit_short_sha
  triggers = {
    commit_sha = var.commit_short_sha
  }
}

# Crear un tag adicional `latest` para cada imagen
resource "docker_tag" "latest" {
  for_each = docker_image.build

  # ID de la imagen construida previamente
  source_image = each.value.image_id

  # Imagen destino con el tag `latest`
  target_image = "${var.registry_url}/${each.key}:latest"
}

# Push del tag `<commit_short_sha>`
resource "docker_registry_image" "push_sha" {

  for_each = docker_image.build

  name = each.value.name
}

# Push del tag `latest`
resource "docker_registry_image" "push_latest" {

  for_each = docker_tag.latest

  name = each.value.target_image
}

