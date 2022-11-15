locals {
  dynamic_group_name = "apigw_fn_dynamic_group"
  policy_name        = "apigw_fn_policy"
}

resource "oci_identity_dynamic_group" "apigw_fn_dynamic_group" {
  count          = var.create_dynamic_group ? 1 : 0
  compartment_id = var.tenancy_ocid
  name           = local.dynamic_group_name
  description    = "API Gateway and Serverless Dynamic Group"
  matching_rule  = <<EOF
                    Any {
                        ALL {resource.type = 'ApiGateway', resource.compartment.id = '${var.compartment_ocid}'},
                        ALL {resource.type = 'fnfunc', resource.compartment.id = '${var.compartment_ocid}'}
                    }
                    EOF
}

resource "oci_identity_policy" "apigw_fn_policy" {
  count          = var.create_policy ? 1 : 0
  compartment_id = var.tenancy_ocid
  name           = local.policy_name
  description    = "Allow apigw and fn to manage all resources in compartment ${data.oci_identity_compartment.compartment.name}"
  statements     = ["allow dynamic-group ${local.dynamic_group_name} to manage all-resources in compartment id ${var.compartment_ocid}"]
}

resource "oci_identity_user" "fn_user" {
  compartment_id = var.tenancy_ocid
  description    = "User for functions"
  name           = "fn_user"
  email          = "fn_user@example.com"
}

resource "oci_identity_auth_token" "user_auth_token" {
  user_id     = oci_identity_user.fn_user.id
  description = "Functions Auth Token"
}

resource "oci_identity_api_key" "fn_user_api_key" {
  user_id   = oci_identity_user.fn_user.id
  key_value = var.rsa_public_key
}
