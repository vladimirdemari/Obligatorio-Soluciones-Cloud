# Lista de componentes obtenida desde la variable de entorno
COMPONENTS := $(shell echo $(TF_VAR_APPLICATIONS) | tr -d '[]" ' | tr ',' '\n')

# Ruta relativa a los manifiestos de cada componente
DEPLOYMENTS := $(foreach COMPONENT, $(COMPONENTS), $(COMPONENT)/deployment/kubernetes-manifests.yaml)

# Regla principal: aplica todos los manifiestos YAML para los componentes
deploy:
	@echo "Deploying components: $(COMPONENTS)"
	@for manifest in $(DEPLOYMENTS); do \
		COMPONENT=$$(echo $$manifest | cut -d '/' -f 1); \
		echo "Applying $$manifest with COMPONENT=$$COMPONENT"; \
		REGISTRY_URL=$(REGISTRY_URL) COMPONENT=$$COMPONENT envsubst '$${REGISTRY_URL} $${COMPONENT}' < $$manifest | microk8s.kubectl apply -f -; \
	done

# Regla para eliminar todos los recursos
clean:
	@echo "Deleting components: $(COMPONENTS)"
	@for manifest in $(DEPLOYMENTS); do \
		COMPONENT=$$(echo $$manifest | cut -d '/' -f 1); \
		echo "Deleting $$manifest with COMPONENT=$$COMPONENT"; \
		REGISTRY_URL=$(REGISTRY_URL) COMPONENT=$$COMPONENT envsubst '$${REGISTRY_URL} $${COMPONENT}' < $$manifest | microk8s.kubectl delete -f -; \
	done

