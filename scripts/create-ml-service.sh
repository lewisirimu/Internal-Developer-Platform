#!/bin/bash
# scripts/create-ml-service.sh
# Scaffolds a new ML service into the IDP platform

set -eo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 <service-name>"
    exit 1
fi

SERVICE_NAME=$1
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

# 1. Scaffold src directory
echo "Scaffolding source directory for $SERVICE_NAME..."
mkdir -p "$ROOT_DIR/src/$SERVICE_NAME"
cp -r "$ROOT_DIR/src/example-service/" "$ROOT_DIR/src/$SERVICE_NAME/"

# 2. Scaffold values.yaml for Helm
echo "Creating Helm values.yaml override..."
mkdir -p "$ROOT_DIR/infra/environments/dev/values"
cat <<EOF > "$ROOT_DIR/infra/environments/dev/values/$SERVICE_NAME-values.yaml"
# Auto-generated values for $SERVICE_NAME (dev environment)
image:
  repository: my-org/$SERVICE_NAME
  tag: latest
resources:
  limits:
    cpu: "2"
    memory: "4Gi"
  requests:
    cpu: "1"
    memory: "2Gi"
EOF

# 3. Add to Terraform workspace (Simplified simulation)
echo "Adding to Terraform dev environment..."
cat <<EOF >> "$ROOT_DIR/infra/environments/dev/main.tf"

module "ml_service_$SERVICE_NAME" {
  source            = "../../modules/ml-service"
  service_name      = "$SERVICE_NAME"
  environment       = "dev"
  oidc_provider_arn = local.oidc_provider_arn
  oidc_provider_url = local.oidc_provider_url
}
EOF

echo "✅ Successfully scaffolded service $SERVICE_NAME!"
echo "Next steps:"
echo "1. Cd to src/$SERVICE_NAME and update the code."
echo "2. Commit and push on a feature branch."
