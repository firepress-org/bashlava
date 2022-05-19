#!/usr/bin/env bash

: '
// COMMENT BLOCK //
TO-DO comment section. Total of 3

PINNED issues on GH             _
  issue #4 TO-DO & backlog      _
  issue #8 UX                   _
  issue #9 Bugfix               _
  issue #10 Logic & Condition   _
  issue #11 docs                _

PR Title: New Feat: 0o0o
- 0o0o
- 0o0o
- Impact on: #4, #8, #9 #10


_______________________________________________________________________________________
_______________________________________________________________________________________
PRIORITY 1 ____________________________________________________________________________


TODO
New feat: verify gpg signature on commits, merge, tag
- Add config: CFG_TAG_ARE_SIGNED
- update dummy()
- update commit()
- in ~/.gitconfig
  - signingKey = 466798446A36CC66A9AA58BEBEF00F535005628E
  - gpgsign = true
- Impact on: #4, #8

TODO
gc()
  CONFIG: is if key is: symetric OR pub/priv
    if symetric, we need to define a custom path for the key
    most likely define in /private/entrypoint
    Default pub/priv
  CONFIG: do a gc on() when test()
    default is false

  check if projet have .git-crypt
    else warn this project does have gc setup


TODO
- start a new git repo to test gc 
- create key as new user on new computers to ensure how_to_use_gitcrypt.md is correct

_______________________________________________________________________________________
_______________________________________________________________________________________
PRIORITY 2 ____________________________________________________________________________


TODO
Optimize code: Instead of creating custom var simply use %1 %2 <=dollar sign

REPLACE:
  my_message="FATAL: {_branch_dev_unique} (local)" && Print_Fatal
WITH THIS:
  Print_Fatal "FATAL: {_branch_dev_unique} (local)"

  function greet () {
    echo "Hello @1"
  }
  greet "you"


0o0o ci pipeline
- superlinter (includes shellcheck)
- create ci for using shellcheck
- execute test()


0o0o
Fix dependabot read-only annoyance
https://github.com/marketplace/actions/fetch-metadata-from-dependabot-prs


0o0o
optimize my_message when calling
  Print_
  Banner_


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
- Create a fct that search for the same commit messages in previous commits
- then suggestion to do a squash, then prompt user y/n

0o0o Show_Fct_Category_F1 , F2
- revisit this function once all file are solid + private logic

0o0o RANDOM NOTES
- multipass.run / shell
- var subtitution example
- GH enviroment (staging, prod)
- re-use workflow
- List files on B2
- per example: https://github.com/fatih/dotfiles

0o0o pending
- v_and_t
- ARRAY CFG_LIST_OF_REQ_MARKDOWN + CFG_LIST_OF_REQ_COMPONENTS


// COMMENT BLOCK //
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

  git checkout ${CFG_DEFAULT_BRANCH}
  git pull origin ${CFG_DEFAULT_BRANCH} && echo
  log
}

function edge { # User_
  Condition_Attr_2_Must_Be_Empty       # fct without attributs
  Condition_No_Commits_Pending
  Condition_Apps_Must_Be_Installed
  _from_fct="e"

### Logic to manage and generate unique edge name
### =============================================

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
  _branch_exist=$(git ls-remote --heads https://github.com/"${GITHUB_USER}"/"${APP_NAME}".git "${_branch_dev_unique}" | wc -l)
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
    _default_edge_prefix="${CFG_DEFAULT_DEV_BRANCH}" _random_char=$(openssl rand -hex 4 | colrm 4)
    # Store to file
    echo "${_default_edge_prefix}_${_random_char}" > "${_path_lib}/Application Support/${_path_last_part}"
    # Get the new generated _branch_dev_unique
    _branch_dev_unique=$(cat "${_path_lib}/Application Support/${_path_last_part}")
  else
    my_message="FATAL: ${CFG_DEFAULT_DEV_BRANCH}" && Print_Fatal
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

  git status && git add -A

  if [[ "${CFG_TAG_ARE_SIGNED}" == "true" ]]; then
    git commit -S -m "${input_2}"
    echo "WIP commit should be signed"
  elif [[ "${CFG_TAG_ARE_SIGNED}" == "false" ]]; then
    git commit -m "${input_2}"
    echo "WIP commit is NOT signed"
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
  input_2="not_set"   #reset input_2
  read -r user_input;
  case ${user_input} in
    1 | v) version;;
    2 | t) tag;;
    3 | e) edge;;
    4 | ci) ci;;
    *) my_message="Aborted" && Print_Gray;;
  esac
  # Add new fct allow the user to: v + t + r + e in one step
}

