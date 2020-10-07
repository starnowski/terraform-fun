terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}

provider "docker" {}

locals {
  //TODO Works
  //  computed_container_id = join("=", ["MOCKERSERVER_CONTAINER_ID", lookup(var.docker_container_properties, "container_id", "XXX")])

  //TODO
  computed_varaibles    = { "container_id" = join(", ", docker_container.mockser_tutorial.network_data.*.ip_address) }
  computed_map          = merge(var.docker_container_properties, local.computed_varaibles)
  computed_container_id = join("=", ["MOCKERSERVER_CONTAINER_ID", lookup(local.computed_map, "container_id", "XXX")])
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "nginx_tutorial"
  ports {
    internal = 80
    external = 8000
  }
  env = [
    local.computed_container_id
  ]
}

resource "docker_image" "mockserver_test" {
  name         = "mockserver/mockserver:latest"
  keep_locally = false
}


resource "docker_container" "mockser_tutorial" {
  image = docker_image.mockserver_test.latest
  name  = "mockser_tutorial"
  ports {
    internal = 1080
    external = 1080
  }
}

//resource "docker_image" "bash_test_image" {
//  name         = "bash:5.1-rc"
//  keep_locally = false
//}
//
//
//resource "docker_container" "bash_container" {
//  image = docker_image.bash_test_image.latest
//  name  = "bash_5_1_rc_test"
//}