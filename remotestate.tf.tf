terraform {
  backend "oci" {}
}


# this requires `terraform init -backend-config="access_key=[customersecretid]" -backend-config="secret_key=[customersecretvalue]"` to be run to init the backend. A one off config