#!/usr/bin/env bash

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

  git checkout ${CFG_DEFAULT_BRANCH}
  git pull origin ${CFG_DEFAULT_BRANCH} && echo
  log
}

function edge {                  # User_
  Condition_Attr_2_Must_Be_Empty # fct without attributs
  Condition_No_Commits_Pending
  Condition_Apps_Must_Be_Installed
  _from_fct="e"

  ### Logic to manage and generate unique edge name
  ### =============================================

  ### Local: delete branch if it exists
  _branch_exist=$(git branch --list "${_branch_dev_unique}" | wc -l)
  # It does not make sens to Condition_Vars_Must_Be_Not_Empty
  if [[ ${_branch_exist} -eq 0 ]]; then
    echo "local: OK branch ${_branch_dev_unique} do not exist" >/dev/null 2>&1

  elif [[ ${_branch_exist} -eq 1 ]]; then
    echo "local: OK branch ${_branch_dev_unique} must be deleted"
    git branch -D "${_branch_dev_unique}"
  else
    my_message="FATAL: ${_branch_dev_unique} (local)" && Print_Fatal
  fi

  ### Remote: delete branch if it exists
  _branch_exist=$(git ls-remote --heads https://github.com/"${GITHUB_USER}"/"${APP_NAME}".git "${_branch_dev_unique}" | wc -l)
  # It does not make sens to Condition_Vars_Must_Be_Not_Empty
  if [[ ${_branch_exist} -eq 0 ]]; then
    echo "remote: OK branch ${_branch_dev_unique} do not exist" >/dev/null 2>&1
  elif [[ ${_branch_exist} -eq 1 ]]; then
    echo "remote: OK branch ${_branch_dev_unique} must be deleted"
    git push origin --delete "${_branch_dev_unique}"
  else
    my_message="FATAL: ${_branch_dev_unique} (remote)" && Print_Fatal
  fi

  ### Reset file where we stored the _branch_dev_unique
  if [[ -f "${HOME}/.bashlava/${_file_name_edge}" ]]; then
    echo "File exist. Lets delete it" >/dev/null 2>&1
    rm "${HOME}/.bashlava/${_file_name_edge}"
  fi

  ### Generate _branch_dev_unique and save the name in a file
  if [[ -f "${HOME}/.bashlava/${_file_name_edge}" ]]; then
    my_message="FATAL: File exist, but it should not!" && Print_Fatal
  elif [[ ! -f "${HOME}/.bashlava/${_file_name_edge}" ]]; then
    echo "OK, file do not exit" >/dev/null 2>&1
    _default_edge_prefix="${CFG_DEFAULT_DEV_BRANCH}" _random_char=$(openssl rand -hex 4 | colrm 4)
    # Store to file
    echo "${_default_edge_prefix}_${_random_char}" >"${HOME}/.bashlava/${_file_name_edge}"
    # Get the new generated _branch_dev_unique
    _branch_dev_unique=$(cat "${HOME}/.bashlava/${_file_name_edge}")
  else
    my_message="FATAL: ${CFG_DEFAULT_DEV_BRANCH}" && Print_Fatal
  fi
  ### =============================================

  git checkout -b "${_branch_dev_unique}"
  echo && echo "push ${_branch_dev_unique} to origin"
  git push --set-upstream origin "${_branch_dev_unique}" -f
  echo && git describe && log

  Show_Version

  Show_What_Was_Done
  _doc_name="next_move_fct_edge.md" && Show_Docs
}

function commit { # User_
  Condition_Attr_2_Must_Be_Provided
  _from_fct="c"

  git status && git add -A

  if [[ "${CFG_USE_GPG_SIGNATURE}" == "true" ]]; then
    git commit -S -m "${input_2}"
  elif [[ "${CFG_USE_GPG_SIGNATURE}" == "false" ]]; then
    git commit -m "${input_2}"
  else
    my_message="FATAL: tag" && Print_Fatal
  fi

  git push

  Show_What_Was_Done
  git --no-pager log --decorate=short --pretty=oneline --abbrev-commit -n"${CFG_LOG_LINE_NBR_SHORT}"

  _doc_name="fct_c_next.md" && Show_Docs
}

function pr { # User_
  Condition_Branch_Must_Be_Edge
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending
  _from_fct="pr"

  _pr_title=$(git log --format=%B -n 1 "$(git log -1 --pretty=format:"%h")" | cat -)
  _var_name="_pr_title" _is_it_empty="${_pr_title}" && Condition_Vars_Must_Be_Not_Empty

  gh pr create --fill --title "${_pr_title}" --base "${CFG_DEFAULT_BRANCH}" && sleep 1
  gh pr view --web # if there is a bug see: /docs/debug_upstream.md

  Show_What_Was_Done
  _doc_name="next_move_fct_pr.md" && Show_Docs
  input_2="not_set" #reset input_2
  read -r user_input
  case ${user_input} in
  1 | mrg) mrg ;;
  2 | ci) ci ;;
  *) my_message="Aborted" && Print_Gray ;;
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
  _branch_exist=$(git branch --list "${CFG_DEFAULT_BRANCH}" | wc -l)
  # It does not make sens to Condition_Vars_Must_Be_Not_Empty
  if [[ ${_branch_exist} -eq 0 ]]; then
    echo "OK we are on main_branch. Nothing to do"
  elif [[ ${_branch_exist} -eq 1 ]]; then
    echo "We are not on main_branch. Lets checkout"
    mainbranch
  else
    my_message="FATAL: ${_branch_dev_unique} (local)" && Print_Fatal
  fi
  echo

  my_message="Current branch is:" && Print_Blue
  git rev-parse --abbrev-ref HEAD

  _from_fct="mrg"
  Show_What_Was_Done
  _doc_name="next_move_fct_mrg.md" && Show_Docs
  input_2="not_set" #reset input_2
  read -r user_input
  case ${user_input} in
  1 | v) version ;;
  2 | t) tag ;;
  3 | e) edge ;;
  4 | ci) ci ;;
  *) my_message="Aborted" && Print_Gray ;;
  esac
  # Add new fct allow the user to: v + t + r + e in one step
}

