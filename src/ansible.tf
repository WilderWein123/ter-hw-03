resource "local_file" "hosts_templatefile" {
  content = templatefile(
    "hosts.tpl", 
    { 
      group_hosts = tolist(
        [
          {
            group = "webservers"
            hosts = yandex_compute_instance.web[*]
          },
          {
            group = "databases"
            hosts = values(yandex_compute_instance.db)
          },
          {
           group = "storage"
           hosts = yandex_compute_instance.stor[*]
          }
      ]
    )
  }
)

  filename = "hosts"
}