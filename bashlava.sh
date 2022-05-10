#!/usr/bin/env bash

: '
// START COMMENT BLOCK
To-Do comment section. Total of 4

_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
PINNED issues on GH             _
  issue #4 TO-DO & backlog       _
  issue #8 UX                   _
  issue #9 Bugfix               _
  issue #10 Logic & Condition   _
  issue #11 docs                _
                                _
PR Title: New Feat: 0o0o
- 0o0o
- 0o0o
- Impact on: #4, #8, #9 #10
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _


PRIORITY 1 ____________________________________________________________________________
_______________________________________________________________________________________


TODO
UX: Improve how we manage CONFIGS, vars, sane defaults, logic overrides
- At the moment, its too complex for a new user to configure bashlava
- Avoid having multiple place to define them, source components, source .md
- Few array that are configs. They should be all together under the same block of code.
- Decouple logic using files: config_default.sh and config_custom.sh

Functional impacts:
- Dockerfile file should not be the default place to store configs
    Core_Load_Vars_General
    Core_Load_Vars_Dockerfile
    Core_Load_Vars_Edge
    Core_Check_Which_File_Exist
- File: to check VERSUS file to source
- Extended Test: Show all var and config (debug)
- Think about private scripts trigger
- Think about gcrypt dir VERSUS private dir (.gitignore)
- Impact on: #4, #8, #10


