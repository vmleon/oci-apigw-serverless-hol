resource "oci_functions_application" "test_application" {
  compartment_id = var.compartment_ocid
  display_name   = "Application function"
  subnet_ids     = [oci_core_subnet.privatesubnet.id]
}

# resource "oci_functions_function" "test_function" {
#   #Required
#   application_id = oci_functions_application.test_application.id
#   display_name   = "hello function"
#   image          = var.function_image
#   memory_in_mbs  = 256
# }
