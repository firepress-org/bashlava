TODO

---

REQ TEMPLATE — — — — — — — — —

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

---

FEATURES P1 — — — — — — — — —

TODO

## gh is missing

if gh is missing show` brew install gh` then `gh auth login`

example:

➜ ghostfire git:(edge_8fe) gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations on this host? SSH
? Upload your SSH public key to your GitHub account? /Users/jimmy/.ssh/id_ed25519.pub
? Title for your SSH key: GitHub CLI
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: BC4F-FAC0
Press Enter to open github.com in your browser...
✓ Authentication complete.

- gh config set -h github.com git_protocol ssh
  ✓ Configured git protocol
  ✓ SSH key already existed on your GitHub account: /Users/jimmy/.ssh/id_ed25519.pub
  ✓ Logged in as pascalandy
  ! You were already logged in to this account

TODO

## bug release

andy16@andy16:~/Documents/github_firepress/yourock2|main ⇒ bashlava.sh r  
This command must be executed on the Main branch.

- Impact: #9 Bugfix 🐛

TODO

## New Feat: 0o0o

- Use ollama LLM Llama 2 instead of chatGPT-shell-cli
- PR URL
- Impact: #8 UX 🎛️
- Impact: #10 Logic & Condition 🧠
- Impact: #11 Documentation 🧵
- Impact: #9 Bugfix 🐛
- Impact: Code Refactoring #72 🛠️

TODO

## New Feat: Rename_MD_Files_DoubleSpaces()

draft: under /components/utility

As a user, I want to run a bash script that will identify Markdown files within a specific source directory and its subdirectories. The script should check the filenames for the presence of two or more consecutive spaces and rename those files to eliminate the extra spaces.

Here are the requirements for the bash script:

- Scan all .md files in the source_dir and its subdirectories.
- It should identify file names that contain two or more spaces.
- The script should rename the files, removing the extra spaces.
- The content within the files should be ignored.
- The script should be compatible with iTerm2 on a Mac.
- For example, the script should be able to identify a file named "test tqwe.md".
- The source_dir should be set as follows: `source_dir="/Users/andy16/Documents/_my_docs/51_office_CV/vault_obsidian/_cards"`

fct: Utility

- PR URL
- Impact: #8 UX 🎛️
- Impact: #10 Logic & Condition 🧠

## New Feat: gpt_tot

- draft: under /components/utility
- Test this question: I left 5 clothes to dry out in the sun. It took them 5 hours to dry completely. How long would it take to dry 30 clothes?
- 0o0o
- PR URL
- Impact: #8 UX 🎛️
- Impact: #10 Logic & Condition 🧠
- Impact: #11 Documentation 🧵
- Impact: #9 Bugfix 🐛
- Impact: Code Refactoring #72 🛠️

TODO

## Code Refactoring: Core_Load_Config_Override()

- Still needed?
- Impact: #10 Logic & Condition 🧠
- Impact: Code Refactoring #72 🛠️

TODO

Faire une liste rapide de toutes les Fct dans `utilities`
le but est de listé toutes mes scripts tel que qobuz, youtube, nas_sync, etc

TODO

make it easier to install.
Ex: curl -sS https://raw.githubusercontent.com/0xacx/chatGPT-shell-cli/main/install.sh | sudo -E bash

TODO

Create a GHA that will create an issue every mounth as a task reminder.

- this should be under projet/repo "you rock"
- Check what the latest base image for ubuntu :jammy-20220815
- Check what the latest base image for node :
- CVE
- Test and restore backup
- even stuff related to my personnal life once the process is solid
- etc

TODO

Work along https://github.com/nektos/act to minimize github actions commits

TODO

The command r() can be replaced with a github actions such as:
https://github.com/marvinpinto/action-automatic-releases

and will be trigged only if the branch was Tagged.

TODO

set of actions: https://github.com/sdras/awesome-actions

---

FEATURES P2 — — — — — — — — —

0o0o
re-org \*.md under dir : /prompts , /how-to, /random

0o0o
New feat: ssq() = suggest sq

- Create a fct that search for the same commit messages in previous commits
- then suggestion to do git showa squash, then prompt user y/n

0o0o:
Weird: tag() still prompt on bashlava, but does not on project mycrypt .. ?

TODO
Optimize code: Instead of creating custom var simply use %1 %2 <=dollar sign

REPLACE:
my_message="FATAL: {\_branch_dev_unique} (local)" && Print_Fatal
WITH THIS:
Print_Fatal "FATAL: {\_branch_dev_unique} (local)"

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
optimize my*message when calling
Print*
Banner\_

0o0o EDGE_EXTENTED
edge() prompt user

OPTIONS ARE:

1. CREATE edge_neW and DELETE edge_olD (default)
2. CREATE edge_neW and KEEP edge_olD
3. CREATE custom_neW and DELETE edge_olD only
4. CREATE custom_neW and KEEP edge_olD only

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

---

FEATURES P3 — — — — — — — — —

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
