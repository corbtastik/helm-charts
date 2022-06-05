NAMESPACE=todos-webui
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

install-istio:
	@helm install --namespace $(NAMESPACE) \
		--set istio.enabled=true \
		--set istio.gateway.enabled=true \
		--set istio.gateway.TLS.enabled=false \
		--set todos.webui.services.internal.enabled=true \
		--set todos.webui.services.external.enabled=false \
		$(RELEASE) src/todos-webui

test-istio:
	curl -v -HHost:todos-webui.todos.io \
		--resolve "todos-webui.todos.io:$INGRESS_PORT:$INGRESS_HOST" \
		http://todos-webui.todos.io:$INGRESS_PORT/about

install-secure-istio:
	@helm install --namespace $(NAMESPACE) \
		--set istio.enabled=true \
		--set istio.gateway.enabled=true \
		--set istio.gateway.TLS.enabled=true \
		--set todos.webui.services.internal.enabled=true \
		--set todos.webui.services.external.enabled=false \
		$(RELEASE) src/todos-webui

test-secure-istio:
	curl -v -HHost:todos-webui.todos.io \
		--resolve "todos-webui.todos.io:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
    	--cacert .generated/todos.io.crt "https://todos-webui.todos.io:$SECURE_INGRESS_PORT/about"

uninstall:
	@helm uninstall --namespace $(NAMESPACE) $(RELEASE)

render:
	@mkdir -p .generated/
	@helm template --namespace $(NAMESPACE) \
		$(RELEASE) src/todos-webui > .generated/$(RELEASE).yaml

client-server-certs:
	@./scripts/client-server-certs.sh \
		--ORG 'Todos Inc.' \
		--DOMAIN 'todos.io' \
		--SUB_DOMAIN 'todos-webui' > /dev/null 2>&1

clean-certs:
	@rm -rf .generated/*.crt && rm -rf .generated/*.csr && rm -rf .generated/*.key
