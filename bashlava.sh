#!/usr/bin/env bash

# See bashlava for all details https://github.com/firepress-org/bashlava

# There are 14 TO-DO in the code

# TODO Decouple release() from tag

# TODO show()
# show() is work in progres. All about UX and prompt / case
# Show_All() .. prompt options
  # sidecars
  # alias
  # examples
  # User facing
  # Condition
  # Print
  # Prompt
  # App
  # Core
  # all function
  
# TODO edge()
# have this branch created with a unique ID to avoid conflicts with other developers edge_sunny
# prompt which name to use:
# by default use edge_DOCKERHUB_USER

# TODO edge()
# make it slick: check if branch edge exist before delete it from remote

# TODO Show_Release()
#to refactor duplication with Show_Version()

# TODO
# better management core vars / group them, avoid having multiple place to define them
# file to check VERSUS file to source

# TODO Core_Load_Vars_General()
# we have few array that are configs. They should be all together under the same block of code.
# source files under /components
# code optimization 0o0o / Need logic to manage file under /private/* 

# TODO main()
# set a new config flag: debug="true"

# TODO /private
# logical flags to manage under /private/*
# source "${_path_components}/private/
# Need to check if files exist /private/* when DIR private exist
# manage private vars https://github.com/firepress-org/bashlava/issues/83
# cmd to commit this: "Organising backlog: 16 TODO, issue #4"

# logic to switch between private fct VERSUS public fct
# custom_fct_opensite="false"
# custom_fct_help="false"
  # this will use a fct available to public
  # else it will use a 

# TODO dummy commits
# create a dummy commit as test quickly the whole workflow
# branch out dummy
# commit dummy message
# commit dummy message again
# sq 2 "dummy message"
# prompt : do you want to delete dummy branch ?

# TODO
### App check brew + git-crypt + gnupg, shellcheck
#if brew ls --versions myformula > /dev/null; then
  # The package is installed
#else
  # The package is not installed
#fi

# TODO release
# glitch, release function is not stable when we tag. Sometimes it show the older release
# loop with curl he check if Url is reachable

# TODO
# create ci for using shellcheck
# run test()

# TODO Show_Docs()
# works but not clean, but it works 'mdv' / 'Show_Docs'
  # we can't provide an abosolute path to the file because the Docker container can't the absolute path
  # I also DONT want to provide two arguments when using glow
  # I might simply stop using a docker container for this
  # but as a priciiple, I like to call a docker container

function mainbranch { # User_
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending
  Condition_Apps_Must_Be_Installed
  Show_Version

  git checkout ${default_branch}
  git pull origin ${default_branch} && echo
  log
}

function edge { # User_
  Condition_Attr_2_Must_Be_Empty       # fct without attributs
  Condition_No_Commits_Pending
  Condition_Apps_Must_Be_Installed
### delete branch locally
  git branch -D edge || true
### delete branch on remote
  git push origin --delete edge || true

  git checkout -b edge
  git push --set-upstream origin edge -f

  Show_Version
  _doc_name="next_move_fct_edge.md" && Show_Docs
}

function commit { # User_
  Condition_Attr_2_Must_Be_Provided
  git status && git add -A && git commit -m "${input_2}" && git push
  _doc_name="next_move_fct_c.md" && Show_Docs
}

function pr { # User_
  Condition_Branch_Must_Be_Edge
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending

  _pr_title=$(git log --format=%B -n 1 "$(git log -1 --pretty=format:"%h")" | cat -)
  _var_name="_pr_title" _is_it_empty="${_pr_title}" && Condition_Vars_Must_Be_Not_Empty

  gh pr create --fill --title "${_pr_title}" --base "${default_branch}"
  gh pr view --web    # if there is a bug see: /docs/debug_upstream.md

  _doc_name="prompt_show_ci_status.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | y | ci) ci;;
    *) my_message="Aborted" && Print_Gray;;
  esac

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

  gh pr merge

  _doc_name="prompt_show_ci_status.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | y | ci) ci;;
    *) my_message="Aborted" && Print_Gray;;
  esac

  Show_Version

  _doc_name="next_move_fct_mrg.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | v) version;;
    2 | t) tag;;
    3 | ci) ci;;
    4 | e) edge;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function version { # User_
### The version is stored within the Dockerfile. For BashLaVa, this Dockerfile is just a config-env file
  Condition_No_Commits_Pending
  Show_Version

  if [[ "${input_2}" == "not_set" ]]; then
    # The user did not provide a version

    _doc_name="prompt_fct_v_version_number.md" && Show_Docs
    read -r user_input;
    echo;
    my_message="${user_input}" && Print_Green
    input_2="${user_input}"
    
    _doc_name="prompt_fct_v_confirmation.md" && Show_Docs
    # warning: dont reset input_2
    read -r user_input;
    case ${user_input} in
      1 | y) echo "Good, lets continue" > /dev/null 2>&1;;
      2 | n) echo "Lets retry" && version;;
      *) my_message="Aborted" && Print_Gray;;
    esac
  elif [[ "${input_2}" != "not_set" ]]; then
    echo "Good, lets continue" > /dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_2_Must_Be_Provided" && Print_Fatal
  fi

  Condition_Attr_2_Must_Be_Provided
  Condition_Version_Must_Be_Valid

