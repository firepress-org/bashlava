TODO

_______________________________________________________________________________________
REQ TEMPLATE _________________________________________________________________________

## New Feat: 0o0o

- 0o0o
- 0o0o
- 0o0o
- PR URL
- Impact: #8 UX 🎛️
- Impact: #10 Logic & Condition 🧠
- Impact: #11 Documentation 🧵
- Impact: #9 Bugfix 🐛
- Impact: Code Refactoring #72 🛠️

_______________________________________________________________________________________
FEATURES P1 ___________________________________________________________________________

## Code Refactoring: Removing .bl_env.sh

- Refactor the code to remove the file `.bl_env.sh` and integrate its variables directly within `bashlava.sh`.
- Reduce the reliance on an additional file.
- Impact: Code Refactoring #72 🛠️

## Minor stuff

- help cs() / Fix typo in docs/help.md

## Code Refactoring: Core_Load_Config_Override() 

- Still needed?
- Impact: #10 Logic & Condition 🧠
- Impact: Code Refactoring #72 🛠️

TODO

Faire une liste rapide de toutes les Fct dans `utilities`
le but est de listé toutes mes scripts tel que qobuz, youtube, nas_sync, etc

TODO

Create a GHA that will create an issue every mounth as a task reminder.

- this should be under projet/repo "you rock"
- Check what the latest base image for ubuntu :jammy-20220815
- Check what the latest base image for node :
- CVE
- Test and restore backup
- even stuff related to my personnal life once the process is solid
- etc

_______________________________________________________________________________________
FEATURES P2 ___________________________________________________________________________

0o0o
  re-org *.md under dir : /prompts , /how-to, /random

0o0o
New feat: ssq() = suggest sq
- Create a fct that search for the same commit messages in previous commits
- then suggestion to do git showa squash, then prompt user y/n

0o0o: 
Weird: tag() still prompt on bashlava, but does not on project mycrypt .. ?

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

0o0o Show_Fct_Category_F1 , F2
- revisit this function once all file are solid + private logic

_______________________________________________________________________________________
FEATURES P3 ___________________________________________________________________________

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

0o0o dummy
- dummy