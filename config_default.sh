#!/usr/bin/env bash

# config_default.sh, required by bashlava

### You should overide these via config_default.sh
APP_NAME="app_no_name"
APP_VERSION="0.1.0"
GITHUB_USER="mira"
DOCKERHUB_USER="mira"
GITHUB_REGISTRY="mira"

### SANE DEFAULTS
DEFAULT_BRANCH="main"
USER_IS="${USER}"
DEFAULT_DEV_BRANCH="edge_${USER_IS}"


### SET PATHS


### SOURCE FILES


### FCT OPTIONS
EDGE_EXTENTED="false" # not programmed yet.

### GH CLI OPTION
# i like to bypass some prompts the cli is asking

# CMD CONFIGS
LOG__LINE_NBR_SHORT="4"
LOG__LINE_NBR_LONG="12"

# Override default values
USE_CONFIG_CUSTOM="false"

  # set only if it has no value currently
  ${LOG__LINE_NBR_VERY_LONG:=30}