TODO private scripts
logical flags to manage under /private/*
Need to check if files exist /private/* when DIR private exist
Need logic to manage file under /private/*  fct VERSUS public fct
overide like:
- Dockerfile versionning VS config_custom.sh
- favorite URL
- custom_fct_opensite="true" # during pr, merg
- custom_fct_help="false"
- set a new config flag: debug="true"


TODO
## App if app are installed
  which git-crypt
  which gnupg
  which shellcheck
  which openssl
  which sha256

  if not propose to install them via brew

  if brew ls --versions myformula > /dev/null; then
    The package is installed
  else
    The package is not installed
  fi


TODO
optimize my_message when calling
  Print_
  Banner_

Instead of creating custom var simnply use %1 %2 <=dollar sign

  function greet () {
    echo "Hello @1"
  }
  greet "Pascal"


TODO ci pipeline
- superlinter (includes shellcheck)
- create ci for using shellcheck
- run test()

TODO git-crypt
once gitcrypt to well test and solid, push V2


PRIORITY 2 ____________________________________________________________________________
_______________________________________________________________________________________


0o0o EDGE_EXTENTED
  edge() prompt user

  OPTIONS ARE:
  1) CREATE edge_neW      and DELETE edge_olD (default)
  2) CREATE edge_neW      and KEEP edge_olD
  3) CREATE custom_neW    and DELETE edge_olD only
  4) CREATE custom_neW    and KEEP edge_olD only

  (Your branch name for edge is located .. path here )
  - Impact on: #4, #8

0o0o Show_Docs()
works but not clean, but it works mdv() / Show_Docs
  we cant provide an absolute path to the file because the Docker container cant the absolute path
  I also DONT want to provide two arguments when using glow
  I might simply stop using a docker container for this
  but as a priciiple, I like to call a docker container

0o0o squash
- function that search for the same commit messages in previous commits
- then suggestion to do a squash, then prompt user y/n

0o0o Show_Fct_Category_F1 , F2
- revisit this function once all file are solid + private logic

0o0o RANDOM NOTES
- multipass.run / shell
- var subtitution example
- GH enviroment (staging, prod)
- re-use workflow
- List files on B2

// END COMMENT BLOCK
'

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
#
# USER FACING FUNCTIONS
#
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
          #
        #
      #
    #
  #
#

function mainbranch { # User_
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending
  Condition_Apps_Must_Be_Installed
  _from_fct="mainbranch"

  Show_Version

  git checkout ${default_branch}
  git pull origin ${default_branch} && echo
  log
}

function edge { # User_
  Condition_Attr_2_Must_Be_Empty       # fct without attributs
  Condition_No_Commits_Pending
  Condition_Apps_Must_Be_Installed
  _from_fct="e"

### Logic to manage and generate unique edge name
### =============================================
_branch_dev_unique=$(cat "${_path_lib}/Application Support/${_path_last_part}")

### Local: delete branch if it exists
  _branch_exist=$(git branch --list "${_branch_dev_unique}" | wc -l)
  # It does not make sens to Condition_Vars_Must_Be_Not_Empty
  if [[ ${_branch_exist} -eq 0 ]]; then
    echo "local: OK branch ${_branch_dev_unique} do not exist" > /dev/null 2>&1
  
  elif [[ ${_branch_exist} -eq 1 ]]; then
    echo "local: OK branch ${_branch_dev_unique} must be deleted"
    git branch -D "${_branch_dev_unique}"
  else 
    my_message="FATAL: ${_branch_dev_unique} (local)" && Print_Fatal
  fi

### Remote: delete branch if it exists
  _branch_exist=$(git ls-remote --heads https://github.com/"${github_user}"/"${app_name}".git "${_branch_dev_unique}" | wc -l)
  # It does not make sens to Condition_Vars_Must_Be_Not_Empty
  if [[ ${_branch_exist} -eq 0 ]]; then
    echo "remote: OK branch ${_branch_dev_unique} do not exist" > /dev/null 2>&1
  elif [[ ${_branch_exist} -eq 1 ]]; then
    echo "remote: OK branch ${_branch_dev_unique} must be deleted"
    git push origin --delete "${_branch_dev_unique}"
  else
    my_message="FATAL: ${_branch_dev_unique} (remote)" && Print_Fatal
  fi

  ### Reset file where we stored the _branch_dev_unique
  if [[ -f "${_path_lib}/Application Support/${_path_last_part}" ]]; then
    echo "File exist. Lets delete it" > /dev/null 2>&1
    rm "${_path_lib}/Application Support/${_path_last_part}"
  fi

  ### Generate _branch_dev_unique and save the name in a file
  if [[ -f "${_path_lib}/Application Support/${_path_last_part}" ]]; then
    my_message="FATAL: File exist, but it should not!" && Print_Fatal
  elif [[ ! -f "${_path_lib}/Application Support/${_path_last_part}" ]]; then
    echo "OK, file do not exit" > /dev/null 2>&1
    _default_edge_prefix="edge" _random_char=$(openssl rand -hex 4 | colrm 4)
    # Store to file
    echo "${_default_edge_prefix}_${_random_char}" > "${_path_lib}/Application Support/${_path_last_part}"
    # Get the new generated _branch_dev_unique
    _branch_dev_unique=$(cat "${_path_lib}/Application Support/${_path_last_part}")
  else
    my_message="FATAL: edge" && Print_Fatal
  fi
  ### =============================================

  git checkout -b "${_branch_dev_unique}"
  echo && echo "push ${_branch_dev_unique} to origin"
  git push --set-upstream origin "${_branch_dev_unique}" -f
  echo && log

  Show_Version

  Show_What_Was_Done
  _doc_name="next_move_fct_edge.md" && Show_Docs
}

function commit { # User_
  Condition_Attr_2_Must_Be_Provided
  _from_fct="c"

  git status && git add -A && git commit -m "${input_2}" && git push

  Show_What_Was_Done
  git --no-pager log --decorate=short --pretty=oneline --abbrev-commit -n4

  _doc_name="fct_c_next.md" && Show_Docs
}

function pr { # User_
  Condition_Branch_Must_Be_Edge
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending
  _from_fct="pr"

  _pr_title=$(git log --format=%B -n 1 "$(git log -1 --pretty=format:"%h")" | cat -)
  _var_name="_pr_title" _is_it_empty="${_pr_title}" && Condition_Vars_Must_Be_Not_Empty

  gh pr create --fill --title "${_pr_title}" --base "${default_branch}" && sleep 1
  gh pr view --web    # if there is a bug see: /docs/debug_upstream.md

  Show_What_Was_Done
  _doc_name="next_move_fct_pr.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | mrg) mrg;;
    2 | ci) ci;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function mrg { # User_
  # merge from edge into main_branch
  Condition_Branch_Must_Be_Edge
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Empty

  gh pr merge --rebase

# Ensure to checkout to main_branch.
# The user maybe did not deleted the PR branch in the previous step (via cli gh pr merge)
  _branch_exist=$(git branch --list "${default_branch}" | wc -l)
    # It does not make sens to Condition_Vars_Must_Be_Not_Empty
  if [[ ${_branch_exist} -eq 0 ]]; then
    echo "OK we are on main_branch. Nothing to do"
  elif [[ ${_branch_exist} -eq 1 ]]; then
    echo "We are not on main_branch. Lets checkout"
    mainbranch
  else 
    my_message="FATAL: ${_branch_dev_unique} (local)" && Print_Fatal
  fi

  Show_Version

  my_message="Current branch is:" && Print_Blue
  git rev-parse --abbrev-ref HEAD

  _from_fct="mrg"
  Show_What_Was_Done
  _doc_name="next_move_fct_mrg.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | v) version;;
    2 | t) tag;;
    3 | e) edge;;
    4 | ci) ci;;
    8 | vt) v_and_t;;
    9 | a) echo "WIP, will allow the user to: v + t + r + e in one step";;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function version { # User_
### The version is stored within the Dockerfile. For BashLaVa, this Dockerfile is just a config-env file
  Condition_No_Commits_Pending
  _from_fct="v"

  Show_Version

  # set input_2 if not provided
  if [[ "${input_2}" == "not_set" ]]; then
    my_message="What is the version number (ex: 1.12.4.)?" && Print_Green
    read -r user_input;
    echo;
    my_message="${user_input}" && Print_Green
    input_2="${user_input}"
    Condition_Version_Must_Be_Valid

  elif [[ "${input_2}" != "not_set" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  else
    my_message="FATAL: (version)" && Print_Fatal
  fi
  

  if [[ "${input_2}" != "not_set" ]]; then

    Condition_Attr_2_Must_Be_Provided
    Condition_Version_Must_Be_Valid

  ### Update version within Dockerfile
    sed -i '' "s/^ARG VERSION=.*$/ARG VERSION=\"${input_2}\"/" Dockerfile
    # code optimization 0o0o, Add logic for /private scripts

    git add .
    git commit . -m "Update ${app_name} to version ${input_2}"
    git push && echo
    Show_Version

    Show_What_Was_Done
    _doc_name="next_move_fct_v.md" && Show_Docs
    input_2="not_set"   #reset input_2
    read -r user_input;
    case ${user_input} in
      1 | t) tag;;
      2 | pr) pr;;
      *) my_message="Aborted" && Print_Gray;;
    esac

  elif [[ "${input_2}" == "not_set" ]]; then
    my_message="ERROR: This should not happen (version)" && Print_Warning_Stop
  else
    my_message="FATAL (version)" && Print_Fatal
  fi
}

function tag { # User_
  Condition_No_Commits_Pending
  #Condition_Attr_2_Must_Be_Empty
  _from_fct="t"

  git tag ${app_version} && git push --tags && echo
  Show_Version

  Show_What_Was_Done
  _doc_name="next_move_fct_tag.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | r) release;;
    2 | ci) ci;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function v_and_t { 
  # version and tag
# TODO
  # I can optimze this later with a flag
  # I need to duplicate v() code because we prompt in version and in tag
### The version is stored within the Dockerfile. For BashLaVa, this Dockerfile is just a config-env file
  Condition_No_Commits_Pending
  _from_fct="v"

  Show_Version

  # set input_2 if not provided
  if [[ "${input_2}" == "not_set" ]]; then
    my_message="What is the version number (ex: 1.12.4.)?" && Print_Green
    read -r user_input;
    echo;
    my_message="${user_input}" && Print_Green
    input_2="${user_input}"
    Condition_Version_Must_Be_Valid

  elif [[ "${input_2}" != "not_set" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  else
    my_message="FATAL: (version)" && Print_Fatal
  fi
  

  if [[ "${input_2}" != "not_set" ]]; then

    Condition_Attr_2_Must_Be_Provided
    Condition_Version_Must_Be_Valid

  ### Update version within Dockerfile
    sed -i '' "s/^ARG VERSION=.*$/ARG VERSION=\"${input_2}\"/" Dockerfile
    # code optimization 0o0o, Add logic for /private scripts

    git add .
    git commit . -m "Update ${app_name} to version ${input_2}"
    git push && echo
    Show_Version
    Show_What_Was_Done
    tag

  elif [[ "${input_2}" == "not_set" ]]; then
    my_message="ERROR: This should not happen (version)" && Print_Warning_Stop
  else
    my_message="FATAL (version)" && Print_Fatal
  fi
}

function tci { # User_
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Empty
  _from_fct="tci"

  _short_hash=$(git rev-parse --short HEAD)
  _tag_name="ci_${app_version}_${_short_hash}"
  _var_name="_short_hash" _is_it_empty="${_short_hash}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="_tag_name" _is_it_empty="${_tag_name}" && Condition_Vars_Must_Be_Not_Empty

  git tag ${_tag_name} && git push --tags && echo
  Show_Version

  Show_What_Was_Done
  _doc_name="next_move_fct_tci.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | r) release;;
    2 | ci) ci;;
    *) my_message="Aborted" && Print_Gray;;
  esac

  #   See this PR: https://github.com/firepress-org/bashlava/pulls?q=is%3Apr+is%3Aclosed+tci
}

function release { # User_
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Empty
  _from_fct="r"

  latest_tag="$(git describe --tags --abbrev=0)"

  # I would like to not have the v in the release https://github.com/cli/cli/issues/5609
  #                'v' is an attribut required by gh cli
  gh release create v"${latest_tag}" --generate-notes && sleep 5
  Show_Version
  Show_Release

  Show_What_Was_Done
  _doc_name="next_move_fct_release.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | e) edge;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function squash { # User_
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Provided # how many steps
  Condition_Attr_3_Must_Be_Provided # message
  _from_fct="sq"

  git --no-pager log --decorate=short --pretty=oneline --abbrev-commit -n15

  if ! [[ "${input_2}" =~ ^[0-9]+$ ]] ; then
    my_message="Oups, syntax error." && Print_Warning_Stop
  else
    echo "Ok, lets squash" > /dev/null 2>&1
  fi

  git reset --soft HEAD~"${input_2}" &&\
  git commit --edit -m "${input_3}" &&\
  git push --force-with-lease &&\
  git pull
  input_2="not_set"   #reset input_2
  log
}

function ci { # User_
  # continuous integration status
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending
  _from_fct="ci"

### show latest build and open webpage on Github Actions
  # gh run list
  _run_id=$(gh run list | head -1 | awk '{print $11}')
  _var_name="_run_id" _is_it_empty="${_run_id}" && Condition_Vars_Must_Be_Not_Empty
  # Opening the run id cuase issues. Lets stick to /actions/
  open https://github.com/${github_user}/${app_name}/actions/

  # Follow status within the terminal
  gh run watch

  Show_What_Was_Done
  _doc_name="next_move_fct_ci.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | y | mrg) mrg;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function dummy { # User_
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending
  _from_fct="d"
  _in_file="./docs/DUMMY.md"

  # create a commit X time the update
  for lineID in $(seq 1 2); do
    date_nano="$(date +%Y-%m-%d_%HH%Ms%S-%N)"
    _hash=$(echo ${date_nano} | sha256sum | awk '{print $1}')
    _hash_four_last="${_hash: -4}"
    echo "Dummy Commit, ${date_sec}, ${_hash}" >> "${_in_file}"
    git add -A && git commit -m "dummy commit ${_hash_four_last}"
    sleep 1
  done

  git push
  log
}

function show { # User_
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending
  _from_fct="s"
  Show_Prompt_All
}

function log { # User_
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending

  echo && git --no-pager log --decorate=short --pretty=oneline --abbrev-commit -n8 && echo
}

function test { # User_
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending
  _from_fct="test"
  # PRINT OPTION 1
  echo && my_message="Check Print_Banner:" && Print_Blue
  my_message="bashLaVa" && Print_Banner

  my_message="Random tests: " Print_Blue
  my_message="\$1 value is: ${input_1}" Print_Gray
  my_message="\$2 value is: ${input_2}" Print_Gray
  my_message="\$3 value is: ${input_3}" Print_Gray
  my_message="\$4 value is: ${input_4}" Print_Gray

  echo
  Condition_Apps_Must_Be_Installed
  my_message="Check apps required: All good!" Print_Gray     # else the Condition will stop the script

  Core_Check_Which_File_Exist
  my_message="Check files and directories: All good!" Print_Gray     # else the Condition will stop the script

  if [[ $(uname) == "Darwin" ]]; then
    my_message="Running on a Mac (Darwin): All good!" Print_Gray
  elif [[ $(uname) != "Darwin" ]]; then
    my_message="bashLaVa is not tested on other machine than Mac OS (Darmin)." && Print_Warning
  else
    my_message="FATAL: Test / Check OS" && Print_Fatal
  fi

  echo
  Utility_Array

  # PRINT OPTION 2
  echo
  my_message="Test mdv:" && Print_Blue
  _doc_name="test.md" && Show_Docs

  # PRINT OPTION 3
  my_message="Test color prints:" && Print_Blue
  my_message="You feel me!?"
  Print_Green
  Print_Blue
  Print_Warning
  Print_Gray
  # Print_Fatal is bypassed as it does an 'exit 0'

  Show_Version
}

function help { # User_
  Condition_Attr_3_Must_Be_Empty
  _from_fct="h"

  clear
  _doc_name="help.md" && Show_Docs
}

function hello { # User_
  _from_fct="hello"
  echo && my_message="NEXT MOVE suggestion: Say hello to a living soul." Print_Green
}

function mdv { # User_
  _from_fct="hmdv"
  Print_mdv
}

function gitio { # User_
  _from_fct="gitio"

  # depends on the selected option below
  function child_gitio {
    clear
    curl -i https://git.io -F \
      "url=https://github.com/${input_2}/${input_3}" \
      -F "code=${input_3}" &&\

    # PREVIEW
    echo && my_message="Let's open: https://git.io/${input_3}" && Print_Blue && sleep 2 &&\
    open https://git.io/${input_3}
  }

  echo
  my_message="URL ........ : https://git.io/${app_name}" && Print_Gray
  my_message="will point to: https://github.com/${github_user}/${app_name}" && Print_Gray
  #output example: https://git.io/bashlava

  # PROMPT
  echo
  my_message="Do you want to continue? (y/n)" && Print_Gray
  read -r user_input;
  case ${user_input} in
    y | Y) child_gitio;;
    *) my_message="Aborted" && Print_Fatal;;
  esac
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
#
# Show
#
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
          #
        #
      #
    #
  #
#

function Show_Version {

  echo && my_message="Check versions:" && Print_Blue
  # Need to reload so the user can see before and after version
  Core_Load_Vars_Dockerfile

  # version in dockerfile
  my_message="${app_version} < VERSION in Dockerfile" Print_Gray

  # tag
  if [[ -n $(git tag -l "${app_version}") ]]; then
    echo "Good, a tag is present" > /dev/null 2>&1
    latest_tag="$(git describe --tags --abbrev=0)"
    _var_name="latest_tag" _is_it_empty="${latest_tag}" && Condition_Vars_Must_Be_Not_Empty
  else
    echo "Logic: new projet don't have any tags. So we must expect that it can be empty" > /dev/null 2>&1
    latest_tag="none "
  fi
  my_message="${latest_tag} < TAG     in ${default_branch}" Print_Gray

  # release
  release_latest=$(curl -s https://api.github.com/repos/${github_user}/${app_name}/releases/latest | \
    grep tag_name | awk -F ': "' '{ print $2 }' | awk -F '",' '{ print $1 }')

  if [[ -z "${release_latest}" ]]; then
    release_latest="none "
    echo "Logic: new projet don't have any release. So we must expect that it can be empty" > /dev/null 2>&1
  elif [[ -n "${release_latest}" ]]; then
    echo "Good, a release is present" > /dev/null 2>&1
    _var_name="release_latest" _is_it_empty="${release_latest}" && Condition_Vars_Must_Be_Not_Empty
  else
    my_message="FATAL: Show_Version | release_latest " && Print_Fatal
  fi

  my_message="${release_latest} < RELEASE on https://github.com/${github_user}/${app_name}/releases/tag/${release_latest}" && Print_Gray
  echo
}

function Show_Release {
  release_latest=$(curl -s https://api.github.com/repos/${github_user}/${app_name}/releases/latest | \
    grep tag_name | awk -F ': "' '{ print $2 }' | awk -F '",' '{ print $1 }')
  _var_name="release_latest" _is_it_empty="${release_latest}" && Condition_Vars_Must_Be_Not_Empty
  open "https://github.com/${github_user}/${app_name}/releases/tag/${release_latest}"
}

function Show_Docs {
  # idempotent checkpoint
  _var_name="docker_img_glow" _is_it_empty="${docker_img_glow}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="_doc_name" _is_it_empty="${_doc_name}" && Condition_Vars_Must_Be_Not_Empty

  _present_path_is="$(pwd)"
  _file_is="${_doc_name}" _file_path_is="${_path_docs}/${_doc_name}" && Condition_File_Must_Be_Present

  cd ${_path_docs} || { echo "FATAL: Show_Docs / cd"; exit 1; }
  docker run --rm -it -v "$(pwd)":/sandbox -w /sandbox ${docker_img_glow} glow -w 110 "${_doc_name}"
  cd ${_present_path_is} || { echo "FATAL: Show_Docs / cd"; exit 1; }
}

function Show_What_Was_Done {
  echo && my_message="(${_from_fct}) was done.                          ${app_name} $(git rev-parse --abbrev-ref HEAD)" && Print_Green
}

function Show_Prompt_All {

  Core_Check_Which_File_Exist
  _doc_name="prompt_show_fct.md" && clear && Show_Docs
  read -r user_input
  case ${user_input} in
    1 | ali) clear && Show_Fct_Category_Alias;;
    2 | cond) clear && Show_Fct_Category_Condition;;
    3 | core) clear && Show_Fct_Category_Core;;
    4 | ex) clear && Show_Fct_Category_Example;;
    5 | pri) clear && Show_Fct_Category_Print;;
    6 | s) clear && Show_Fct_Category_Show;;
    7 | user) clear && Show_Fct_Category_User;;
    8 | util) clear && Show_Fct_Category_Utility;;
    9 | a | all) clear && Show_Fct_Category_All;;
    f1) clear && Show_Fct_Category_F1;;
    f2) clear && Show_Fct_Category_F2;;
    *)
      echo "Aboarded" && exit 1;;
  esac
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
#
# Print : better than echo
#
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
          #
        #
      #
    #
  #
#

function Print_mdv {
  clear
  Condition_Attr_2_Must_Be_Provided

  # markdown viewer (mdv)
  _var_name="docker_img_glow" _is_it_empty="${docker_img_glow}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="input_2" _is_it_empty="${input_2}" && Condition_Vars_Must_Be_Not_Empty
  my_message="Info: 'mdv' can only read markdown files at the same path level" Print_Green
  sleep 0.5

  _present_path_is=$(pwd)
  _file_is="${input_2}" _file_path_is="${_present_path_is}/${input_2}" && Condition_File_Must_Be_Present

  docker run --rm -it -v "$(pwd)":/sandbox -w /sandbox ${docker_img_glow} glow -w 120 "${input_2}"
}

function Print_Banner {
  _var_name="docker_img_figlet" _is_it_empty="${docker_img_figlet}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
  docker run --rm ${docker_img_figlet} ${my_message}
}

# Define colors / https://www.shellhacks.com/bash-colors/
function Print_Gray {
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
  echo -e "\e[1;37m${my_message}\e[0m"
}
function Print_Green {
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
  echo -e "✨ \e[1;32m${my_message}\e[0m"
}
function Print_Blue {
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
  echo -e "🧵 \e[1;34m${my_message}\e[0m 🧵"
}

### Why do we have Print_Warning and Print_Warning_Stop here ?
  # Fatal is usually reserve for unexpected error within bashlava
  # Warning are expected - sometimes we want to stop the function, sometimes we want to continue
function Print_Warning {
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
  echo -e "🚨 \e[1;33m${my_message}\e[0m"
}
function Print_Warning_Stop {
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
  echo -e "   🚨 \e[1;33m${my_message}\e[0m 🚨" && exit 1
}
function Print_Red {
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
  echo -e "   🚨 \e[1;31m${my_message}\e[0m 🚨"
}
function Print_Fatal {
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
  echo -e "   🚨 \e[1;31m${my_message}\e[0m 🚨" && exit 1
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
#
# Conditions functions
#
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
          #
        #
      #
    #
  #
#

function Condition_Branch_Must_Be_Mainbranch {
  echo "function not required yet"
  _compare_me=$(git rev-parse --abbrev-ref HEAD)
  _compare_you="${default_branch}" _fct_is="Condition_Branch_Must_Be_Mainbranch"
  Condition_Vars_Must_Be_Equal
}

function Condition_Branch_Must_Be_Edge {
  _branch_dev_unique=$(cat "${_path_lib}/Application Support/${_path_last_part}")

  _compare_me=$(git rev-parse --abbrev-ref HEAD)
  _compare_you="${_branch_dev_unique}" _fct_is="Condition_Branch_Must_Be_Edge"
  Condition_Vars_Must_Be_Equal
}

function Condition_No_Commits_Pending {
  _compare_me=$(git status | grep -c "nothing to commit")
  _compare_you="1" _fct_is="Condition_No_Commits_Pending"
  Condition_Vars_Must_Be_Equal
}

function Condition_Attr_2_Must_Be_Provided {
  # ensure the second attribute is not empty to continue
  if [[ "${input_2}" == "not_set" ]]; then
    my_message="You must provide two attributes. fct: Condition_Attr_2_Must_Be_Provided" && Print_Warning_Stop
  elif [[ "${input_2}" != "not_set" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_2_Must_Be_Provided" && Print_Fatal
  fi
}

function Condition_Attr_3_Must_Be_Provided {
  # ensure the third attribute is not empty to continue
  if [[ "${input_3}" == "not_set" ]]; then
    my_message="You must provide three attributes. fct: Condition_Attr_3_Must_Be_Provided" && Print_Warning_Stop
  elif [[ "${input_3}" != "not_set" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_3_Must_Be_Provided" && Print_Fatal
  fi
}

function Condition_Attr_4_Must_Be_Provided {
  my_message="Condition_Attr_4_Must_Be_Provided() not needed yet" && Print_Warning
}

function Condition_Attr_2_Must_Be_Empty {
  # Stop if 2 attributes are passed.
  if [[ "${input_2}" != "not_set" ]]; then
      my_message="You can NOT use two attributes. fct: Condition_Attr_2_Must_Be_Empty" && Print_Warning_Stop
  elif [[ "${input_2}" == "not_set" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_2_Must_Be_Empty" && Print_Fatal
  fi
}

function Condition_Attr_3_Must_Be_Empty {
  # Stop if 3 attributes are passed.
  if [[ "${input_3}" != "not_set" ]]; then
      my_message="You can NOT use three attributes. fct: Condition_Attr_3_Must_Be_Empty" && Print_Warning_Stop
  elif [[ "${input_3}" == "not_set" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_3_Must_Be_Empty" && Print_Fatal
  fi
}
function Condition_Attr_4_Must_Be_Empty {
  # Stop if 4 attributes are passed.
  if [[ "${input_4}" != "not_set" ]]; then
      my_message="You cannot use four attributes. fct: Condition_Attr_4_Must_Be_Empty" && Print_Warning && echo
  elif [[ "${input_4}" == "not_set" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_4_Must_Be_Empty" && Print_Fatal
  fi
}

function Condition_Version_Must_Be_Valid {
  # Version is limited to these characters: 1234567890.rR-
  # so we can do: '3.5.13-r3' or '3.5.13-rc3'
  _compare_me=$(echo "${input_2}" | sed 's/[^0123456789.rcRC\-]//g')
  _compare_you="${input_2}" _fct_is="Condition_Version_Must_Be_Valid"
  Condition_Vars_Must_Be_Equal
}

function Condition_Apps_Must_Be_Installed {
  # docker running?
  _compare_me=$(docker version | grep -c "Server: Docker Desktop")
  _compare_you="1" _fct_is="Condition_Apps_Must_Be_Installed"
  Condition_Vars_Must_Be_Equal
  # my_message="Docker is installed" && Print_Gray

  # gh cli installed
  _compare_me=$(gh --version | grep -c "https://github.com/cli/cli/releases/tag/v")
  _compare_you="1" _fct_is="Condition_Apps_Must_Be_Installed"
  Condition_Vars_Must_Be_Equal
  # my_message="gh cli is installed" && Print_Gray
}

function Core_Check_Which_File_Exist {
  # List markdown files under /docs/*
  arr=( "welcome_to_bashlava" "help" "test" "debug_upstream" )
  for action in "${arr[@]}"; do
    _file_is="${action}" _file_path_is="${_path_docs}/${_file_is}.md" && Condition_File_Must_Be_Present
  done

  # List files under /components/*
  arr=( "utilities.sh" "alias.sh" "show_fct_category_filter.sh" "example.sh" "list.txt" )
  for action in "${arr[@]}"; do
    _file_is="${action}" _file_path_is="${_path_components}/${_file_is}" && Condition_File_Must_Be_Present
  done

  _file_is="LICENSE" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="Dockerfile does not exit, let's generate one" && Print_Warning && sleep 2 && Utility_license && exit 1
  fi

  _file_is="README.md" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="Dockerfile does not exit, let's generate one" && Print_Warning && sleep 2 && Utility_readme && exit 1
  fi

  _file_is=".gitignore" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="Dockerfile does not exit, let's generate one" && Print_Warning && sleep 2 && Utility_gitignore && exit 1
  fi

  _file_is="Dockerfile" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="Dockerfile does not exit, let's generate one" && Print_Warning && sleep 2 && Utility_dockerfile && exit 1
  fi

  # Warning only
  _file_is=".dockerignore" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present

  # If it happens, you want to know ASAP
  _file_is=".git" dir_path_is="${_path_bashlava}/${_file_is}" && Condition_Dir_Must_Be_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message=".git directory does not exit" && Print_Fatal
  fi
}

function Condition_File_Must_Be_Present {
  if [[ -f "${_file_path_is}" ]]; then
    echo "idempotent checkpoint passed" > /dev/null 2>&1
  elif [[ ! -f "${_file_path_is}" ]]; then
    my_message="Warning: no file: ${_file_path_is}" && Print_Warning_Stop
  else
    my_message="FATAL: Condition_File_Must_Be_Present | ${_file_path_is}" && Print_Fatal
  fi
}

function Condition_File_Optionnally_Present {
  # This fct return the flag '_file_do_not_exist'
  if [[ -f "${_file_path_is}" ]]; then
    echo "idempotent checkpoint passed" > /dev/null 2>&1
  elif [[ ! -f "${_file_path_is}" ]]; then
    my_message="Warning: no file: ${_file_path_is}" && Print_Warning
    _file_do_not_exist="true"
  else
    my_message="FATAL: Condition_File_Optionnally_Present | ${_file_path_is}" && Print_Fatal
  fi
}

function Condition_Vars_Must_Be_Equal {
  # Think, IF vars are EQUAL, continue else fail the process
  if [[ "${_compare_me}" == "${_compare_you}" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  elif [[ "${_compare_me}" != "${_compare_you}" ]]; then
    my_message="Checkpoint failed '${_fct_is}' ( ${_compare_me} and ${_compare_you} )" && Print_Warning_Stop
  else
    my_message="FATAL: Condition_Vars_Must_Be_Equal | ${_fct_is}" && Print_Fatal
  fi
}

function Condition_Vars_Must_Be_Not_Equal {
  # Think, IF vars are NOT equal, continue else fail the process
  if [[ "${_compare_me}" == "${_compare_you}" ]]; then
    my_message="Checkpoint failed '${_fct_is}' ( ${_compare_me} and ${_compare_you} )" && Print_Warning_Stop
  elif [[ "${_compare_me}" != "${_compare_you}" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  else
    my_message="FATAL: Condition_Vars_Must_Be_Not_Equal | ${_fct_is}" && Print_Fatal
  fi
}

function Condition_Vars_Must_Be_Not_Empty {
  # Think, IF vars is not empty, continue else fail
  # source must send two vars:_is_it_empty AND _var_name
  if [[ -n "${_is_it_empty}" ]]; then    #if not empty
    echo "idempotent checkpoint passed" > /dev/null 2>&1
  elif [[ -z "${_is_it_empty}" ]]; then    #if empty
    my_message="Warning: variable '${_var_name}' is empty" && Print_Warning_Stop
  else
    my_message="FATAL: Condition_Vars_Must_Be_Not_Empty | ${_var_name}" && Print_Fatal
  fi
}

function Condition_Dir_Must_Be_Present {
  # This fct return the flag '_file_do_not_exist'
  if [[ -d "${dir_path_is}" ]]; then
    echo "idempotent checkpoint passed" > /dev/null 2>&1
  elif [[ ! -d "${dir_path_is}" ]]; then
    my_message="Warning: no directory: ${dir_path_is}" && Print_Warning_Stop
  else
    my_message="FATAL: Condition_Dir_Must_Be_Present | ${dir_path_is}" && Print_Fatal
  fi
}

function Condition_Dir_Optionnally_Present {
  echo "function not required yet"
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
#
# Core functions
#
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
          #
        #
      #
    #
  #
#

function Core_Reset_Bashlava_Path {
# In file ${_path_user}/bashlava_path_tmp, we set an absolute path like: '~/Users/myuser/Documents/github/firepress-org/bashlava'
# bashlava_path is a file on disk (not a variable)
# It finds and configures it automatically. This way we don't have to hard code it :)
# Don't confuse it with the symlink which is usually at "/usr/local/bin/bashlava.sh"
# We write bashlava_path on disk for speed optimization and to avoid running this request all the time.
  if [[ ! -f ${_path_user}/bashlava_path ]]; then
    readlink "$(which "${bashlava_executable}")" > "${_path_user}/bashlava_path_tmp"
    rm ${_path_user}/bashlava_path
# this will strip "/bashlava.sh" from the absolute path
    cat "${_path_user}/bashlava_path_tmp" | sed "s/\/${bashlava_executable}//g" > "${_path_user}/bashlava_path"
# clean up
    rm ${_path_user}/bashlava_path_tmp
  elif [[ -f ${_path_user}/bashlava_path ]]; then
      echo "Path is valid. Lets continue." > /dev/null 2>&1
  else
    my_message="FATAL: Core_Reset_Bashlava_Path | ${dir_path_is}" && Print_Fatal
  fi
}

function Core_Load_Vars_General {
### Default var & path. Customize if need. Usefull if you want
  # to have multiple instance of bashLaVa on your machine
  bashlava_executable="bashlava.sh"
  _path_user="/usr/local/bin"
  _var_name="_path_user" _is_it_empty="${_path_user}" && Condition_Vars_Must_Be_Not_Empty

### Reset if needed
  Core_Reset_Bashlava_Path

### Set absolute path for the project root ./
  _path_bashlava="$(cat "${_path_user}"/bashlava_path)"
  _var_name="_path_bashlava" _is_it_empty="${_path_bashlava}" && Condition_Vars_Must_Be_Not_Empty

### Set absolute path for the ./components directory
  _path_components="${_path_bashlava}/components"
  _var_name="_path_components" _is_it_empty="${_path_components}" && Condition_Vars_Must_Be_Not_Empty

### Set absolute path for the ./docs directory
  _path_docs="${_path_bashlava}/docs"
  _var_name="_path_docs" _is_it_empty="${_path_docs}" && Condition_Vars_Must_Be_Not_Empty
# every scripts that are not under the main bashLaVa app, should be threated as an components.
# It makes it easier to maintain the project, it minimises cluter, it minimise break changes, it makes it easy to accept PR, more modular, etc.

### source PUBLIC scripts

### source files under /components
  arr=( "alias.sh" "utilities.sh" "show_fct_category_filter.sh" "example.sh")
  for action in "${arr[@]}"; do
    _file_is="${action}" _file_path_is="${_path_components}/${_file_is}" && Condition_File_Must_Be_Present
    # code optimization 0o0o, add logic: _to_source="true"
    source "${_file_path_is}"
  done

### source PRIVATE / custom scripts
  # the user must create /private/_entrypoint.sh file
  _file_is="_entrypoint.sh" _file_path_is="${_path_components}/private/${_file_is}" && Condition_File_Must_Be_Present
  source "${_file_path_is}"

### Set defaults for flags
  _flag_deploy_commit_message="not_set"
  _commit_message="not_set"

###	docker images
  docker_img_figlet="devmtl/figlet:1.1"
  docker_img_glow="devmtl/glow:1.4.1"

###	Date generators
  date_nano="$(date +%Y-%m-%d_%HH%Ms%S-%N)"
    date_sec="$(date +%Y-%m-%d_%HH%Ms%S)"
    date_min="$(date +%Y-%m-%d_%HH%M)"

  date_hour="$(date +%Y-%m-%d_%HH)XX"
    date_day="$(date +%Y-%m-%d)"
  date_month="$(date +%Y-%m)-XX"
  date_year="$(date +%Y)-XX-XX"
}

function Core_Load_Vars_Dockerfile {
  # Define vars from Dockerfile
  app_name=$(cat Dockerfile | grep APP_NAME= | head -n 1 | grep -o '".*"' | sed 's/"//g')
  app_version=$(cat Dockerfile | grep VERSION= | head -n 1 | grep -o '".*"' | sed 's/"//g')
  github_user=$(cat Dockerfile | grep GITHUB_USER= | head -n 1 | grep -o '".*"' | sed 's/"//g')
  default_branch=$(cat Dockerfile | grep DEFAULT_BRANCH= | head -n 1 | grep -o '".*"' | sed 's/"//g')
  github_org=$(cat Dockerfile | grep GITHUB_ORG= | head -n 1 | grep -o '".*"' | sed 's/"//g')
  dockerhub_user=$(cat Dockerfile | grep DOCKERHUB_USER= | head -n 1 | grep -o '".*"' | sed 's/"//g')
  github_registry=$(cat Dockerfile | grep GITHUB_REGISTRY= | head -n 1 | grep -o '".*"' | sed 's/"//g')

  _url_to_release="https://github.com/${github_user}/${app_name}/releases/new"
  _url_to_check="https://github.com/${github_user}/${app_name}"

  # idempotent checkpoints
  _var_name="app_name" _is_it_empty="${app_name}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="app_version" _is_it_empty="${app_version}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="github_user" _is_it_empty="${github_user}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="default_branch" _is_it_empty="${default_branch}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="github_org" _is_it_empty="${github_org}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="dockerhub_user" _is_it_empty="${dockerhub_user}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="github_registry" _is_it_empty="${github_registry}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="_url_to_release" _is_it_empty="${_url_to_release}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="_url_to_check" _is_it_empty="${_url_to_check}" && Condition_Vars_Must_Be_Not_Empty
}

function Core_Load_Vars_Edge {
### edge
  # Path where we store the dynamically generated edge name
  _path_lib="${HOME}/Library"
  _var_name="_path_lib" _is_it_empty="${_path_lib}" && Condition_Vars_Must_Be_Not_Empty

  mkdir -p "${_path_lib}/Application Support/FirePress/bashlava"
  _path_last_part="FirePress/bashlava/${app_name}_dev_branch_name_is"
  _var_name="_path_last_part" _is_it_empty="${_path_last_part}" && Condition_Vars_Must_Be_Not_Empty

  # Can't pass the path as a var because of the space (/Application Support)
  #_branch_dev_unique=$(cat "${_path_lib}/Application Support/${_path_last_part}")
  # It does not make sens to Condition_Vars_Must_Be_Not_Empty
}

### Entrypoint
function main() {
  trap script_trap_err ERR
  trap script_trap_exit EXIT
  source "$(dirname "${BASH_SOURCE[0]}")/.bashcheck.sh"

  Core_Load_Vars_General
  Core_Load_Vars_Dockerfile
  Core_Load_Vars_Edge
  Core_Check_Which_File_Exist

### Core_Input_Checkpoint
  if [[ -z "$2" ]]; then    #if empty
    input_2="not_set"
  elif [[ -n "$2" ]]; then    #if not empty
    input_2=$2
  else
    my_message="FATAL: <input_2> = ${input_2}" && Print_Fatal
  fi

  if [[ -z "$3" ]]; then    #if empty
    input_3="not_set"
  elif [[ -n "$3" ]]; then    #if not empty
    input_3=$3
  else
    my_message="FATAL: <input_3> = ${input_3}" && Print_Fatal
  fi

  if [[ -z "$4" ]]; then    #if empty
    input_4="not_set"
  elif [[ -n "$4" ]]; then    #if not empty
    input_4=$4
  else
    my_message="FATAL: <input_4> = ${input_4}" && Print_Fatal
  fi

### Load fct via .bashcheck.sh
  script_init "$@"
  cron_init
  colour_init

### Ensure there are no more than three attrbutes
  Condition_Attr_4_Must_Be_Empty

### optional
  # lock_init system

### optionnal Trace the execution of the script to debug (if needed)
  # set -o xtrace

###'command not found' / Add logic to confirm the fct exist or not
  #clear
  $1
}

### 'main' function by default
main "$@"

### Prompt if no attributs were passed
  input_1="$1"
  _script_name="$0"

  if [[ -z "$1" ]]; then
    echo "OK, user did not provide argument. Show options" > /dev/null 2>&1
    _doc_name="welcome_to_bashlava.md" && clear && Show_Docs

    read -r user_input; echo;
    case ${user_input} in
      # Dont use the shortcut 't' here! Its used for fct 'tag'
      1 | h) clear && help;;
      2 | tt) clear && test;;
      *) my_message="Aborted - Invalid input." Print_Fatal;; 
    esac

  elif [[ -n "$1" ]]; then
    echo "Good, user did provide argument(s)." > /dev/null 2>&1
  else
    my_message="FATAL: main (When no arg are provided)" && Print_Fatal
  fi

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
#
# END OF SCRIPT
#
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
          #
        #
      #
    #
  #
#
