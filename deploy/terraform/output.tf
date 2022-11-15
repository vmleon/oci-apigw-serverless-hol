output "auth-token" {
  value = oci_identity_auth_token.user_auth_token.token
}

output "api_key_fingerprint" {
  value = oci_identity_api_key.fn_user_api_key.fingerprint
}

output "api_key_value" {
  value = oci_identity_api_key.fn_user_api_key.key_value
}
