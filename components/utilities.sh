#!/usr/bin/env bash

function Utility_passgen {
  docker run --rm devmtl/alpine:3.11_2020-02-26_08H42s20_dec5798 sh "random7.sh"
}

function Rename_MD_Files_DoubleSpaces {

  // TODO, prompt the user for the source_dir
  // dry-run mode by default
  // 
  source_dir="/Users/andy16/Documents/_my_docs/51_office_CV/vault_obsidian/_cards"

  # Find all .md files in the source directory and its subdirectories
  files=$(find "$source_dir" -type f -name "*.md" -print)

  # Iterate over each file
  while IFS= read -r file; do
    # Extract the file name from the file path
    filename=$(basename "$file")
    
    # Check if the file name contains two or more spaces
    if [[ "$filename" =~ .*[[:space:]]{2,}.* ]]; then
      echo "BEFORE: $filename"
      
      # Create a new file name by removing extra spaces
      new_filename=$(echo "$filename" | sed -E 's/[[:space:]]{2,}/ /g')
      
      # Rename the file
      mv "$file" "$(dirname "$file")/$new_filename"
      echo "AFTER : $new_filename"
      sleep 0.1
    fi

  done <<< "$files"
}

function gpt_tot {

# obsidian: ChatGPT Prompt Engineering 7 steps Tree of Thoughts (ToT)

clear

# Define input variables
ACT_AS="Act as a Psychologist and Relationship Expert."
IN_11A="$ACT_AS Your task is to help the user solve their problem."
IN_11B="My Problem = I have the following problem. I think I want to break up with my girlfriend. I am 27 years old. I feel our relationship is at a stagnation point. Nothing bad has happened, but I fear we have grown apart and have different views on life. We have been a couple for 6 years."
IN_11C='What approach should I take when I tell her I am breaking up? Could you brainstorm three distinct solutions? Please consider the 3 most important factors that will have an impact on the outcome!'
IN_11D="Your response should be formatted in Markdown within a code block."

# Define which CLI to use. In this case: https://github.com/0xacx/chatGPT-shell-cli
CHATGPT_CMD="chatgpt"

# Function to generate output
generate_output() {
  local input=$1
  local output=$(echo "$input" | $CHATGPT_CMD)
  echo "$output"
}

# Define prompts
PROMPT_12="For each of the three proposed solutions, evaluate their potential. Consider their pros and cons, initial effort needed, implementation difficulty, potential challenges, and the expected outcomes. Assign a probability of success and a confidence level to each option based on these factors."
PROMPT_13="Please remove the two lowest-rated ideas based on '$OUT_12' and keep the best suggestion. Rewrite a compressed summary."
PROMPT_14="Could you brainstorm two new creative and unique distinct solutions to the [My Problem] and include the following idea [Winning Idea] so we now have 3 ideas. Please consider the 3 most important factors that will have an impact on the outcome."
PROMPT_15="From all the possibilities, give me one recommendation. Tell me why you recommend it and then please share the pros and cons."

clear
echo "Tree of Thoughts for: $ACT_AS"

# Generate outputs
OUT_11=$(generate_output "$IN_11A $IN_11B $IN_11C $IN_11D")
echo -ne "Progress: 10% complete\r"

retry_count=0
while [ $retry_count -lt 5 ]; do
  OUT_12=$(generate_output "$OUT_11 $PROMPT_12")
  if ! echo "$OUT_12" | grep -qE "I'm sorry, but|I cannot"; then
    break
  fi
  ((retry_count++))
  echo -ne "Retry #$retry_count for OUT_12...  \r"
done
echo -ne "Progress: 30% complete\r"

retry_count=0
while [ $retry_count -lt 5 ]; do
  OUT_13=$(generate_output "Based on '$OUT_12', $PROMPT_13")
  if ! echo "$OUT_13" | grep -qE "I'm sorry, but|I cannot"; then
    break
  fi
  ((retry_count++))
  echo -ne "Retry #$retry_count for OUT_13...  \r"
done
echo -ne "Progress: 50% complete\r"

OUT_14A=$(generate_output "$OUT_11 Winning Idea = $OUT_13 $PROMPT_14")
echo -ne "Progress: 60% complete\r"
OUT_14B=$(generate_output "$OUT_11 Winning Idea = $OUT_13 $PROMPT_14")
echo -ne "Progress: 70% complete\r"
OUT_14C=$(generate_output "$OUT_11 Winning Idea = $OUT_13 $PROMPT_14")
echo -ne "Progress: 80% complete\r"
OUT_14D=$(generate_output "$OUT_11 Winning Idea = $OUT_13 $PROMPT_14")
echo -ne "Progress: 90% complete\r"
OUT_15=$(generate_output "$IN_11A $IN_11B My ideas are: $OUT_14A $OUT_14B $OUT_14C $OUT_14D $PROMPT_15")
echo -ne "Progress: 100% complete\r\n"

# Print outputs with formatted sections
echo "OUT_11:"
echo "$OUT_11"
echo
echo "OUT_12:"
echo "$OUT_12"
echo
echo "OUT_13:"
echo "$OUT_13"
echo
echo "OUT_14A:"
echo
echo "$OUT_14A"
echo
echo "OUT_14B:"
echo "$OUT_14B"
echo
echo "OUT_14C:"
echo "$OUT_14C"
echo
echo "OUT_14D:"
echo "$OUT_14D"
echo
echo "OUT_15:"
echo "$OUT_15"

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
