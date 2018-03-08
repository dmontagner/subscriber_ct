#BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
#ifeq ($(BRANCH),master)
#  IMAGE_TAG = latest
#else
#  IMAGE_TAG = $(BRANCH)
#endif

IMAGE_TAG = latest
TEST_TAG=unittest

PWD = $(shell pwd)
VAR_FILE ?= subscriber_ct.params
DOCKER_FILE = docker-compose.yml
DOCKER_FILE_P = docker-compose-persistent.yml
TIME ?= 1m
TAG ?= all
NBR ?= 1

#Load params file with all variables
include $(VAR_FILE)

# Define run options for Docker-compose
RUN_OPTIONS = IMAGE_TAG=$(IMAGE_TAG)

build: build-main

build-main:
	@echo "======================================================================"
	@echo "Build Docker image - $(MAIN_CONTAINER_NAME)_$(INPUT_SUB_IMAGE_NAME):$(IMAGE_TAG)"
	@echo "======================================================================"
	$(RUN_OPTIONS) docker-compose -f $(DOCKER_FILE) up --build

cli:
	docker exec -i -t $(MAIN_CONTAINER_NAME)_$(INPUT_SUB_IMAGE_NAME) /bin/bash

start:
	@echo "Use docker compose file: $(DOCKER_FILE)"
	$(RUN_OPTIONS) docker-compose -f $(DOCKER_FILE) up -d

start-persistent:
	@echo "Use docker compose file: $(DOCKER_FILE_P)"
	$(RUN_OPTIONS) docker-compose -f $(DOCKER_FILE_P) up -d

stop:
	@echo "Use docker compose file: $(DOCKER_FILE)"
	$(RUN_OPTIONS) docker-compose -f $(DOCKER_FILE) down

stop-persistent:
	@echo "Use docker compose file: $(DOCKER_FILE_P)"
	$(RUN_OPTIONS) docker-compose -f $(DOCKER_FILE_P) down

restart: restart-main

restart-main:
	$(RUN_OPTIONS) docker-compose -f $(DOCKER_FILE) restart subscriber_ct