function version { # User_
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

# TODO
### Update version within .bashlava_env_override.sh
  _file_is="${CFG_CUSTOM_CONFIG_FILE_NAME}" _file_path_is="$(pwd)/${_file_is}" && Condition_File_Must_Be_Present
  sed -i '' "s/^APP_VERSION=.*$/APP_VERSION=\"${input_2}\"/" "${_file_path_is}"

  ### Reload default configurations as the version was updated
  source "${_file_path_is}"

  git add .
  git commit . -m "Update ${APP_NAME} to version ${input_2}"
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

  if [[ "${CFG_TAG_ARE_SIGNED}" == "true" ]]; then
    git tag -s "${APP_VERSION}" -m "tag: {APP_VERSION} using bashlava"
  elif [[ "${CFG_TAG_ARE_SIGNED}" == "false" ]]; then
    git tag "${APP_VERSION}"
  else
    my_message="FATAL: tag" && Print_Fatal
  fi

  git push --tags
  echo
  Show_Version
  Show_Tag

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

  # I would like to not have the v in the release https://github.com/cli/cli/issues/5609
  #                'v' is an attribut required by gh cli
  gh release create "$(git describe --tags --abbrev=0)" --generate-notes
  
  sleep 0.3
  Show_Version && sleep 0.3
  Show_Tag && sleep 0.3

  Show_Release
# CFG_RELEASE_POPUP / add logic 0o0o

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

  git --no-pager log --decorate=short --pretty=oneline --abbrev-commit -n"${CFG_LOG_LINE_NBR_LONG}"

  if ! [[ "${input_2}" =~ ^[0-9]+$ ]] ; then
    my_message="Oups, syntax error." && Print_Warning_Stop
  else
    echo "Ok, lets squash" > /dev/null 2>&1
  fi

  git reset --soft HEAD~"${input_2}" &&\
  git commit -m "${input_3}" &&\
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
  open https://github.com/${GITHUB_USER}/${APP_NAME}/actions/

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
  _from_fct="d"
  _in_file="./docs/DUMMY.md"

  # create two commits in a row
  for lineID in $(seq 1 2); do
    date_nano="$(date +%Y-%m-%d_%HH%Ms%S-%N)"
    _hash=$(echo "${date_nano} ${lineID}" | sha256sum | awk '{print $1}')
    _hash_four_last="${_hash: -4}"
    echo "Dummy Commit ${lineID} - $(date +%Y-%m-%d_%HH%M_%S) - ${_hash}" >> "${_in_file}"
    git add -A && git commit -m "Dummy Commit ${lineID} - ${_hash_four_last}"
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
    echo "bypassed, ok" > /dev/null
  else
    my_message="FATAL: Config is broken regarding: 'CFG_TEST_SHOW_VARS'." && Print_Fatal
  fi

  echo
  Condition_Apps_Must_Be_Installed
  my_message="Check apps required: All good!" Print_Gray     # else the Condition will stop the script

  if [[ "${CFG_TEST_OPTIONAL_APPS}" == "true" ]]; then
    my_message="Check optionnal apps:" Print_Gray
    Condition_Apps_Installed_Is_Optionnal
  elif [[ "${CFG_TEST_OPTIONAL_APPS}" == "false" ]]; then
    echo "bypassed, ok" > /dev/null
  else
    my_message="FATAL: Config is broken regarding: 'CFG_TEST_OPTIONAL_APPS'." && Print_Fatal
  fi

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
      -F "code=${input_3}" &&\

    # PREVIEW
    echo && my_message="Let's open: https://git.io/${input_3}" && Print_Blue && sleep 2 &&\
    open https://git.io/${input_3}
  }

  echo
  my_message="URL ........ : https://git.io/${APP_NAME}" && Print_Gray
  my_message="will point to: https://github.com/${GITHUB_USER}/${APP_NAME}" && Print_Gray
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
    input_2="not_set"   #reset input_2
    read -r user_input;
    case ${user_input} in
      1 | on | un) gc_on;;
      2 | off | lock) gc_off;;
      3 | s | status) gc_status;;
      4 | l | list) gc_list;;
      5 | h | help) gc_help;;
      *) my_message="Aborted" && Print_Gray;;
    esac
  else
    my_message="FATAL: The command does not exist." && Print_Fatal
  fi
}
### CHILD FUNCTIONS
    function gc_on { # Child_
      Condition_No_Commits_Pending
      git-crypt unlock
      # clear the warning. See https://github.com/firepress-org/bashlava/issues/40
      clear
      my_message="git-crypt unlocked your files/dir." && Print_Green
      file "$(git-crypt status -e | head -1 | awk '{print $2}')"
    }
    function gc_off { # Child_
      Condition_No_Commits_Pending
      git-crypt lock
      my_message="git-crypt locked your files/dir." && Print_Green
      file "$(git-crypt status -e | head -1 | awk '{print $2}')"
    }
    function gc_status { # Child_
      git-crypt status -e && echo
      git-crypt status -u && echo
      git-crypt status -f
      file "$(git-crypt status -e | head -1 | awk '{print $2}')"
    }
    function gc_keys { # Child_
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
  my_message="${APP_VERSION} < VERSION in ${CFG_CUSTOM_CONFIG_FILE_NAME}" Print_Gray
}
function Show_Tag {
  if [[ -n $(git tag -l "${APP_VERSION}") ]]; then
    echo "Good, a tag is present" > /dev/null 2>&1
    latest_tag="$(git describe --tags --abbrev=0)"
    _var_name="latest_tag" _is_it_empty="${latest_tag}" && Condition_Vars_Must_Be_Not_Empty
  else
    echo "Logic: new projet don't have any tags. So we must expect that it can be empty" > /dev/null 2>&1
    latest_tag="none "
  fi
  my_message="${latest_tag} < TAG     in ${CFG_DEFAULT_BRANCH}" Print_Gray
}

