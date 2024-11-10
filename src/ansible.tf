resource "local_file" "hosts_templatefile" {
  content = templatefile("hosts.tpl",
  {
  webserver = yandex_compute_instance.web
  databases = yandex_compute_instance.db
  storage = yandex_compute_instance.storage
  })
  filename = "hosts"
  depends_on = [ resource.local_file.hosts_for ]
}

resource "local_file" "hosts_for"{
content = <<-EOT
 
%{if length(yandex_compute_instance.web) > 0}
  [webservers]
  %{for webserver in yandex_compute_instance.web }
    ${webserver.name} ansible_host=${webserver.nat_ip_address} fqdn=${webserver.fqdn}
  %{endfor}
%{endif}

%{if length(yandex_compute_instance.db) > 0}
  [databases]
  %{for dbserver in yandex_compute_instance.db }
    ${dbserver.name} ansible_host=${dbserver.nat_ip_address} fqdn=${dbserver.fqdn}
  %{endfor}
%{endif}

%{if length(yandex_compute_instance.storage) > 0}
  [storage]
  %{for storserver in yandex_compute_instance.storage }
    ${storserver.name} ansible_host=${storserver.nat_ip_address} fqdn=${storserver.fqdn}
  %{endfor}
%{endif}
EOT

filename = "hosts.tpl"
depends_on = [yandex_compute_instance.web,yandex_compute_instance.db,yandex_compute_instance.storage]
}

