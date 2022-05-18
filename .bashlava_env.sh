#!/usr/bin/env bash

# `.bashlava_env.sh`, required by bashlava

### DO NOT update vars directly within `.bashlava_env.sh`
### Within your projects, create this config file: `.bashlava_env_override.sh`
CFG_OVERRIDE_WITH_CUSTOM_CONFIG="true"
CFG_CUSTOM_CONFIG_FILE_NAME=".bashlava_env_override.sh"

CFG_USE_PRIVATE_DIRECTORY="false"

### Set these env vars via `.bashlava_env_override.sh`
# APP_NAME="notset"
# GITHUB_USER="notset"
# APP_VERSION="0.0.1"

### BRANCH NAMES
CFG_DEFAULT_BRANCH="main"
CFG_DEFAULT_DEV_BRANCH="edge"
CFG_USER_IS="${USER}"

### FUNCTION OPTIONS
CFG_EDGE_EXTENTED="false"       # not coded yet
CFG_LOG_LINE_NBR_SHORT="4"      # log() default line number
CFG_LOG_LINE_NBR_LONG="12"      # log() default line number
CFG_RELEASE_POPUP="false"       # not coded yet

CFG_TEST_SHOW_VARS="false"      # test extension
CFG_TEST_OPTIONAL_APPS="false"  # test extension

CFG_DEBUG_MODE="false"
CFG_LOCK_INIT="false"

### SOURCE /components
# CFG_LIST_OF_REQ_COMPONENTS
# CFG_LIST_OF_REQ_MARKDOWN
# CFG_LIST_OF_OPTIONAL_APPS

###	DOCKER IMAGES
DOCKER_IMG_FIGLET="devmtl/figlet:1.0"
DOCKER_IMG_GLOW="devmtl/glow:1.4.1"