function Show_Release {
  release_latest=$(curl -s "https://api.github.com/repos/${GITHUB_USER}/${APP_NAME}/releases/latest" | grep '"tag_name": ' | awk '{print $2}' | sed -e 's/"//g' | sed -e 's/,//g' | awk '{print $1}')
  _var_name="release_latest" _is_it_empty="${release_latest}" && Condition_Vars_Must_Be_Not_Empty

  my_message="${release_latest} < RELEASE on https://github.com/${GITHUB_USER}/${APP_NAME}/releases/tag/${release_latest}" && Print_Gray
  echo
}

function Show_Docs {
  # idempotent checkpoint
  _var_name="DOCKER_IMG_GLOW" _is_it_empty="${DOCKER_IMG_GLOW}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="_doc_name" _is_it_empty="${_doc_name}" && Condition_Vars_Must_Be_Not_Empty

  _present_path_is="$(pwd)"
  _file_is="${_doc_name}" _file_path_is="${_path_docs}/${_doc_name}" && Condition_File_Must_Be_Present

  cd ${_path_docs} || { echo "FATAL: Show_Docs / cd"; exit 1; }
  docker run --rm -it -v "$(pwd)":/sandbox -w /sandbox ${DOCKER_IMG_GLOW} glow -w 110 "${_doc_name}"
  cd ${_present_path_is} || { echo "FATAL: Show_Docs / cd"; exit 1; }
}

function Show_What_Was_Done {
  echo && my_message="(${_from_fct}) was done.                          ${APP_NAME} $(git rev-parse --abbrev-ref HEAD)" && Print_Green
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
  _var_name="DOCKER_IMG_GLOW" _is_it_empty="${DOCKER_IMG_GLOW}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="input_2" _is_it_empty="${input_2}" && Condition_Vars_Must_Be_Not_Empty
  my_message="Info: 'mdv' can only read markdown files at the same path level" Print_Green
  sleep 0.5

  _present_path_is=$(pwd)
  _file_is="${input_2}" _file_path_is="${_present_path_is}/${input_2}" && Condition_File_Must_Be_Present

  docker run --rm -it -v "$(pwd)":/sandbox -w /sandbox ${DOCKER_IMG_GLOW} glow -w 120 "${input_2}"
}

