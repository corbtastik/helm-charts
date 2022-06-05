NAMESPACE=dev
RELEASE=todos-webui-v1

install:
	@helm install --namespace $(NAMESPACE) \
		--set todos.webui.services.internal.enabled=true \
		--set todos.webui.services.external.enabled=false \
		$(RELEASE) src/todos-webui

install-lb:
	@helm install --namespace $(NAMESPACE) \
		--set todos.webui.services.internal.enabled=false \
		--set todos.webui.services.external.enabled=true \
		$(RELEASE) src/todos-webui

uninstall:
	@helm uninstall --namespace $(NAMESPACE) $(RELEASE)

render:
	@mkdir -p .rendered/
	@helm template --namespace $(NAMESPACE) \
		$(RELEASE) src/todos-webui > .rendered/$(RELEASE).yaml

client-server-certs:
	@./scripts/client-server-certs.sh