function version { # User_
  Condition_No_Commits_Pending
  Core_Check_Path_Is_Root
  _from_fct="v"

  Show_Version

  # set input_2 if not provided
  if [[ "${input_2}" == "not_set" ]]; then
    my_message="What is the version number (ex: 1.12.4.)?" && Print_Green
    read -r user_input
    echo
    my_message="${user_input}" && Print_Green
    input_2="${user_input}"
    Condition_Version_Must_Be_Valid
  elif [[ "${input_2}" != "not_set" ]]; then
    echo "Good, lets continue" >/dev/null 2>&1
  else
    my_message="FATAL: (version)" && Print_Fatal
  fi

  if [[ "${input_2}" != "not_set" ]]; then
    Condition_Attr_2_Must_Be_Provided
    Condition_Version_Must_Be_Valid

    ### SUB_DIR
    if [[ "${CFG_SUB_DIR}" != "false" ]]; then
      _file_is="Dockerfile" _file_path_is="$(pwd)/${CFG_SUB_DIR}/${_file_is}" && Condition_File_Optionnally_Present
    elif [[ "${CFG_SUB_DIR}" == "false" ]]; then
      _file_is="Dockerfile" _file_path_is="$(pwd)/${_file_is}" && Condition_File_Optionnally_Present
    else
      my_message="FATAL: (CFG_SUB_DIR)" && Print_Fatal
    fi

    ### Update version in Dockerfile
    if [[ "${_file_do_not_exist}" != "true" ]]; then
      sed -i '' "s|ARG VERSION=\"[^\"]*\"|ARG VERSION=\"${input_2}\"|" "${_file_path_is}"
    elif [[ "${_file_do_not_exist}" == "true" ]]; then
      echo "No Dockerfile, lets continue" >/dev/null 2>&1
    else
      my_message="FATAL: (_file_do_not_exist)" && Print_Fatal
    fi

    ### Update version in .env
    _file_is=${_where_to_save_version} _file_path_is="$(pwd)/${_file_is}" && Condition_File_Must_Be_Present
    sed -i '' "s/^APP_VERSION=.*$/APP_VERSION=\"${input_2}\"/" "${_file_path_is}"

    ### Reload vars as the version was just updated
    source "${_file_path_is}"

    git add .
    git commit . -m "Update ${APP_NAME} to version ${input_2}"
    git push && echo
    Show_Version

    Show_What_Was_Done
    _doc_name="next_move_fct_v.md" && Show_Docs
    input_2="not_set" #reset input_2
    read -r user_input
    case ${user_input} in
    1 | t) tag ;;
    2 | pr) pr ;;
    *) my_message="Aborted" && Print_Gray ;;
    esac

  elif [[ "${input_2}" == "not_set" ]]; then
    my_message="ERROR: This should not happen (version)" && Print_Warning_Stop
  else
    my_message="FATAL (version)" && Print_Fatal
  fi
}

function tag { # User_
  Condition_No_Commits_Pending
  Condition_Branch_Must_Be_Mainbranch
  #Condition_Attr_2_Must_Be_Empty
  _from_fct="t"

  if [[ "${CFG_USE_GPG_SIGNATURE}" == "true" ]]; then
    git tag --sign "${APP_VERSION}" -m "tag: ${APP_VERSION} using bashlava"
  elif [[ "${CFG_USE_GPG_SIGNATURE}" == "false" ]]; then
    #OLD git tag "${APP_VERSION}"
    git tag "${APP_VERSION}" -a -m "${APP_VERSION}"
  else
    my_message="FATAL: tag" && Print_Fatal
  fi

  git push origin --tags
  echo
  Show_Version
  Show_Tag

  Show_What_Was_Done
  _doc_name="next_move_fct_tag.md" && Show_Docs
  input_2="not_set" #reset input_2
  read -r user_input
  case ${user_input} in
  1 | r) release ;;
  2 | ci) ci ;;
  *) my_message="Aborted" && Print_Gray ;;
  esac
}

function tci { # User_
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Empty
  _from_fct="tci"

  _short_hash=$(git rev-parse --short HEAD)
  _tag_name="ci_${APP_VERSION}_${_short_hash}"
  _var_name="_short_hash" _is_it_empty="${_short_hash}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="_tag_name" _is_it_empty="${_tag_name}" && Condition_Vars_Must_Be_Not_Empty

  git tag ${_tag_name} && git push --tags && echo
  Show_Version

  Show_What_Was_Done
  _doc_name="next_move_fct_tci.md" && Show_Docs
  input_2="not_set" #reset input_2
  read -r user_input
  case ${user_input} in
  1 | r) release ;;
  2 | ci) ci ;;
  *) my_message="Aborted" && Print_Gray ;;
  esac

  # New feat: tci(): tag to trigger the CI #21
  # Now, main_branch builds only when pushing tags
  # Now, the CI do not build on every commits on main_branch (its a pain when we merge many PRs)
  #
  # version(): Add logic to catch the attribut when calling fct #22
  # See this PR: https://github.com/firepress-org/bashlava/pulls?q=is%3Apr+is%3Aclosed+tci
}

function release { # User_
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Empty
  Condition_Branch_Must_Be_Mainbranch
  _from_fct="r"

  # I would like to not have the v in the release https://github.com/cli/cli/issues/5609
  #                'v' is an attribut required by gh cli
  gh release create "$(git describe --tags --abbrev=0)" --generate-notes

  sleep 0.3
  Show_Version
  Show_Tag && sleep 1
  open https://github.com/${GITHUB_USER}/${APP_NAME}/releases

  Show_What_Was_Done
  _doc_name="next_move_fct_release.md" && Show_Docs
  input_2="not_set" #reset input_2
  read -r user_input
  case ${user_input} in
  1 | e) edge ;;
  *) my_message="Aborted" && Print_Gray ;;
  esac
}

function deploy() {
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  pr_exists=$(git ls-remote --exit-code --heads origin $current_branch)

  if [ $? -ne 0 ]; then
    echo "No pull request exists for the current branch"
    return 1
  fi

  echo "Do you want to update the version (y/n)?"
  read update_version
  if [ "$update_version" = "y" ]; then
    echo "Enter the version number:"
    read version_number
    version $version_number
  fi

  mrg
  if [ $? -ne 0 ]; then
    echo "Merge failed"
    return 1
  fi

  if [ "$(git rev-parse --abbrev-ref HEAD)" != "mainbranch" ]; then
    echo "Not on main branch"
    return 1
  fi

  if [ "$update_version" = "y" ]; then
    version
    if [ $? -ne 0 ]; then
      echo "Version update failed"
      return 1
    fi
  fi

  tag
  if [ $? -ne 0 ]; then
    echo "Tag update failed"
    return 1
  fi

  release
  if [ $? -ne 0 ]; then
    echo "Release update failed"
    return 1
  fi

  edge
  if [ $? -ne 0 ]; then
    echo "Edge update failed"
    return 1
  fi

  echo "Deployment completed successfully"
}

