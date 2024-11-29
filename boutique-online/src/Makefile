# Detectar automáticamente los directorios como componentes
COMPONENTS := $(shell find . -maxdepth 1 -type d -not -path '*/\.*' -not -name '.' -exec basename {} \;)

# Ruta relativa a los manifiestos de cada componente
DEPLOYMENTS := $(foreach COMPONENT, $(COMPONENTS), $(COMPONENT)/deployment/kubernetes-manifests.yaml)

# Regla principal: aplica todos los manifiestos YAML para los componentes
deploy:
	@echo "Deploying components: $(COMPONENTS)"
	@if [ -z "$(COMPONENTS)" ]; then \
		echo "Error: No components found in the current directory."; \
		exit 1; \
	fi; \
	for manifest in $(DEPLOYMENTS); do \
		COMPONENT=$$(echo $$manifest | cut -d '/' -f 1); \
		echo "Applying $$manifest with COMPONENT=$$COMPONENT"; \
		TF_VAR_REGISTRY_URL=$(TF_VAR_REGISTRY_URL) COMPONENT=$$COMPONENT envsubst '$${TF_VAR_REGISTRY_URL} $${COMPONENT}' < $$manifest | kubectl apply -f -; \
	done

# Regla para eliminar todos los recursos
clean:
	@echo "Deleting components: $(COMPONENTS)"
	@if [ -z "$(COMPONENTS)" ]; then \
		echo "Error: No components found in the current directory."; \
		exit 1; \
	fi; \
	for manifest in $(DEPLOYMENTS); do \
		COMPONENT=$$(echo $$manifest | cut -d '/' -f 1); \
		echo "Deleting $$manifest with COMPONENT=$$COMPONENT"; \
		TF_VAR_REGISTRY_URL=$(TF_VAR_REGISTRY_URL) COMPONENT=$$COMPONENT envsubst '$${TF_VAR_REGISTRY_URL} $${COMPONENT}' < $$manifest | kubectl delete -f -; \
	done

