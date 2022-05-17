#!/usr/bin/env bash

# `.bashlava_env.sh`, required by bashlava

### DO NOT update vars directly within `.bashlava_env.sh`
### DO NOT duplicate `.bashlava_env.sh` under your project
### Within your projects, create this config file: `.bashlava_env_override.sh`
CFG_OVERRIDE_WITH_CUSTOM_CONFIG="true"
CFG_CUSTOM_CONFIG_FILE_NAME=".bashlava_env_override.sh"

### Set these env vars via `.bashlava_env_override.sh`
# APP_NAME="notset"
# GITHUB_USER="notset"
# APP_VERSION="0.0.1"

### BRANCH NAMES
CFG_DEFAULT_BRANCH="main"
CFG_DEFAULT_DEV_BRANCH="edge"
CFG_USER_IS="${USER}"

### FUNCTION OPTIONS
CFG_EDGE_EXTENTED="false"   # #edge() not programmed yet
CFG_LOG_LINE_NBR_SHORT="4"  # log() default line number
CFG_LOG_LINE_NBR_LONG="12"  # log() default line number
CFG_RELEASE_POPUP="false"   # TODO
CFG_HELP_ALT="false"        # TODO

CFG_DEBUG_MODE="false"
CFG_LOCK_INIT="false"

### SOURCE /components
#CFG_ARR_COMPONENTS_SCRIPTS
#CFG_ARR_DOCS_MARKDOWN

###	DOCKER IMAGES
DOCKER_IMG_FIGLET="devmtl/figlet:1.0"
DOCKER_IMG_GLOW="devmtl/glow:1.4.1"
