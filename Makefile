apply ::
	terraform apply

clean ::
	mapfile -t args < <(terraform state list); \
	terraform state rm "$${args[@]}"

docs ::
	terraform-docs markdown table --recursive --output-file README.md .

import ::
	./scripts/import.sh

init ::
	terraform init -reconfigure -backend-config="main.s3.tfbackend"