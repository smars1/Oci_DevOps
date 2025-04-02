provider "oci" {
  auth   = "ResourcePrincipal"
  region = terraform.workspace == "PROD" ? "us-ashburn-1" : "us-phoenix-1"
}

module "template_files" {
  source   = "hashicorp/dir/template"
  base_dir = "${path.module}/src"
}

# obtiene el namespace dinamicamente
data "oci_objectstorage_namespace" "os_namespace" {}

# sube archivos al bucket
resource "oci_objectstorage_object" "objects" {
  for_each     = module.template_files.files
  namespace    = data.oci_objectstorage_namespace.os_namespace.namespace
  bucket       = var.bucket_name
  object       = each.key
  content_type = each.value.content_type
  source       = abspath(each.value.source_path)
}