function Print_Banner {
  _var_name="DOCKER_IMG_FIGLET" _is_it_empty="${DOCKER_IMG_FIGLET}" && Condition_Vars_Must_Be_Not_Empty
  _var_name="my_message" _is_it_empty="${my_message}" && Condition_Vars_Must_Be_Not_Empty
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
  echo "function not required yet"
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
  # Version is limited to these characters: 1234567890.rRCc-
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
  _compare_me=$(which gh | grep -c "/gh")
  _compare_you="1" _fct_is="Condition_Apps_Must_Be_Installed"
  Condition_Vars_Must_Be_Equal
  # my_message="gh cli is installed" && Print_Gray
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
  echo
  my_message="All apps are installed" && Print_Gray
}

function Core_Check_Which_File_Exist {
  # List markdown files under /docs/*
  for action in "${CFG_LIST_OF_REQ_MARKDOWN[@]}"; do
    _file_is="${action}" _file_path_is="${_path_docs}/${_file_is}" && Condition_File_Must_Be_Present
  done

  # List files under /components/*
  arr=( "utilities.sh" "alias.sh" "show_fct_category_filter.sh" "example.sh" "list.txt" )
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
    readlink "$(which bashlava.sh)" > "${_path_user}/bashlava_path_tmp"
    rm ${_path_user}/bashlava_path
# this will strip "/bashlava.sh" from the absolute path
    cat "${_path_user}/bashlava_path_tmp" | sed "s/\/bashlava.sh//g" > "${_path_user}/bashlava_path"
# clean up
    rm ${_path_user}/bashlava_path_tmp
  elif [[ -f ${_path_user}/bashlava_path ]]; then
      echo "Path is valid. Lets continue." > /dev/null 2>&1
  else
    my_message="FATAL: Core_Reset_Bashlava_Path | ${dir_path_is}" && Print_Fatal
  fi
}

function Core_Load_Vars_Edge {
### edge
  # This is where we dynamically store the edge name
  # Can't pass the path as a var because of the space in the path (/Application Support)
  # I guess it's just me not knowing how to manage this :-p
  # It does not make sens to Condition_Vars_Must_Be_Not_Empty
  _path_lib="${HOME}/Library"
  _var_name="_path_lib" _is_it_empty="${_path_lib}" && Condition_Vars_Must_Be_Not_Empty

  mkdir -p "${_path_lib}/Application Support/FirePress/bashlava"
  _path_last_part="FirePress/bashlava/${APP_NAME}_dev_branch_name_is"
  _var_name="_path_last_part" _is_it_empty="${_path_last_part}" && Condition_Vars_Must_Be_Not_Empty

  _branch_dev_unique=$(cat "${_path_lib}/Application Support/${_path_last_part}")
  _var_name="_branch_dev_unique" _is_it_empty="${_branch_dev_unique}" && Condition_Vars_Must_Be_Not_Empty
}

function Core_Show_Env_Vars {
  Core_Test_Env_Vars

  my_message="Check env_vars from config:" && Print_Blue
  echo
  echo "CFG_OVERRIDE_WITH_CUSTOM_CONFIG   > ${CFG_OVERRIDE_WITH_CUSTOM_CONFIG}"
  echo "CFG_CUSTOM_CONFIG_FILE_NAME       > ${CFG_CUSTOM_CONFIG_FILE_NAME}"
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
  echo "CFG_LIST_OF_OPTIONAL_APPS          > ${CFG_LIST_OF_OPTIONAL_APPS}"
  echo
  echo "DOCKER_IMG_FIGLET                 > ${DOCKER_IMG_FIGLET}"
  echo "DOCKER_IMG_GLOW                   > ${DOCKER_IMG_GLOW}"
}

