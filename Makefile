# MAKEFLAGS += --silent
VENV_NAME = .venv
VENV_ACTIVATE = $(VENV_NAME)/bin/activate

# Colors for echos
ccend = $(shell tput sgr0)
ccso = $(shell tput smso)

# Target to create virtual environment
.PHONY : venv
venv:
	@echo "$(ccso)Creating virtual environment$(ccend)"
	python3 -m pip install --upgrade pip
	python3 -m pip install virtualenv
	virtualenv $(VENV_NAME)
	@echo "$(ccso)Activating virtual environment$(ccend)"
	@. $(VENV_ACTIVATE) && echo "$(ccso)Virtual environment activated$(ccend)"
	@echo "$(ccso)Installing requirements$(ccend)"
	@$(VENV_NAME)/bin/pip install -r requirements.txt

# Target to run the application
.PHONY : run-and-start-containers
run-and-start-containers: venv
	@echo "$(ccso)Starting Docker containers$(ccend)"
	@. $(VENV_ACTIVATE) && docker-compose up -d
	@echo "$(ccso)Running the application$(ccend)"
	@. $(VENV_ACTIVATE) && $(VENV_NAME)/bin/python3 dockercheck

# Target to hit the /health endpoint
.PHONY : test-health
test-health:
	@echo "$(ccso)Hitting the /health endpoint$(ccend)"
	@curl -s http://localhost:8080/health
# Target to stop Docker container
.PHONY : stop-containers
stop-containers:
	@echo "$(ccso)Stopping Docker containers$(ccend)"
	@docker-compose down

# Target to delete virtual environment
.PHONY : clean
clean:
	@echo "$(ccso)Deleting virtual environment$(ccend)"
	@rm -rf $(VENV_NAME)
