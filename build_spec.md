
```yaml
version: 0.1
component: build
timeoutInSeconds: 10000
shell: bash
failImmediatelyOnError: true

env:
    vaultVariables:
        ACCESS_KEY: "[ACCESS_KEY_VAULT_SECRET_OCID]"
        SECRET_KEY: "[SECRET_KEY_VAULT_SECRET_OCID]"
steps:
    - type: Command
        name: Init terraform
        command: terraform init -no-color -backend-config="access_key=${ACCESS_KEY}" -backend-config="secret_key=${SECRET_KEY}"
    - type: Command
        name: Select workspace
        command: terraform workspace select ${TARGET_ENV} -no-color
    - type: Command
        name: Refresh terraform
        command: ./runtf.sh refresh -no-color
    - type: Command
        name: Fix git dates
        command: ./fix_git.sh
    - type: Command
        name: Apply terraform
        command: ./runtf.sh apply -no-color -auto-approve
```