function squash { # User_
  Condition_No_Commits_Pending
  Condition_Attr_2_Must_Be_Provided # how many steps
  Condition_Attr_3_Must_Be_Provided # message
  _from_fct="sq"

  git --no-pager log --decorate=short --pretty=oneline --abbrev-commit -n"${CFG_LOG_LINE_NBR_LONG}"

  if ! [[ "${input_2}" =~ ^[0-9]+$ ]]; then
    my_message="Oups, syntax error." && Print_Warning_Stop
  else
    echo "Ok, lets squash" >/dev/null 2>&1
  fi

  git reset --soft HEAD~"${input_2}" &&
    git commit -m "${input_3}" &&
    git push --force-with-lease &&
    git pull
  input_2="not_set" #reset input_2
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
  open https://github.com/${GITHUB_USER}/${APP_NAME}/actions/

  # Follow status within the terminal
  gh run watch

  Show_What_Was_Done
  _doc_name="next_move_fct_ci.md" && Show_Docs
  input_2="not_set" #reset input_2
  read -r user_input
  case ${user_input} in
  1 | y | mrg) mrg ;;
  *) my_message="Aborted" && Print_Gray ;;
  esac
}

function commit_suggestion { # User_
  # https://github.com/firepress-org/bashlava/pull/62

  Condition_Attr_2_Must_Be_Empty
  _from_fct="d"

  _prompt="Based on the output of this 'git status', write me five git commit messages suggestions that will help me see quickly what this git commit was all about.
  The message must be one line with a maximum of 200 characters.
  Mentions which files are impacted
  If you see 'nothing to commit, working tree clean' in the  git status output, then reply: 'nothing to commit'
  Avoid mentionning anything about the branch name
  Avoid mentionning anything 'untracked files'
  Avoid mentionning anything about 'no changes added to commit'
  Avoid mentionning anything Remove obsolete
  Here is the git status output:

  " &&
    _git_status="$(git status)" &&
    _commit_message=$(echo "${_prompt} ${_git_status}" | chatgpt) &&

    # Remove empty lines using sed
    _clean_message=$(echo "$_commit_message" | sed '/^$/d') &&

    # Just show what chatGPT would write as our git commit
    my_message="Commit Suggestion:" && Print_Blue &&
    echo "${_clean_message}"

  #git add -A && git commit -m "${_commit_message}" &&\
  #git push &&\
  #log;

}

function dummy { # User_
  Condition_Attr_2_Must_Be_Empty
  _from_fct="d"
  _in_file="./docs/DUMMY.md"

  # create two dummy commits in a row
  for lineID in $(seq 1 1); do
    date_nano="$(date +%Y-%m-%d_%HH%Ms%S-%N)"
    _hash=$(echo "${date_nano} ${lineID}" | sha256sum | awk '{print $1}')
    _hash_four_last="${_hash: -4}"

    if [[ "${CFG_DUMMY_CUSTOM_MSG}" == "false" ]]; then
      _commit_message="Dummy Commit ${lineID}"
    elif [[ "${CFG_DUMMY_CUSTOM_MSG}" == "true" ]]; then
      _commit_message="${CFG_DUMMY_CUSTOM_MSG_IS} ${lineID}"
    else
      my_message="FATAL: Config is broken regarding: 'CFG_TEST_SHOW_VARS'." && Print_Fatal
    fi

    _commit_hash="Dummy Commit - $(date +%Y-%m-%d_%HH%M_%S) - ${_hash}"
    echo "${_commit_hash}" >>"${_in_file}"
    git add -A && git commit -m "${_commit_message}"
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
  echo && git --no-pager log --decorate=short --pretty=oneline --abbrev-commit -n"${CFG_LOG_LINE_NBR_LONG}" && echo
}

function test { # User_
  Condition_Attr_2_Must_Be_Empty
  Condition_No_Commits_Pending
  _from_fct="test"
  # PRINT OPTION 1
  echo && my_message="Check Print_Banner" && Print_Blue
  my_message="bashLaVa" && Print_Banner

  if [[ "${CFG_TEST_SHOW_VARS}" == "true" ]]; then
    echo && my_message="Check env vars:" && Print_Blue

    my_message="Random tests" Print_Blue
    my_message="\$1 value is: ${input_1}" Print_Gray
    my_message="\$2 value is: ${input_2}" Print_Gray
    my_message="\$3 value is: ${input_3}" Print_Gray
    my_message="\$4 value is: ${input_4}" Print_Gray

    echo
    Core_Show_Env_Vars
  elif [[ "${CFG_TEST_SHOW_VARS}" == "false" ]]; then
    echo "bypassed, ok" >/dev/null
  else
    my_message="FATAL: Config is broken regarding: 'CFG_TEST_SHOW_VARS'." && Print_Fatal
  fi
  echo

  Condition_Apps_Must_Be_Installed
  echo

  if [[ "${CFG_TEST_OPTIONAL_APPS}" == "true" ]]; then
    Condition_Apps_Installed_Is_Optionnal
  elif [[ "${CFG_TEST_OPTIONAL_APPS}" == "false" ]]; then
    echo "bypassed, ok" >/dev/null
  else
    my_message="FATAL: Config is broken regarding: 'CFG_TEST_OPTIONAL_APPS'." && Print_Fatal
  fi
  echo

  Core_Check_Which_File_Exist
  my_message="Check files and directories: All good!" Print_Gray # else the Condition will stop the script

  if [[ $(uname) == "Darwin" ]]; then
    my_message="Running on a Mac (Darwin): All good!" Print_Gray
  elif [[ $(uname) != "Darwin" ]]; then
    my_message="bashLaVa is not tested on other machine than Mac OS (Darmin)." && Print_Warning
  else
    my_message="FATAL: Test / Check OS" && Print_Fatal
  fi

  echo
  my_message="Array from /components/utilities.sh" && Print_Blue
  Utility_Array

  # PRINT OPTION 2
  echo
  my_message="Test mdv" && Print_Blue
  _doc_name="test.md" && Show_Docs

  # PRINT OPTION 3
  my_message="Test color prints" && Print_Blue
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

  # CFG_HELP_ALT / Add logic 0o0o
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
      -F "code=${input_3}" &&

      # PREVIEW
      echo && my_message="Let's open: https://git.io/${input_3}" && Print_Blue && sleep 2 &&
      open https://git.io/${input_3}
  }

  echo
  my_message="URL ........ : https://git.io/${APP_NAME}" && Print_Gray
  my_message="will point to: https://github.com/${GITHUB_USER}/${APP_NAME}" && Print_Gray
  #output example: https://git.io/bashlava

  # PROMPT
  echo
  my_message="Do you want to continue? (y/n)" && Print_Gray
  read -r user_input
  case ${user_input} in
  y | Y) child_gitio ;;
  *) my_message="Aborted" && Print_Fatal ;;
  esac
}

