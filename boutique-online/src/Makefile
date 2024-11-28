COMPONENTS := $(shell echo $(TF_VAR_APPLICATIONS) | tr -d '[]" ' | tr ',' '\n')

# Ruta relativa a los manifiestos de cada componente
DEPLOYMENTS := $(foreach COMPONENT, $(COMPONENTS), $(COMPONENT)/deployment/kubernetes-manifests.yaml)

# Regla principal: aplica todos los manifiestos YAML para los componentes
deploy:
	@echo "Deploying components: $(COMPONENTS)"
	@for manifest in $(DEPLOYMENTS); do \
		echo "Applying $$manifest"; \
		kubectl apply -f $$manifest; \
	done

# Regla para eliminar todos los recursos
clean:
	@echo "Deleting components: $(COMPONENTS)"
	@for manifest in $(DEPLOYMENTS); do \
		echo "Deleting $$manifest"; \
		kubectl delete -f $$manifest; \
	done

