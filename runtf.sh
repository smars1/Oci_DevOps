#!/bin/bash

export OCI_RESOURCE_PRINCIPAL_REGION=$(if grep -q "PROD" .terraform/environment; then echo "us-ashburn-1"; else echo "us-phoenix-1"; fi)
terraform "$@"