function gc { # User_
  Condition_Attr_3_Must_Be_Empty

  if [[ "${input_2}" == "on" ]]; then
    gc_on
  elif [[ "${input_2}" == "off" ]]; then
    gc_off
  elif [[ "${input_2}" == "s" ]]; then
    gc_status
  elif [[ "${input_2}" == "k" ]]; then
    gc_keys
  elif [[ "${input_2}" == "h" ]]; then
    gc_help
  elif [[ "${input_2}" == "not_set" ]]; then
    _doc_name="fct_gc_next.md" && Show_Docs
    input_2="not_set" #reset input_2
    read -r user_input
    case ${user_input} in
    1 | on | un) gc_on ;;
    2 | off) gc_off ;;
    3 | s | status) gc_status ;;
    4 | k) gc_keys ;;
    5 | h | help) gc_help ;;
    *) my_message="Aborted" && Print_Gray ;;
    esac
  else
    my_message="FATAL: The command does not exist." && Print_Fatal
  fi
}
### CHILD FUNCTIONS
function gc_on { # Child_
  Condition_No_Commits_Pending
  _file_is=".git-crypt" dir_path_is="$(pwd)/${_file_is}" && Condition_Dir_Must_Be_Present

  git-crypt unlock
  # clear the warning. See https://github.com/firepress-org/bashlava/issues/40
  clear
  my_message="git-crypt unlocked your files/dir." && Print_Green
  file "$(git-crypt status -e | head -1 | awk '{print $2}')"
}
function gc_off { # Child_
  Condition_No_Commits_Pending
  _file_is=".git-crypt" dir_path_is="$(pwd)/${_file_is}" && Condition_Dir_Must_Be_Present

  git-crypt lock
  my_message="git-crypt locked your files/dir." && Print_Green
  file "$(git-crypt status -e | head -1 | awk '{print $2}')"
}
function gc_status { # Child_
  _file_is=".git-crypt" dir_path_is="$(pwd)/${_file_is}" && Condition_Dir_Must_Be_Present
  git-crypt status -e && echo
  git-crypt status -u && echo
  git-crypt status -f
  file "$(git-crypt status -e | head -1 | awk '{print $2}')"
}
function gc_keys { # Child_
  _file_is=".git-crypt" dir_path_is="$(pwd)/${_file_is}" && Condition_Dir_Must_Be_Present
  gpg --list-keys
}
function gc_help { # Child_
  clear
  _doc_name="help_gitcrypt.md" && Show_Docs
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

  # VERSION
  my_message="${APP_VERSION} < VERSION in ${OVERRIDE_CONFIG_FILE_NAME_IS}" Print_Gray
}
function Show_Tag {
  if [[ -n $(git tag -l "${APP_VERSION}") ]]; then
    echo "Good, a tag is present" >/dev/null 2>&1
    latest_tag="$(git describe --tags --abbrev=0)"
    _var_name="latest_tag" _is_it_empty="${latest_tag}" && Condition_Vars_Must_Be_Not_Empty
  else
    echo "Logic: new projet don't have any tags. So we must expect that it can be empty" >/dev/null 2>&1
    latest_tag="none "
  fi
  my_message="${latest_tag} < TAG     in ${CFG_DEFAULT_BRANCH}" Print_Gray
}

function Show_Docs {
  # idempotent checkpoint
  _var_name="DOCKER_IMG_GLOW" _is_it_empty="${DOCKER_IMG_GLOW}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="_doc_name" _is_it_empty="${_doc_name}" && Condition_Vars_Must_Be_Not_Empty

  _present_path_is="$(pwd)"
  _file_is="${_doc_name}" _file_path_is="${_path_docs}/${_doc_name}" && Condition_File_Must_Be_Present

  cd ${_path_docs} || {
    echo "FATAL: Show_Docs / cd"
    exit 1
  }
  Condition_Docker_Must_Run
  docker run --rm -it -v "$(pwd)":/sandbox -w /sandbox ${DOCKER_IMG_GLOW} glow -w 110 "${_doc_name}"
  cd ${_present_path_is} || {
    echo "FATAL: Show_Docs / cd"
    exit 1
  }
}

function Show_What_Was_Done {
  echo && my_message="(${_from_fct}) was done.                          ${APP_NAME} $(git rev-parse --abbrev-ref HEAD)" && Print_Green
}

function Show_Prompt_All {

  Core_Check_Which_File_Exist
  _doc_name="prompt_show_fct.md" && clear && Show_Docs
  read -r user_input
  case ${user_input} in
  1 | ali) clear && Show_Fct_Category_Alias ;;
  2 | cond) clear && Show_Fct_Category_Condition ;;
  3 | core) clear && Show_Fct_Category_Core ;;
  4 | ex) clear && Show_Fct_Category_Example ;;
  5 | pri) clear && Show_Fct_Category_Print ;;
  6 | s) clear && Show_Fct_Category_Show ;;
  7 | user) clear && Show_Fct_Category_User ;;
  8 | util) clear && Show_Fct_Category_Utility ;;
  9 | a | all) clear && Show_Fct_Category_All ;;
  f1) clear && Show_Fct_Category_F1 ;;
  f2) clear && Show_Fct_Category_F2 ;;
  *)
    echo "Aboarded" && exit 1
    ;;
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
  _var_name="DOCKER_IMG_GLOW" _is_it_empty="${DOCKER_IMG_GLOW}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="input_2" _is_it_empty="${input_2}" && Condition_Vars_Must_Be_Not_Empty
  my_message="Info: 'mdv' can only read markdown files at the same path level" Print_Green
  sleep 0.5

  _present_path_is=$(pwd)
  _file_is="${input_2}" _file_path_is="${_present_path_is}/${input_2}" && Condition_File_Must_Be_Present
  Condition_Docker_Must_Run
  docker run --rm -it -v "$(pwd)":/sandbox -w /sandbox ${DOCKER_IMG_GLOW} glow -w 120 "${input_2}"
}

