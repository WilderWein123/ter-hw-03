###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default     = "null"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "null"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlLc9tAx9tK7/MK+4I0n7a535xrIX+GT/DRwJpxEmojEmgZXwHtLJtBQTAFjV70ZwDfB9amWHZiWyigP9UP5o5YntsNhm3wXCRS/AbLbgt1foxGpGXsDqnPb0+LyFzxMl2WlKHxH84bZ0GMFp7/TKgacxZlEMz1QFuLyU4QIW8PyyFGdblHbnXz7Dp+PgEd6nRlnjNH/hP+o+0wGOhgDwUTS0gAlJOMxSJglD7ixBwuZURYlE1sgBF7lnJQfHTwVh+huJFaZDCGwA2NG2PUWbECG85joUsqpa4ofunxiHkyp23TQJMVxGAne+42FnzwWuYDJFAlEW5gdBXn+RYj1qLoqKLnIAPQ6ZvCdt3+cjgKje3x4k6vLSSeaBPQp1aShdoD9vRQ/TlGw2ebN0H/EFlPEasg5PGMqVehfGoJGRu/RN5MLjnT8XKM3wc7Kkft+d8EzRJtsYCPn53N6Bt0gsHvszKHueI8PKF+5bC8NXYHtStDLlIWEbbORPAuK/2Z70= seregin@msk-s3-arm076"
  description = "ssh-keygen -t ed25519"
}

variable vms {
  type = map(object({
    name = string
    cores = number
    memory = number
    core_fraction = number
    image = string
    network = string
  }))
    default = { 
      "web" = {
        name = "web"
        cores = 2
        memory = 1
        core_fraction = 5
        image = "fd833v6c5tb0udvk4jo6"
        network = "web-network"
      },
      "stor" = {
        name = "stor"
        cores = 2
        memory = 1
        core_fraction = 5
        image = "fd833v6c5tb0udvk4jo6"
        network = "web-network"
    }
  }
}

variable "each_vm" {
  type = list(object({
      vm_name = string
      cpu = number
      ram = number
      disk_volume = number
      core_fraction = number 
      image = string
    }))
    default = [
      {
      vm_name="main"
      cpu = 2
      ram = 2
      disk_volume = 10
      core_fraction = 5 
      image = "fd833v6c5tb0udvk4jo6"
    },
      {
      vm_name="replica"
      cpu = 2
      ram = 2
      disk_volume = 20
      core_fraction = 5 
      image = "fd833v6c5tb0udvk4jo6"
    }
  ]
}