function Core_Test_Env_Vars {
### NEW CONFIG
_var_name="CFG_OVERRIDE_WITH_CUSTOM_CONFIG" _is_it_empty="${CFG_OVERRIDE_WITH_CUSTOM_CONFIG}" && Condition_Vars_Must_Be_Not_Empty
_var_name="CFG_CUSTOM_CONFIG_FILE_NAME" _is_it_empty="${CFG_CUSTOM_CONFIG_FILE_NAME}" && Condition_Vars_Must_Be_Not_Empty

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

### Load default configurations
  _file_is=".bashlava_env.sh" _file_path_is="${_path_bashlava}/${_file_is}" && Condition_File_Must_Be_Present
  source "${_file_path_is}"

### Load custom configurations
  if [[ "${CFG_OVERRIDE_WITH_CUSTOM_CONFIG}" == "true" ]]; then
    _file_is="${CFG_CUSTOM_CONFIG_FILE_NAME}" _file_path_is="$(pwd)/${CFG_CUSTOM_CONFIG_FILE_NAME}" && Condition_File_Must_Be_Present
    source "${_file_path_is}"
  elif [[ "${CFG_OVERRIDE_WITH_CUSTOM_CONFIG}" == "false" ]]; then
    my_message="Config file is missing or not well configured: '${CFG_CUSTOM_CONFIG_FILE_NAME}"   && Print_Warning
    my_message="See README for installation details."                                             && Print_Warning_Stop
  else
    my_message="FATAL: Config is broken regarding: 'CFG_OVERRIDE_WITH_CUSTOM_CONFIG'." && Print_Fatal
  fi

### I can't pass an array from `.bashlava_env.sh` to `bashlava.sh`
  CFG_LIST_OF_REQ_MARKDOWN=( "welcome_to_bashlava.md" "help.md" "test.md" "debug_upstream.md" )
  CFG_LIST_OF_REQ_COMPONENTS=( "alias.sh" "example.sh" "utilities.sh" "Show_Fct_Category_Filter.sh" )
  CFG_LIST_OF_OPTIONAL_APPS=( "docker" "gh" "git-crypt" "gpg" "openssl" "sha256sum" "grep" "nano" "tldr" "shellcheck" )

### Load COMPONENTS (PUBLIC)
  for action in "${CFG_LIST_OF_REQ_COMPONENTS[@]}"; do
    _file_is="${action}" _file_path_is="${_path_components}/${_file_is}" && Condition_File_Must_Be_Present
    # code optimization, add logic: _to_source="true" 0o0o
    source "${_file_path_is}"
  done

### Loads scripts under PRIVATE directory 
  if [[ "${CFG_USE_PRIVATE_DIRECTORY}" == "true" ]]; then
    _file_is="entrypoint.sh" _file_path_is="$(pwd)/private/${_file_is}"
    if [[ -f "${_file_path_is}" ]]; then
      source "${_file_path_is}"
    elif [[ ! -f "${_file_path_is}" ]]; then
      my_message="Warning: You should set ${_file_path_is} for your own scripts."   && Print_Warning
      my_message="See README for installation details."                             && Print_Warning_Stop
    else
      my_message="FATAL: Condition_File_Must_Be_Present | ${_file_path_is}" && Print_Fatal
    fi
  elif [[ "${CFG_USE_PRIVATE_DIRECTORY}" == "false" ]]; then
    echo "bypassed, ok" > /dev/null
  else
    my_message="FATAL: Config is broken regarding: 'CFG_USE_PRIVATE_DIRECTORY'." && Print_Fatal
  fi

  Core_Load_Vars_Edge
  Core_Check_Which_File_Exist
  Core_Test_Env_Vars

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

### Ensure there are no more than three attributes
  Condition_Attr_4_Must_Be_Empty

### Acquire script lock
if [[ "${CFG_LOCK_INIT}" == "true" ]]; then
  lock_init system
elif [[ "${CFG_LOCK_INIT}" == "false" ]]; then
  echo "bypassed, ok" > /dev/null
else
  my_message="FATAL: Config is broken regarding: 'CFG_LOCK_INIT'." && Print_Fatal
fi

### optionnal Trace the execution of the script to debug (if needed)
if [[ "${CFG_DEBUG_MODE}" == "true" ]]; then
  set -o xtrace
elif [[ "${CFG_DEBUG_MODE}" == "false" ]]; then
  echo "bypassed, ok" > /dev/null
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

# END OF SCRIPT