function Print_Banner {
  _var_name="DOCKER_IMG_FIGLET" _is_it_empty="${DOCKER_IMG_FIGLET}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
  Condition_Docker_Must_Run
  docker run --rm ${DOCKER_IMG_FIGLET} ${my_message}
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
  echo "This command must be executed on the Main branch."
  _compare_me=$(git rev-parse --abbrev-ref HEAD)
  _compare_you="${CFG_DEFAULT_BRANCH}" _fct_is="Condition_Branch_Must_Be_Mainbranch"
  Condition_Vars_Must_Be_Equal
}

function Condition_Branch_Must_Be_Edge {
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
    echo "Good, lets continue" >/dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_2_Must_Be_Provided" && Print_Fatal
  fi
}

function Condition_Attr_3_Must_Be_Provided {
  # ensure the third attribute is not empty to continue
  if [[ "${input_3}" == "not_set" ]]; then
    my_message="You must provide three attributes. fct: Condition_Attr_3_Must_Be_Provided" && Print_Warning_Stop
  elif [[ "${input_3}" != "not_set" ]]; then
    echo "Good, lets continue" >/dev/null 2>&1
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
    echo "Good, lets continue" >/dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_2_Must_Be_Empty" && Print_Fatal
  fi
}

function Condition_Attr_3_Must_Be_Empty {
  # Stop if 3 attributes are passed.
  if [[ "${input_3}" != "not_set" ]]; then
    my_message="You can NOT use three attributes. fct: Condition_Attr_3_Must_Be_Empty" && Print_Warning_Stop
  elif [[ "${input_3}" == "not_set" ]]; then
    echo "Good, lets continue" >/dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_3_Must_Be_Empty" && Print_Fatal
  fi
}
function Condition_Attr_4_Must_Be_Empty {
  # Stop if 4 attributes are passed.
  if [[ "${input_4}" != "not_set" ]]; then
    my_message="You cannot use four attributes. fct: Condition_Attr_4_Must_Be_Empty" && Print_Warning && echo
  elif [[ "${input_4}" == "not_set" ]]; then
    echo "Good, lets continue" >/dev/null 2>&1
  else
    my_message="FATAL: Condition_Attr_4_Must_Be_Empty" && Print_Fatal
  fi
}

function Condition_Version_Must_Be_Valid {
  # Version is limited to these characters: 1234567890.rRCc-
  # so we can do: '3.5.13-r3' or '3.5.13-rc3'
  _compare_me=$(echo "${input_2}" | sed 's/[^0123456789.rcRC\-]//g')
  _compare_you="${input_2}" _fct_is="Condition_Version_Must_Be_Valid"
  Condition_Vars_Must_Be_Equal
}

function Condition_Apps_Must_Be_Installed {

  # docker installed
  _compare_me=$(docker version | grep -c "Server: Docker Desktop")
  _compare_you="1" _fct_is="Condition_Apps_Must_Be_Installed"
  Condition_Vars_Must_Be_Equal
  which docker

  # gh cli installed
  _compare_me=$(which gh | grep -c "/gh")
  _compare_you="1" _fct_is="Condition_Apps_Must_Be_Installed"
  Condition_Vars_Must_Be_Equal
  which gh

  my_message="Check required apps: All good!" && Print_Gray
}

function Condition_Docker_Must_Run {

  # The script checks if the Docker daemon is running.
  # If the Docker daemon is not running, it starts Docker auto-magically
  # and waits for the Docker daemon to start for a maximum of 30 seconds.
  #
  # https://github.com/firepress-org/bashlava/pull/65

  # Check if Docker daemon is running
  if docker info >/dev/null 2>&1; then
    echo "Good! Docker daemon is running." >/dev/null
  else
    echo "Docker daemon is not running."

    # Start Docker
    if command -v docker >/dev/null; then
      open -a Docker && my_message="Waiting for Docker daemon to start (max 30 sec)" && Print_Gray

      # Wait for Docker to start (maximum 30 seconds)
      timeout=30
      while [ $timeout -gt 0 ]; do
        if docker info >/dev/null 2>&1; then
          echo "Docker daemon started."
          break
        fi
        sleep 1
        ((timeout--))
      done

      if [ $timeout -eq 0 ]; then
        my_message="Timeout: Docker daemon did not start within 30 seconds." && Print_Warning_Stop
        exit 1
      fi
    else
      my_message="Docker is not installed. Please install Docker and try again." && Print_Warning_Stop
      exit 1
    fi
  fi
}

function Condition_Apps_Installed_Is_Optionnal {
  # gpg must be install using brew install gnupg

  for action in "${CFG_LIST_OF_OPTIONAL_APPS[@]}"; do
    _output=$(which "${action}")
    _compare_me=$(echo "${_output}" | grep -c "/${action}")
    _compare_you="1" _fct_is="Condition_Apps_Must_Be_Installed"
    echo "${_output}"
    Condition_Vars_Must_Be_Equal
  done
  my_message="Check optionnal apps: All good!" && Print_Gray
}

function Core_Check_Which_File_Exist {
  # List markdown files under /docs/*
  for action in "${CFG_LIST_OF_REQ_MARKDOWN[@]}"; do
    _file_is="${action}" _file_path_is="${_path_docs}/${_file_is}" && Condition_File_Must_Be_Present
  done

  # List files under /components/*
  arr=("utilities.sh" "alias.sh" "show_fct_category_filter.sh" "example.sh" "list.txt")
  for action in "${arr[@]}"; do
    _file_is="${action}" _file_path_is="${_path_components}/${_file_is}" && Condition_File_Must_Be_Present
  done

  _file_is="LICENSE" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="LICENSE does not exit, let's generate one" && Print_Warning && sleep 2 && Utility_license && exit 1
  fi

  _file_is="README.md" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message="README.md does not exit, let's generate one" && Print_Warning && sleep 2 && Utility_readme && exit 1
  fi

  _file_is=".gitignore" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message=".gitignore does not exit, let's generate one" && Print_Warning && sleep 2 && Utility_gitignore && exit 1
  fi

  # Warning only
  _file_is=".dockerignore" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Optionnally_Present

  # If it happens, you want to know ASAP
  _file_is=".git" dir_path_is="${_path_bashlava}/${_file_is}" && Condition_Dir_Must_Be_Present
  if [[ "${_file_do_not_exist}" == "true" ]]; then
    my_message=".git directory does not exit" && Print_Fatal
  fi

  _file_is=".env" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Must_Be_Present

}

