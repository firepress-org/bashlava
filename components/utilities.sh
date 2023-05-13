#!/usr/bin/env bash

function qobuz {

# Source the URLs
_file_is="urls_array.sh" _file_path_is="${_path_bashlava}/private/${_file_is}" && Condition_File_Must_Be_Present
source "${_file_path_is}"

# Check if the urls array is empty
if [ -z "${urls}" ]; then
  my_message="The urls array is empty. Exiting." && Print_Red;
  exit 1
fi

# Show URLs
printf '%s\n' "${urls[@]}" && echo

# Prompt the user to continue
read -p "Do you want to continue? (y/n) " answer
case ${answer:0:1} in
  y|Y )
    echo "Continuing with the following urls?"
    ;;
  * )
    echo "Exiting."
    exit 0
    ;;
esac

DESTINATION="$DIR_DEST_QOBUZ"
mkdir -p "$DESTINATION" && cd "$DESTINATION"

# Loop through the URLs and determine the type of URL
for url in "${urls[@]}"; do
  if [[ $url =~ /artist/ ]]; then
    echo "Downloading artist from $url"
    qobuz-dl dl "$url" -q 27 --albums-only --og-cover
  elif [[ $url =~ /album/ ]]; then
    echo "Downloading album from $url"
    qobuz-dl dl "$url" -q 27 --no-db --og-cover
  elif [[ $url =~ /playlist/ ]]; then
    echo "Downloading playlist from $url"
    qobuz-dl dl "$url" -q 27 --no-db --og-cover
  else
    echo "This URL is not a standard qobuz URL: $url"
  fi
done
# END

# --albums-only
# -q 5 (mp3 320 kbps)
# -q 27 highest quality

}


function Utility_passgen {
  docker run --rm devmtl/alpine:3.11_2020-02-26_08H42s20_dec5798 sh "random7.sh"
}

function Utility_Date {
  date_nano="$(date +%Y-%m-%d_%HH%M_%S-%N)"
    date_sec="$(date +%Y-%m-%d_%HH%M_%S)"
    date_min="$(date +%Y-%m-%d_%HH%M)"

  date_hour="$(date +%Y-%m-%d_%HH)XX"
    date_day="$(date +%Y-%m-%d)"
  date_month="$(date +%Y-%m)-XX"
  date_year="$(date +%Y)-XX-XX"
}


function Utility_Array {
  arr=( "Looping ..." "an array of string" )
  for i in "${arr[@]}"; do
    my_message="${i}" && Print_Gray
  done
}

function Utility_Curl_URL {
# must receive var: url_to_check
  UPTIME_TEST=$(curl -Is ${url_to_check} | grep -io OK | head -1);
  MATCH_UPTIME_TEST1="OK";
  MATCH_UPTIME_TEST2="ok";
  if [[ "${UPTIME_TEST}" = "${MATCH_UPTIME_TEST1}" ]] || [[ "${UPTIME_TEST}" = "${MATCH_UPTIME_TEST2}" ]]; then
    my_message="${url_to_check} <== is online" && Print_Green
  elif [[ "${UPTIME_TEST}" != "${MATCH_UPTIME_TEST1}" ]] || [[ "${UPTIME_TEST}" = "${MATCH_UPTIME_TEST2}" ]]; then
    my_message="${url_to_check} <== is offline" && Print_Warning
    my_message="The git up repo URL is not responding." && Print_Fatal
  fi
}

function Utility_readme {
cat << EOF > README_template.md
This README is still empty.
EOF
}

# optional as not everyone needs this option
function Utility_dockerignore {
cat << EOF > .dockerignore_template
.cache
coverage
dist
node_modules
npm-debug
.git
EOF
}

function Utility_license {
# two things two update here
# project URL
# URL to LICENSE.md (you should fork it)
cat << EOF > LICENSE_template
Copyright (C) 2022
by Pascal Andy | https://pascalandy.com/blog/now/

Project:
https://github.com/owner-here/project-here

At the essence, you have to credit the author AND you have
to keep the code free AND you have to keep the code open-source AND you 
cannot repackage this code for any commercial endeavour.

Find the GNU General Public License V3 at:
https://github.com/pascalandy/GNU-GENERAL-PUBLIC-LICENSE/blob/master/LICENSE.md
EOF
my_message="File created: ${local_path_bashlava}/LICENSE_template" Print_Green
}

function Utility_dockerfile {
cat << EOF > Dockerfile_template
###################################
# REQUIRED for bashLaVa https://github.com/firepress-org/bashlava
# REQUIRED for Github Action CI template https://github.com/firepress-org/ghostfire/tree/master/.github/workflows
###################################

ARG APP_NAME="notset"
ARG VERSION="notset"
ARG RELEASE="notset"
ARG GITHUB_USER="notset"
ARG GITHUB_ORG="notset"
ARG DOCKERHUB_USER="notset"
ARG GITHUB_REGISTRY="notset"

###################################
# Start you Dockerfile from here (if any)
###################################

EOF
my_message="File created: ${local_path_bashlava}/Dockerfile_template" Print_Green
}

function Utility_gitignore {
cat <<EOF > .gitignore_template
# Files
############
custom_*.sh
env_local_path.sh
.env
.cache
coverage
dist
node_modules
npm-debug

# Directories
############
/tmp
/temp

# Compiled source #
###################
*.com
*.class
*.dll
*.exe
*.o
*.so

# Packages #
############
# it's better to unpack these files and commit the raw source
# git has its own built in compression methods
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases #
######################
*.log
*.sql
*.sqlite

# OS generated files #
######################
.DS_Store
.DS_Store?
custom_*.sh
.vscode
.Trashes
ehthumbs.db
Thumbs.db
.AppleDouble
.LSOverride
.metadata_never_index

# Thumbnails
############
._*

# Icon must end with two \r
###########################
Icon

# Files that might appear in the root of a volume
#################################################
.DocumentRevisions-V100
.fseventsd
.dbfseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.trash
.VolumeIcon.icns
.com.apple.timemachine.donotpresent
.com.apple.timemachine.supported
.PKInstallSandboxManager
.PKInstallSandboxManager-SystemSoftware
.file
.hotfiles.btree
.quota.ops.user
.quota.user
.quota.ops.group
.quota.group
.vol
.efi

# Directories potentially created on remote AFP share
#####################################################
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk
.Mobile*
.disk_*

# Sherlock files
################
TheFindByContentFolder
TheVolumeSettingsFolder
.FBCIndex
.FBCSemaphoreFile
.FBCLockFolder
EOF
my_message="File created: ${local_path_bashlava}/Utility_gitignore" Print_Green
}
