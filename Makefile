.PHONY: check-for-local-state \
  purge-remote-state-cache \
  configure-state \
  apply \
  graph \
  plan

# We don't want any local state being pushed when remote state is
# configured, so refuse to run if it exists.
check-for-local-state:
	test ! -f terraform.tfstate || exit 1

purge-remote-state-cache:
	rm -f .terraform/terraform.tfstate

configure-state: check-for-local-state purge-remote-state-cache
	terraform remote config -backend=s3 \
	  -backend-config='acl=private' \
	  -backend-config='bucket=govuk-terraform-state' \
	  -backend-config='encrypt=true' \
	  -backend-config='key=terraform.tfstate' \
	  -backend-config='region=eu-west-1'

apply: configure-state
	terraform apply

graph:
	terraform graph | dot -Tpng > graph.png
	open graph.png

plan: configure-state
	terraform plan
