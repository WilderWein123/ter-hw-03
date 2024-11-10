resource "yandex_compute_disk" "storage_disk" {
  count = 3
  name  = "sda${count.index}"
  type = "network-hdd"
  size = 1
}

resource "yandex_compute_instance" "storage" {
  name     = var.vms.storage.name
  platform_id = "standard-v1"
  resources {
    cores         = var.vms.storage.cores
    memory        = var.vms.storage.memory
    core_fraction = var.vms.storage.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.vms.storage.image
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
