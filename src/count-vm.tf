resource "yandex_compute_instance" "web" {
  depends_on = [ resource.yandex_compute_instance.db ]
  count = 2
  name     = join("-", [var.vms.web.name, count.index+1])
  platform_id = var.vms.web.platform_id
  resources {
    cores         = var.vms.web.cores
    memory        = var.vms.web.memory
    core_fraction = var.vms.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.vms.web.image
    }
  }
  scheduling_policy {
    preemptible = var.vms.web.scheduling_policy
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms.web.nat
    security_group_ids = [ yandex_vpc_security_group.example.id ]
  }
  

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${local.local_admin}:${local.local_admin_public_key}"
  }
}
