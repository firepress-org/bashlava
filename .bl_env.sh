#!/usr/bin/env bash

### DO NOT update these vars (`.bl_env.sh`)
### Override vars from `.bl_override.sh` Get template https://github.com/firepress-org/mycrypt/blob/master/.bl_override.sh
APP_NAME="bashlava"
GITHUB_USER="firepress-org"
APP_VERSION="1.50.1"

### DEFAULT CONFIGS BELOW

### branch names
CFG_DEFAULT_BRANCH="main"
CFG_DEFAULT_DEV_BRANCH="edge"
CFG_USER_IS="${USER}"

### manage your custom scripts under this directory /private/**.sh
CFG_USE_PRIVATE_DIRECTORY="false"
CFG_USE_GPG_SIGNATURE="false"

### edge
CFG_EDGE_EXTENTED="false"       # not coded yet

### log()
CFG_LOG_LINE_NBR_SHORT="4"      # log() default line number
CFG_LOG_LINE_NBR_LONG="12"      # log() default line number

### dummy()
CFG_DUMMY_CUSTOM_MSG="false"
CFG_DUMMY_CUSTOM_MSG_IS="Alt dummy message"

CFG_RELEASE_POPUP="false"       # not coded yet
CFG_TEST_SHOW_VARS="false"      # test extension
CFG_TEST_OPTIONAL_APPS="false"  # test extension
CFG_DEBUG_MODE="false"
CFG_LOCK_INIT="false"

### docker images
DOCKER_IMG_FIGLET="devmtl/figlet:1.0"
DOCKER_IMG_GLOW="devmtl/glow:1.4.1"

### source array. See FLAG 654
# CFG_LIST_OF_REQ_COMPONENTS
# CFG_LIST_OF_REQ_MARKDOWN
# CFG_LIST_OF_OPTIONAL_APPS

### DO NOT OVERRIDE
DEFAULT_CONFIG_FILE_NAME_IS=".bl_env.sh"
### DO NOT OVERRIDE
### You must create this file in your project
OVERRIDE_CONFIG_FILE_NAME_IS=".bl_override.sh"