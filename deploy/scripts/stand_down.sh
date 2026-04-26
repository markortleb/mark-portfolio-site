#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/import_env.sh"

: "${NAMESPACE:?NAMESPACE is required (set it in .env)}"
: "${KUBE_CONTEXT:?KUBE_CONTEXT is required (set it in .env)}"

HELM_RELEASE="${HELM_RELEASE:-${NAMESPACE}-app}"

echo "Deleting Helm release '$HELM_RELEASE' in namespace '$NAMESPACE'..."
helm uninstall "$HELM_RELEASE" --kube-context "$KUBE_CONTEXT" -n "$NAMESPACE" || true