function Condition_File_Must_Be_Present {
  if [[ -f "${_file_path_is}" ]]; then
    echo "idempotent checkpoint passed" >/dev/null 2>&1
  elif [[ ! -f "${_file_path_is}" ]]; then
    my_message="This file is missing: ${_file_path_is}" && Print_Warning_Stop
    _file_do_not_exist="true"
  else
    my_message="FATAL: Condition_File_Must_Be_Present | ${_file_path_is}" && Print_Fatal
  fi
}

function Condition_File_Optionnally_Present {
  # This fct return the flag '_file_do_not_exist'
  if [[ -f "${_file_path_is}" ]]; then
    echo "idempotent checkpoint passed" >/dev/null 2>&1
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
    echo "Good, lets continue" >/dev/null 2>&1
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
    echo "Good, lets continue" >/dev/null 2>&1
  else
    my_message="FATAL: Condition_Vars_Must_Be_Not_Equal | ${_fct_is}" && Print_Fatal
  fi
}

function Condition_Vars_Must_Be_Not_Empty {
  # Think, IF vars is not empty, continue else fail
  # source must send two vars:_is_it_empty AND _var_name
  if [[ -n "${_is_it_empty}" ]]; then #if not empty
    echo "idempotent checkpoint passed" >/dev/null 2>&1
  elif [[ -z "${_is_it_empty}" ]]; then #if empty
    my_message="Warning: variable '${_var_name}' is empty" && Print_Warning_Stop
  else
    my_message="FATAL: Condition_Vars_Must_Be_Not_Empty | ${_var_name}" && Print_Fatal
  fi
}