### Update version within Dockerfile
  sed -i '' "s/^ARG VERSION=.*$/ARG VERSION=\"${input_2}\"/" Dockerfile
  # code optimization 0o0o, Add logic for /private scripts

  git add .
  git commit . -m "Update ${app_name} to version ${input_2}"
  git push && echo
  Show_Version

  _doc_name="next_move_fct_v.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | t) tag;;
    2 | pr) pr;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function tag { # User_
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Empty

  git tag ${app_version} && git push --tags && echo
  Show_Version

  _doc_name="next_move_fct_tag.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | y | r) release;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function release {
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Empty

  gh release create && sleep 5
  Show_Version
  Show_Release

  _doc_name="next_move_fct_release.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | y | e) edge;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function squash { # User_
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Provided # how many steps
  Condition_Attr_3_Must_Be_Provided # message

  if ! [[ "${input_2}" =~ ^[0-9]+$ ]] ; then
    my_message="Oups, syntax error." && Print_Warning_Stop
  fi

  git reset --hard HEAD~"${input_2}"
  git merge --squash HEAD@{1}
  git push origin HEAD --force
  git status
  git add -A
  git commit -m "${input_3} /sq"
  git push
  log

  _doc_name="next_move_fct_sq.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | c) commit;;
    2 | pr) pr;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function ci { # User_
  # continuous integration status
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending

### show latest build and open webpage on Github Actions
  # gh run list && sleep 1
  _run_id=$(gh run list | head -1 | awk '{print $11}')
  _var_name="_run_id" _is_it_empty="${_run_id}" && Condition_Vars_Must_Be_Not_Empty
  # Opening the run id cuase issues. Lets stick to /actions/
  open https://github.com/${github_user}/${app_name}/actions/

  # Follow status within the terminal
  gh run watch

  _doc_name="next_move_fct_ci.md" && Show_Docs
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | y | mrg) mrg;;
    *) my_message="Aborted" && Print_Gray;;
  esac
}

function log { # User_
  git log --all --decorate --oneline --graph --pretty=oneline | head -n 10
}

function test { # User_
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
  App_array

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
  clear
  _doc_name="help.md" && Show_Docs
}

function show { # User_
  Prompt_All_Available_Fct
  #Show_Version
}

function mdv { # User_
  Print_mdv
}

function gitio { # User_

  # CMD EXECUTION
  function sub_short_url {
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
    y | Y) sub_short_url;;
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
function Show_All { 
  Show_Version
  echo "WIP"
}

function Show_Version {
  input_2="not_set" input_3="not_set" input_4="not_set"
  Condition_Attr_2_Must_Be_Empty
  Condition_Attr_3_Must_Be_Empty
  Condition_Attr_4_Must_Be_Empty

  echo && my_message="Check versions:" && Print_Blue
  Core_Load_Vars_Dockerfile

### version in dockerfile
  my_message="${app_version} < VERSION in Dockerfile" Print_Gray

### tag
  if [[ -n $(git tag -l "${app_version}") ]]; then
    echo "Good, a tag is present" > /dev/null 2>&1
    latest_tag="$(git describe --tags --abbrev=0)"
    _var_name="latest_tag" _is_it_empty="${latest_tag}" && Condition_Vars_Must_Be_Not_Empty
  else
    echo "Logic: new projet don't have any tags. So we must expect that it can be empty" > /dev/null 2>&1
    latest_tag="none "
  fi
  my_message="${latest_tag} < TAG     in mainbranch" Print_Gray

### release
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

  my_message="${release_latest} < RELEASE in https://github.com/${github_user}/${app_name}/releases/tag/${release_latest}" && Print_Gray
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
  echo -e "👋 \e[1;34m${my_message}\e[0m"
}

### Why do we have Print_Warning and Print_Warning_Stop here ?
  # Fatal is usually reverse for unexpected erros within bashlava
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
# Conditions: idempotent, due diligence
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
  _compare_me=$(git rev-parse --abbrev-ref HEAD)
  _compare_you="edge" _fct_is="Condition_Branch_Must_Be_Edge"
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
  arr=( "sidecars.sh" "alias.sh" "example.sh" "list.txt" )
  for action in "${arr[@]}"; do
    _file_is="${action}" _file_path_is="${_path_components}/${_file_is}" && Condition_File_Must_Be_Present
  done

  _file_is="LICENSE" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="Dockerfile does not exit, let's generate one" && Print_Warning && sleep 2 && App_init_license && exit 1
  fi

  _file_is="README.md" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="Dockerfile does not exit, let's generate one" && Print_Warning && sleep 2 && App_init_readme && exit 1
  fi

  _file_is=".gitignore" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="Dockerfile does not exit, let's generate one" && Print_Warning && sleep 2 && App_init_gitignore && exit 1
  fi

  _file_is="Dockerfile" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="Dockerfile does not exit, let's generate one" && Print_Warning && sleep 2 && App_init_dockerfile && exit 1
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
# Core functions /paths, variables
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

### Reset if needed
  Core_Reset_Bashlava_Path

### Set absolute path for the project root ./
  _path_bashlava="$(cat "${_path_user}"/bashlava_path)"

### Set absolute path for the ./components directory
  _path_components="${_path_bashlava}/components"

### Set absolute path for the ./docs directory
  _path_docs="${_path_bashlava}/docs"

# every scripts that are not under the main bashLaVa app, should be threated as an components.
# It makes it easier to maintain the project, it minimises cluter, it minimise break changes, it makes it easy to accept PR, more modular, etc.

### source PUBLIC scripts

### source files under /components
  arr=( "alias.sh" "sidecars.sh")
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

### Entrypoint
function main() {
  trap script_trap_err ERR
  trap script_trap_exit EXIT
  source "$(dirname "${BASH_SOURCE[0]}")/.bashcheck.sh"

  Core_Load_Vars_General
  Core_Load_Vars_Dockerfile
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
