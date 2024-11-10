resource "yandex_compute_disk" "storage_disk" {
  count = 3
  name  = "sda${count.index}"
  type = "network-hdd"
  size = 1
}

resource "yandex_compute_instance" "stor" {
  name     = var.vms.stor.name
  platform_id = "standard-v1"
  resources {
    cores         = var.vms.stor.cores
    memory        = var.vms.stor.memory
    core_fraction = var.vms.stor.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.vms.stor.image
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk.*.id
    content {
      disk_id = secondary_disk.value
    }
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${local.local_admin}:${local.local_admin_public_key}"
  }
}
