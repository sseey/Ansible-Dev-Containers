# Variables
REQUIREMENTS_FILE=requirements.txt
TEST_PLAYBOOK=test-playbook.yml
INVENTORY_FILE=inventory

# Installation des dépendances et création du playbook de test
install:
	pip install --upgrade pip
	pip install --no-cache-dir -r $(REQUIREMENTS_FILE)
	$(MAKE) create-test-playbook
	$(MAKE) create-inventory

# Créer un playbook de test
create-test-playbook:
	@echo "---" > $(TEST_PLAYBOOK)
	@echo "- name: Test Ansible Playbook" >> $(TEST_PLAYBOOK)
	@echo "  hosts: localhost" >> $(TEST_PLAYBOOK)
	@echo "  connection: local" >> $(TEST_PLAYBOOK)
	@echo "  tasks:" >> $(TEST_PLAYBOOK)
	@echo "    - name: Ping localhost" >> $(TEST_PLAYBOOK)
	@echo "      ansible.builtin.ping:" >> $(TEST_PLAYBOOK)

# Créer un fichier d'inventaire minimal
create-inventory:
	@echo "localhost ansible_connection=local" > $(INVENTORY_FILE)

# Nettoyer les caches et fichiers temporaires
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -exec rm -f {} +
	rm -rf .pytest_cache .molecule $(TEST_PLAYBOOK) $(INVENTORY_FILE)

# Lancer un test Ansible minimal
test-ansible:
	ansible-playbook -i $(INVENTORY_FILE) $(TEST_PLAYBOOK)

# Lint des playbooks avec ansible-lint
lint:
	ansible-lint .

# Vérifier les fichiers YAML avec yamllint
lint-yaml:
	yamllint .

# Aide
help:
	@echo "Usage:"
	@echo "  make install         Install dependencies and create a test playbook"
	@echo "  make create-test-playbook   Generate a minimal Ansible playbook"
	@echo "  make create-inventory   Generate a minimal inventory file"
	@echo "  make clean           Remove temporary files and caches"
	@echo "  make test-ansible    Run a minimal Ansible playbook to test"
	@echo "  make lint            Run ansible-lint on playbooks"
	@echo "  make lint-yaml       Check YAML files with yamllint"
	@echo "  make help            Show this help message"
