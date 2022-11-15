data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_identity_compartment" "compartment" {
  id = var.compartment_ocid
}

data "oci_objectstorage_namespace" "tenancy_namespace" {
  compartment_id = var.compartment_ocid
}