function Condition_Dir_Must_Be_Present {
  # This fct return the flag '_file_do_not_exist'
  if [[ -d "${dir_path_is}" ]]; then
    echo "idempotent checkpoint passed" >/dev/null 2>&1
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

function Core_Show_Env_Vars {
  Core_Test_Env_Vars

  my_message="Check env_vars from config:" && Print_Blue
  echo
  echo "OVERRIDE_CONFIG_FILE_NAME_IS      > ${OVERRIDE_CONFIG_FILE_NAME_IS}"
  echo
  echo "APP_NAME                          > ${APP_NAME}"
  echo "GITHUB_USER                       > ${GITHUB_USER}"
  echo "APP_VERSION                       > ${APP_VERSION}"
  echo
  echo "CFG_DEFAULT_BRANCH                > ${CFG_DEFAULT_BRANCH}"
  echo "CFG_DEFAULT_DEV_BRANCH            > ${CFG_DEFAULT_DEV_BRANCH}"
  echo "CFG_USER_IS                       > ${CFG_USER_IS}"
  echo
  echo "CFG_EDGE_EXTENTED                 > ${CFG_EDGE_EXTENTED}"
  echo "CFG_LOG_LINE_NBR_SHORT            > ${CFG_LOG_LINE_NBR_SHORT}"
  echo "CFG_LOG_LINE_NBR_LONG             > ${CFG_LOG_LINE_NBR_LONG}"
  echo "CFG_RELEASE_POPUP                 > ${CFG_RELEASE_POPUP}"
  echo
  echo "CFG_TEST_SHOW_VARS                > ${CFG_TEST_SHOW_VARS}"
  echo "CFG_TEST_OPTIONAL_APPS            > ${CFG_TEST_OPTIONAL_APPS}"
  echo
  echo "CFG_DEBUG_MODE                    > ${CFG_DEBUG_MODE}"
  echo "CFG_LOCK_INIT                     > ${CFG_LOCK_INIT}"
  echo
  echo "CFG_LIST_OF_REQ_COMPONENTS        > ${CFG_LIST_OF_REQ_COMPONENTS}"
  echo "CFG_LIST_OF_REQ_MARKDOWN          > ${CFG_LIST_OF_REQ_MARKDOWN}"
  echo "CFG_LIST_OF_OPTIONAL_APPS         > ${CFG_LIST_OF_OPTIONAL_APPS}"
  echo
  echo "DOCKER_IMG_FIGLET                 > ${DOCKER_IMG_FIGLET}"
  echo "DOCKER_IMG_GLOW                   > ${DOCKER_IMG_GLOW}"
}

function Core_Test_Env_Vars {
  ### NEW CONFIG
  _var_name="OVERRIDE_CONFIG_FILE_NAME_IS" _is_it_empty="${OVERRIDE_CONFIG_FILE_NAME_IS}" && Condition_Vars_Must_Be_Not_Empty

  _var_name="APP_NAME" _is_it_empty="${APP_NAME}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="GITHUB_USER" _is_it_empty="${GITHUB_USER}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="APP_VERSION" _is_it_empty="${APP_VERSION}" && Condition_Vars_Must_Be_Not_Empty

  _var_name="CFG_DEFAULT_BRANCH" _is_it_empty="${CFG_DEFAULT_BRANCH}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="CFG_DEFAULT_DEV_BRANCH" _is_it_empty="${CFG_DEFAULT_DEV_BRANCH}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="CFG_USER_IS" _is_it_empty="${CFG_USER_IS}" && Condition_Vars_Must_Be_Not_Empty

  _var_name="CFG_EDGE_EXTENTED" _is_it_empty="${CFG_EDGE_EXTENTED}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="CFG_LOG_LINE_NBR_SHORT" _is_it_empty="${CFG_LOG_LINE_NBR_SHORT}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="CFG_LOG_LINE_NBR_LONG" _is_it_empty="${CFG_LOG_LINE_NBR_LONG}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="CFG_RELEASE_POPUP" _is_it_empty="${CFG_RELEASE_POPUP}" && Condition_Vars_Must_Be_Not_Empty

  _var_name="CFG_DEBUG_MODE" _is_it_empty="${CFG_DEBUG_MODE}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="CFG_LOCK_INIT" _is_it_empty="${CFG_LOCK_INIT}" && Condition_Vars_Must_Be_Not_Empty

  _var_name="CFG_LIST_OF_REQ_COMPONENTS" _is_it_empty="${CFG_LIST_OF_REQ_COMPONENTS}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="CFG_LIST_OF_REQ_MARKDOWN" _is_it_empty="${CFG_LIST_OF_REQ_MARKDOWN}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="CFG_LIST_OF_OPTIONAL_APPS" _is_it_empty="${CFG_LIST_OF_OPTIONAL_APPS}" && Condition_Vars_Must_Be_Not_Empty

  _var_name="DOCKER_IMG_FIGLET" _is_it_empty="${DOCKER_IMG_FIGLET}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="DOCKER_IMG_GLOW" _is_it_empty="${DOCKER_IMG_GLOW}" && Condition_Vars_Must_Be_Not_Empty
}

function Core_Reset_Bashlava_Path {
  # In file ${_path_user}/bashlava_path_tmp, we set an absolute path like: '~/Users/myuser/Documents/github/firepress-org/bashlava'
  # bashlava_path is a file on disk (not a variable)
  # It finds and configures it automatically. This way we don't have to hard code it :)
  # Don't confuse it with the symlink which is usually at "/usr/local/bin/bashlava.sh"
  # We write bashlava_path on disk for speed optimization and to avoid running this request all the time.
  if [[ ! -f ${_path_user}/bashlava_path ]]; then
    readlink "$(which bashlava.sh)" >"${_path_user}/bashlava_path_tmp"
    rm ${_path_user}/bashlava_path
    # this will strip "/bashlava.sh" from the absolute path
    cat "${_path_user}/bashlava_path_tmp" | sed "s/\/bashlava.sh//g" >"${_path_user}/bashlava_path"
    # clean up
    rm ${_path_user}/bashlava_path_tmp
  elif [[ -f ${_path_user}/bashlava_path ]]; then
    echo "Path is valid. Lets continue." >/dev/null 2>&1
  else
    my_message="FATAL: Core_Reset_Bashlava_Path | ${dir_path_is}" && Print_Fatal
  fi
}

function Core_Load_Vars_Edge {
  _file_name_edge="${APP_NAME}_dev_branch_name_is"

  # Needed when we first integrate bash to a new project
  # create file if not exist
  if [[ ! -f "${HOME}/.bashlava/${_file_name_edge}" ]]; then
    mkdir -p "${HOME}/.bashlava"
    touch "${HOME}/.bashlava/${_file_name_edge}"
  elif [[ -f "${HOME}/.bashlava/${_file_name_edge}" ]]; then
    echo "Path is valid. Lets continue." >/dev/null 2>&1
  else
    my_message="FATAL: Core_Reset_Bashlava_Path | ${dir_path_is}" && Print_Fatal
  fi

  # Needed when we first integrate bash to a new project
  # set a dummy value
  _branch_dev_unique=$(cat "${HOME}/.bashlava/${_file_name_edge}") || true

  if [[ -n "${_branch_dev_unique}" ]]; then #if not empty
    echo "idempotent checkpoint passed" >/dev/null 2>&1
  elif [[ -z "${_branch_dev_unique}" ]]; then #if empty
    echo "dummy_name" >"${HOME}/.bashlava/${_file_name_edge}"
  else
    my_message="FATAL: Core_Load_Vars_Edge | ${_branch_dev_unique}" && Print_Fatal
  fi

  _branch_dev_unique=$(cat "${HOME}/.bashlava/${_file_name_edge}")
  _var_name="_branch_dev_unique" _is_it_empty="${_branch_dev_unique}" && Condition_Vars_Must_Be_Not_Empty
}

function Core_Load_Config_Default {
  ### Default variables
  ### To override variables, do it under .env

  ### DEFAULT CONFIGS BELOW

  ### branch names
  CFG_DEFAULT_BRANCH="main"
  CFG_DEFAULT_DEV_BRANCH="edge"
  CFG_USER_IS="${USER}"

  ### Needed when projects are under sub directories
  CFG_SUB_DIR="false"

  ### manage your custom scripts under this directory /private/**.sh
  CFG_USE_PRIVATE_DIRECTORY="false"
  CFG_USE_GPG_SIGNATURE="false"

  ### edge
  CFG_EDGE_EXTENTED="false" # not coded yet

  ### log()
  CFG_LOG_LINE_NBR_SHORT="4" # log() default line number
  CFG_LOG_LINE_NBR_LONG="12" # log() default line number

  ### dummy()
  CFG_DUMMY_CUSTOM_MSG="false"
  CFG_DUMMY_CUSTOM_MSG_IS="Alt dummy message"

  CFG_RELEASE_POPUP="false"      # not coded yet
  CFG_TEST_SHOW_VARS="false"     # test extension
  CFG_TEST_OPTIONAL_APPS="false" # test extension
  CFG_DEBUG_MODE="false"
  CFG_LOCK_INIT="false"

  ### docker images
  DOCKER_IMG_FIGLET="devmtl/figlet:1.0"
  DOCKER_IMG_GLOW="devmtl/glow:1.4.1"

  ### source array. See FLAG b4f

  CFG_LIST_OF_REQ_MARKDOWN=("welcome_to_bashlava.md" "help.md" "test.md" "debug_upstream.md")
  CFG_LIST_OF_REQ_COMPONENTS=("alias.sh" "example.sh" "utilities.sh" "Show_Fct_Category_Filter.sh")
  CFG_LIST_OF_OPTIONAL_APPS=("docker" "gh" "git-crypt" "gpg" "openssl" "sha256sum" "grep" "nano" "tldr" "shellcheck" "chatgpt")

  ### DO NOT OVERRIDE
  DEFAULT_CONFIG_FILE_NAME_IS=".env"
  ### DO NOT OVERRIDE
  ### You must create this file in your project
  OVERRIDE_CONFIG_FILE_NAME_IS=".env"
}

function Core_Load_Config_Override {
  # Load override config if it exist
  if [[ -f "$(pwd)/${OVERRIDE_CONFIG_FILE_NAME_IS}" ]]; then
    _where_to_save_version="${OVERRIDE_CONFIG_FILE_NAME_IS}"
    source "$(pwd)/${OVERRIDE_CONFIG_FILE_NAME_IS}"
  elif [[ ! -f "$(pwd)/${OVERRIDE_CONFIG_FILE_NAME_IS}" ]]; then
    _file_is=".env" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Must_Be_Present
  else
    my_message="FATAL: Core_Load_Config_Override() A" && Print_Fatal
  fi
}

function Core_Load_Components {
  ### Load COMPONENTS (PUBLIC)
  for action in "${CFG_LIST_OF_REQ_COMPONENTS[@]}"; do
    _file_is="${action}" _file_path_is="${_path_components}/${_file_is}" && Condition_File_Must_Be_Present
    # code optimization, add logic: _to_source="true" 0o0o
    source "${_file_path_is}"
  done
}

function Core_Load_Private_Entrypoint {
  ### Loads scripts under PRIVATE directory
  if [[ "${CFG_USE_PRIVATE_DIRECTORY}" == "true" ]]; then
    _file_is="entrypoint.sh" _file_path_is="$(pwd)/private/${_file_is}"
    if [[ -f "${_file_path_is}" ]]; then
      source "${_file_path_is}"
    elif [[ ! -f "${_file_path_is}" ]]; then
      my_message="Warning: You should set ${_file_path_is} for your own scripts." && Print_Warning
      my_message="See README for installation details." && Print_Warning_Stop
    else
      my_message="FATAL: Condition_File_Must_Be_Present | ${_file_path_is}" && Print_Fatal
    fi
  elif [[ "${CFG_USE_PRIVATE_DIRECTORY}" == "false" ]]; then
    echo "bypassed, ok" >/dev/null
  else
    my_message="FATAL: Config is broken regarding: 'CFG_USE_PRIVATE_DIRECTORY'." && Print_Fatal
  fi
}

function Core_Check_Path_Is_Root {

  # check if the user is at the same level as the ".git" directory,
  # which is located at the root of every git repository.
  # PR https://github.com/firepress-org/bashlava/pull/70

  current_dir=$(pwd)
  if [[ ! -d "$current_dir/.git" ]]; then
    my_message="FATAL: The terminal prompt must be at the root of the git repo and not into a sub-directory." && Print_Fatal
  else
    echo "Good, we are at the root of the git repo" >/dev/null 2>&1
  fi
}

### Entrypoint
function main() {
  trap script_trap_err ERR
  trap script_trap_exit EXIT
  ### Load .bashcheck.sh
  source "$(dirname "${BASH_SOURCE[0]}")/.bashcheck.sh"
  ### Default var & path. Customize if need. Usefull if you want
  # to have multiple instance of bashLaVa on your machine
  _path_user="/usr/local/bin" _var_name="_path_user" _is_it_empty="${_path_user}" && Condition_Vars_Must_Be_Not_Empty
  ### Reset path if needed
  Core_Reset_Bashlava_Path
  ### Set absolute path for the project root ./
  _path_bashlava="$(cat "${_path_user}"/bashlava_path)" _var_name="_path_bashlava" _is_it_empty="${_path_bashlava}" && Condition_Vars_Must_Be_Not_Empty
  ### Set absolute path for the ./components directory
  # every scripts that are not under the main bashLaVa app, should be threated as an components.
  # It makes it easier to maintain the project, it minimises cluter, it minimise break changes, it makes it easy to accept PR, more modular, etc.
  _path_components="${_path_bashlava}/components" _var_name="_path_components" _is_it_empty="${_path_components}" && Condition_Vars_Must_Be_Not_Empty
  ### Set absolute path for the ./docs directory
  _path_docs="${_path_bashlava}/docs" _var_name="_path_docs" _is_it_empty="${_path_docs}" && Condition_Vars_Must_Be_Not_Empty

  Core_Load_Config_Default
  Core_Load_Config_Override
  Core_Load_Components
  Core_Load_Private_Entrypoint
  Core_Test_Env_Vars
  Core_Check_Which_File_Exist
  Core_Load_Vars_Edge
  Core_Test_Env_Vars

  ### Core_Input_Checkpoint
  if [[ -z "$2" ]]; then #if empty
    input_2="not_set"
  elif [[ -n "$2" ]]; then #if not empty
    input_2=$2
  else
    my_message="FATAL: <input_2> = ${input_2}" && Print_Fatal
  fi

  if [[ -z "$3" ]]; then #if empty
    input_3="not_set"
  elif [[ -n "$3" ]]; then #if not empty
    input_3=$3
  else
    my_message="FATAL: <input_3> = ${input_3}" && Print_Fatal
  fi

  if [[ -z "$4" ]]; then #if empty
    input_4="not_set"
  elif [[ -n "$4" ]]; then #if not empty
    input_4=$4
  else
    my_message="FATAL: <input_4> = ${input_4}" && Print_Fatal
  fi

  ### Load fct via .bashcheck.sh
  script_init "$@"
  cron_init
  colour_init

  ### Ensure there are no more than three attributes
  Condition_Attr_4_Must_Be_Empty

  ### Acquire script lock
  if [[ "${CFG_LOCK_INIT}" == "true" ]]; then
    lock_init system
  elif [[ "${CFG_LOCK_INIT}" == "false" ]]; then
    echo "bypassed, ok" >/dev/null
  else
    my_message="FATAL: Config is broken regarding: 'CFG_LOCK_INIT'." && Print_Fatal
  fi

  ### optionnal Trace the execution of the script to debug (if needed)
  if [[ "${CFG_DEBUG_MODE}" == "true" ]]; then
    set -o xtrace
  elif [[ "${CFG_DEBUG_MODE}" == "false" ]]; then
    echo "bypassed, ok" >/dev/null
  else
    my_message="FATAL: Config is broken regarding: 'CFG_DEBUG_MODE'." && Print_Fatal
  fi

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
  echo "OK, user did not provide argument. Show options" >/dev/null 2>&1
  _doc_name="welcome_to_bashlava.md" && clear && Show_Docs

  read -r user_input
  echo
  case ${user_input} in
  # Dont use the shortcut 't' here! Its used for fct 'tag'
  1 | h) clear && help ;;
  2 | tt) clear && test ;;
  *) my_message="Aborted - Invalid input." Print_Fatal ;;
  esac

elif [[ -n "$1" ]]; then
  echo "Good, user did provide argument(s)." >/dev/null 2>&1
else
  my_message="FATAL: main (When no arg are provided)" && Print_Fatal
fi

# END OF SCRIPT
