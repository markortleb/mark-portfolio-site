#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")/.."

source "$SCRIPT_DIR/import_env.sh"

CHART_DIR="$PROJECT_ROOT/deploy/chart"

: "${NAMESPACE:?NAMESPACE is required (set it in .env)}"
: "${KUBE_CONTEXT:?KUBE_CONTEXT is required (set it in .env)}"

HELM_RELEASE="${HELM_RELEASE:-${NAMESPACE}-app}"


echo "Running Helm install/upgrade..."

helm upgrade --install "$HELM_RELEASE" "$CHART_DIR" \
  --kube-context "$KUBE_CONTEXT" \
  -n "$NAMESPACE" \
  -f "$CHART_DIR/values.yaml"

echo "Deployment complete in namespace '$NAMESPACE'."