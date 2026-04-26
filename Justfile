

up-local:
	bash deploy/scripts/stand_up_local.sh

down-local:
	bash deploy/scripts/stand_down_local.sh

up-prod:
	bash deploy/scripts/stand_up_prod.sh

down-prod:
	bash deploy/scripts/stand_down_prod.sh

build-image:
	bash -lc 'docker build -t "registry.gitlab.com/mark4501703/mark-portfolio-site:latest" .'

push-image:
	bash -lc 'docker push "registry.gitlab.com/mark4501703/mark-portfolio-site:latest"'

build-and-push: build-image push-image

build-and-push-multiarch:
	bash -lc 'docker buildx build --platform linux/amd64,linux/arm64 -t "registry.gitlab.com/mark4501703/mark-portfolio-site:latest" --push .'

dev:
	bash -lc 'LOCAL_TEST_PORT="${LOCAL_TEST_PORT:-4173}" && cd src && python3 -m http.server "${LOCAL_TEST_PORT}"'

docker-run-local:
	bash -lc 'LOCAL_DOCKER_PORT="${LOCAL_DOCKER_PORT:-8081}" && docker run --rm -p "${LOCAL_DOCKER_PORT}:80" "registry.gitlab.com/mark4501703/mark-portfolio-site:latest"'

port-forward-local:
	bash -lc 'source deploy/scripts/import_env.sh && PF_PORT="${PF_PORT:-8080}" && KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}" kubectl -n "$NAMESPACE" port-forward svc/"$NAMESPACE-app" "$PF_PORT":80'

port-forward-prod:
	bash -lc 'source deploy/scripts/import_env.sh && PF_PORT="${PF_PORT:-8080}" && KUBECONFIG="${KUBECONFIG:-$HOME/.kube/k3s-vps.yaml}" kubectl -n "$NAMESPACE" port-forward svc/"$NAMESPACE-app" "$PF_PORT":80'

stop-port-forward-local:
	bash -lc 'source deploy/scripts/import_env.sh && PF_PORT="${PF_PORT:-8080}" && pgrep -f "kubectl.*port-forward.*svc/$NAMESPACE-app.*$PF_PORT:80" | xargs -r kill'

stop-port-forward-prod:
	bash -lc 'source deploy/scripts/import_env.sh && PF_PORT="${PF_PORT:-8080}" && pgrep -f "kubectl.*port-forward.*svc/$NAMESPACE-app.*$PF_PORT:80" | xargs -r kill'
