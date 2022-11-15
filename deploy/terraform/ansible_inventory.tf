resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible_inventory.tftpl",
    {
      web_hostnames  = oci_core_instance.web.*.hostname_label
      web_public_ips = oci_core_instance.web.*.public_ip
    }
  )
  filename = "${path.module}/generated/server.ini"
}
