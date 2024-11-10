
resource "yandex_compute_instance" "web" {
  depends_on = [ resource.yandex_compute_instance.db ]
  count = 2
  name     = join("-", [var.vms.web.name, count.index+1])
  platform_id = "standard-v1"
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
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${local.local_admin}:${local.local_admin_public_key}"
  }
}
