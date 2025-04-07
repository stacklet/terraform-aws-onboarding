modules := "access org-read"

install:
    go install github.com/terraform-docs/terraform-docs@latest

fmt:
    terraform fmt -recursive

docs:
    #!/usr/bin/env bash
    set -e

    for module in {{modules}}; do
      terraform-docs markdown "$module" --output-file README.md
    done
