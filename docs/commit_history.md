dd166c59 Branch backup
55eb5262 Update bashlava to version 1.28.0
a37eefc1 show() is wip
5ae5bead shellcheck, ignore SC1083
057a2782 rename log
6a19ea69 dummy commit b
56af7bd4 dummy commit
dfae0ad8 Rollback syntax for git merge squash /sq
fdafeafd Rollback syntax for git merge --squash
34f85b2b Add disable code for shellcheck
0e8ed551 Add disable code for shellcheck
8f56dd18 fix read -r
145c6c97 Fix if double bracket
37dbe943 Fix if double bracket
d7d8fbac Fix git merge --squash
af106260 Improve error handling on cd
4df07aa7 Fix \_is_it_empty= var
984e1ca9 Fix read -r commands
aa533f7a Refactor example case_c
eca6cd8c rename to Print_Yellow
c98486d8 Docs Prompt_All_Available_Fct.md wip
820ef1e1 rename to Core_Reset_Bashlava_Path
0ace17e9 rename to Show_All
d1798182 rename to Print_mdv
9733f29d rename to Print_Banner
320cc918 rename to mdv (App_Glow)
9c14ae57 rename to Show_Release
c30e4259 rename to Show_Version
ffed3681 rename to Condition_No_Commits_Pending
4b8fd0d4 rename to App_test_color
93f71f0b rename to App_Check_Which_File_Exist
a37339ac rename to Core_Load_Vars_Dockerfile
17a42b0c rename to Core_Load_Vars_General
5a6ccec6 rename to Print_Fatal
763bdfcf rename to Print_Warning
b9f1d23a rename to Print_Blue
0de93e9e rename to Print_Green
07deef8d Rename to App_Gray
28c4faca New fct App_List_All_Fct() work in progress /sq
aa5fd00a rename /components/sidecars.sh
6a8b08ba rename file /components/example.sh
a6171ac6 Remove RELEASE / app_release / version_with_rc /sq
ed938063 Update bashlava to version 1.27.0
0ccb317d Greater UX using many interactive prompt selections /sq
de8609a9 New function: Prompt_YesNo_ci()
be1d9eb5 Move code block App_Load_Vars()
1545c8b5 Update tag() with a 5 sec delay
c24b2723 Update bashlava to version 1.26.0
b5b61b77 Improve UX: pr() and mrg()
e771e371 There are 15x TODO in the code << comment
0291bf11 rename: Condition_Branch_Must_Be_Mainbranch << App_Is_mainbranch
aa65938a rename: Condition_Dir_Optionnally_Present << as a comment
b5a5e2fe rename: Condition_Dir_Must_Be_Present << App_Does_Directory_Exist
8983f655 rename: Condition_File_Optionnally_Present << Condition_File_Must_Be_Present_NoStop
f40dcb1a App_Check_Which_File_Exist << App_Check_Are_Files_Exist
eb882bf0 rename: Condition_File_Must_Be_Present << App_Does_File_Exist
9d26e1a3 rename: Condition_Vars_Must_Be_Not_Empty << App_Does_Var_Empty
37821ce6 rename: Condition_Vars_Must_Be_Not_Equal << App_Are_Var_Not_Equal
80f4907b rename: Condition_Vars_Must_Be_Equal << App_Are_Var_Equal
1be074e0 Add Condition_Attr_4_Must_Be_Provided << as a comment
c51dc233 rename: Condition_Attr_4_Must_Be_Empty << App_input_4_Is_Empty_As_It_Should
e3058d2d rename: Condition_Attr_3_Must_Be_Empty << App_input_3_Is_Empty_As_It_Should
4564a07c rename: Condition_Attr_3_Must_Be_Provided << App_Is_input_3_Provided
3931f5de rename Condition_Attr_2_Must_Be_Empty << App_input_2_Is_Empty_As_It_Should
22aee5b8 rename: Condition_Attr_2_Must_Be_Provided << App_Is_input_2_Provided
f8b98581 Condition_Branch_Must_Be_Edge << App_Is_edge
46499d96 rename: Condition_Version_Must_Be_Valid << App_Is_Version_Syntax_Valid
09e634b2 rename: Condition_Apps_Must_Be_Installed << App_Check_Required_Apps
d3ab9ba6 Rename condition / Condition_No_Commits_Must_Be_Pending < App_No_Commits_Pending
46f87357 Preparation to rename Apps that are Conditions /comments
7451ebc9 Improve UX: Warning messages
eeedfde9 UX improvement: prompts the user to see ci() within pr(), mrg()
70458bbf Update bashlava to version 1.25.0
4df5301f There is 17 TODO
f419f80d Condition around @main might fail, lets bypass it /sq
d6de392b Update docs
b7f03b9b Fix: variables fct version / Improve UX feedback: fct edge
85087b24 Improve UX feedbacks
15b126d4 Fix: fct sv
ff176b12 Improve UX: fct mrg
f63f5b86 Improve UX
2e700ec4 Improve UX fct App_Green /sq
e2b48591 Improve UX: fct ci
9838f356 rename variables within App_Does_File_Exist
ee4c8df0 Improve UX within color functions
d7bb627e Move fct App_Curl_url to templates.sh
836e70cf New alias 1=test, 2=help
de872a9e Normalize fatal error messages / App_Fatal
62dcf13d Rename fct: App_invalid_cmd
73787ee3 Fix input_1 logic
e4ee7011 Improve UX + docs /sq
6c96f73c Invoke main with args if not sourced /sq
fa42e816 Improve UX with emoji
f3c30ea1 Improve UX with emoji
1640ad67 Update README
87be03ba Update bashlava to version 1.24.0 /Dockerfile
95214a95 source files under /components using a array
d8bf5378 Rename fct to App_array
85bbb223 Update bashlava to version 1.23.3 /Dockerfile
c668bfa4 Fix: paths mostly relative ./docs that were broken | Optimize App_Show_Docs
f13ec264 Update more_commands.md
5e560723 Rename file as welcome_to_bashlava.md
74c51657 Fix fct: mdv
eae5720d Edit comments
abd3a467 Update bashlava to version 1.23.2 /Dockerfile
2ccd5ad2 Improve messages during the flow
6821962d Update TODO within comments
d409f77f Update bashlava to version 1.23.1 /Dockerfile
b238f652 dummy task to test the flow
f318fdcc Fix checkpoints during the pr, mrg, version, tag, release flow
6a640e19 Update bashlava to version 1.23.0 /Dockerfile
f97e59e7 Fix checkpoint when using App_input_2_Is_Empty_As_It_Should
6e25bee9 Update bashlava to version 1.22.0 /Dockerfile
a6806f80 comments: clean up and TODO organisation
4bcc9bda New fct: App_random_6
62badc15 Code refactor fct: test
d22bfc0b remove fct: banner as the user never use directly. See App_Banner
d2afc566 rename directory add-on to components and ajust paths
df91b99f Code refactor file: /add-on/templates.sh
ee1ed28c Code refactor fct: App_Check_Are_Files_Exist /sq
3f9fc0bb Code refactor fct: help
f2bc5da1 Code refactor fct: App_Check_Required_Apps + rename utilities
a9775036 Rename utility functions
867df7b5 Fix App_Does_Var_Empty in fct: ci
59f8516b Rename utility functions
2ccfdf49 capture invalid shortcuts, alias
f6d7f80a Code refactor, fct: App_Show_version
2540ce58 Add next step to fct: squash
ec28edb4 Code refactor, fct: commit /sq
8dc674b1 Rename un_set default values
37f31e08 New fct: App_Are_Var_Not_Equa
70e75f8a Rename fct: App_Are_Var_Equal
bf47e942 Update bashlava to version 1.21.0 /Dockerfile
093c6dd1 UX improvement: show what are the next steps /sq
d671799a Update bashlava to version 1.20.1 /Dockerfile
e31228e7 Improve logic when prompt for confirmation / fct: App_short_url
66ab66b0 Use 4 sec delay when showing the latest tag online
8bdbae1a Update bashlava to version 1.20.0 /Dockerfile
ecdb3274 Add 2 sec delay when we check for the latest tag during the release
403f91b9 Update bashlava to version 1.19.1 /Dockerfile
11ea0115 Improve fct: test / move markdown checks under fct ...
791fa367 improve docs
9c68beb8 Update bashlava to version 1.19.0 /Dockerfile
4e59e115 Fix typos
6509b73b Update bashlava to version 1.18.0 /Dockerfile
ba23a23c Add pr_upstream_issues.md
30ff0319 Add condition to: fct: help, Rollback fct: App_Is_input_2 + commit, Adding comments in fct: pr /sq
759d223b Code Refactor: version, commit / Next 3 TODO pending
c5962d7c Fix fct: App_Does_Var_Empty | Many code Refactor
245c2b65 Code refactor: App_Is_commit_unpushed /sq
2d25a3a4 New fct: App_Compare_If_Two_Var_Are_Equals /sq
b7a85579 deprecate fct: App_RemoveTmpFiles
d4946113 rename fct: test
b553fadf Code refactor: App_short_url, Fix App_Fatal, New fct: test_color
0cb044f4 Introducing color grey. fct: App_Gray /sq
88ebce85 Optimizing code: fct squash, Adding idempotent checkpoints (squash)
262324ba Code optimization: App_Are_files_existing, remove App_DefineVariables (squash)
42d344fc code optimization: fct version
a913d2c8 code optimization: fct mrg (squash)
e1a6f784 optimizing code: fct ci
3d500d8d optimizing code: fct pr
92e0aca4 new fct: App_Does_Var_Empty
49da38ac Code optimization, New fct: App_Does_File_Exist (squash)
6916cf0d Move alias to /add-on, Improve source file, Improve color syntax, autocompletion test (squash)
4e3c4449 Improve UX with markdown and color
29929f54 Update bashlava to version 1.18.0 /Dockerfile
2879a59b better colors management, idempotent entrypoints, better idempotent code_example (squash)
cfb19d50 remove un-needed \_entrypoint.sh under /add-on
6b7ffa4b regroup many functions under /add-on/code_example.sh
a6fb3ca9 fct commit: idempotent (squash)
b144538e Update comments
9b5d643d fct version: remove App_Is_mainbranch
377be52b improve docs
6097aba7 comment syntax (squash)
c5cd12e0 Update bashlava to version 1.17.0 /Dockerfile
32c511b1 fct sv: Optimize version functions into show version
0999c19f Clean up error + warning message ID
1a7fbd0c Clean up error + warning message ID
746cbcce Update bashlava to version 1.16.0 /Dockerfile
3af89230 Optimize the way we use fct: App_Get_var_from_dockerfile
a0e24a00 Limit glow to 120 char
4a720e97 Update bashlava to version 1.15.0 /Dockerfile
88df55be Add config: .editorconfig
da97f445 Update bashlava to version 1.14.0 /Dockerfile
cf871d09 Code refactoring, move functions to their logic order in the code
17ed5bf7 Update bashlava to version 1.13.0 /Dockerfile
4161c55f Rename continuous-integration-status to ci (squash)
1ddc44bc Update bashlava to version 1.12.0 /Dockerfile
1a362278 Deprecate all functions related to CHANGELOG
caa1a25d Update bashlava to version 1.11.0 /Dockerfile
46104f24 Add logic (case) when the user does not provide any attributs (squash)
6b00afc8 Update case example
c24b2990 Update bashlava to version 1.10.0 /Dockerfile
68f87754 Build case templates for better UX in bashlava
6e2a7c24 Update bashlava to version 1.9.0 /Dockerfile
72754ac3 move fct rebase-theme
6bbd7b4b Update bashlava to version 1.8.0 /Dockerfile
1294a81c Add .shellcheckrc from fork
271fa289 Update .bashcheck based on source.sh
b4bfeb1b Update bashlava to version 1.7.0 /Dockerfile
bf3629dd Add fct version-read within fct version + Move fcts up and down in the code
140ecaed Update bashlava to version 1.6.0 /Dockerfile
423e76ee Add fct version-read within fct tag
388da262 Update bashlava to version 1.5.0 /Dockerfile
9ad8bb2e remove logic to check if CHANGELOG.md is present (squash)
9e501a5f remove BACKLOG.md
39cb7156 Move BACKLOG.md into github
84b28a15 remove CHANGELOG.md
1992f8f5 Archive CHANGELOG.md
31505b1c Move help.md into DIR docs
7e8b19b5 add back to fct banner / dep from fct test
33329e23 private scripts: improve the logic and validate if private dir is present
c92a05c7 fct Help / major refactoring (squash)
2850ae1d Update bashlava to version 1.3.5 /Dockerfile
0686d651 FCT: tag / Add a note about release notes
e256293f Update bashlava to version 1.3.4 /Dockerfile
e16defdd fct: App_Is_mainbranch / update w/ strickier conditions (squash)
564e1cb2 Update bashlava to version 1.3.3 /Dockerfile
2f084b6a fct: App_Is_mainbranch / update w/ strickier conditions
7e9167de Update bashlava to version 1.3.2 /Dockerfile
22d14b94 fct:tag / ensure use it on the mainbranch
57e665d6 Update bashlava to version 1.3.1 /Dockerfile
ded7802e fct: tag, update UX with sleep delays
1cdbcda5 Update bashlava to version 1.4.0 /Dockerfile
34413ec8 Update bashlava to version 1.4.0 /Dockerfile
56713e98 fct: tag now using the gh release cli
f78d71df Update bashlava to version 1.3.0 /Dockerfile
edb98023 Update bashlava to version 1.3.0 /Dockerfile
584cbe08 New fct: mrg (merge the pr)
3a145e01 fct: pr opens the webpage + the fct: ci opens the webpage
f08b64fa Update App_Is_required_apps_installed for Docker
77a2d4f1 Update fct ci with gh cli
b42cbcc7 Remove hub cli (#37)
43d97607 Update bashlava to version 1.2.0 /Dockerfile
325e69e9 Update README
9055c3ad fct version: no need to be on edge to use it
df3e3e58 Update bashlava to version 1.1.0 /Dockerfile
a05bd3a1 fct version: no need to be on edge to use it
36e34686 New feature: pr (pull request without using the GUI, clean up
c745814a New feature: pr (pull request without using the GUI (#33)
40370a13 fct tag / Update release URL as a config (#30)
031afe49 Fix typo in fct tag
e99e4f69 fct edge / now it delete the edge branch on origin
f79718c9 FEAT: set config for main branch / stop using hard coded branch name
59f50a56 remove fct master-merge deprecate
990dabaf remove export mode
51d7f0df Remote fct release /deprecate
3ffdadaf Remote fct deploy /deprecate
9bfb59bc Remote fct deploy /deprecate
184b8d95 Remote fct release Deprecate
a261ecaa fct tag / doc
c49cdcac fct master-nosq is deprecated
6bc96d30 New fct tag (squash)
f0ea8f3a fct master / MJR logic update. We don't merge and squash from edge to master anymore
5c17aed3 update changelog
1230ad0b update
aa129ee9 Update bashlava to version 0.15.0 /Dockerfile
796c490b update fct test-bashlava
0d060a7d add comment
ada34787 Update bashlava to version 0.14.6 /CHANGELOG
a02f2df5 Update bashlava to version 0.14.6 /Dockerfile
559dd584 typo in CHANGELOG
05db3162 update and fix CHANGELOG
8ded67d7 Update bashlava to version 0.14.5 /Dockerfile
45a593a1 rollback deletion on the changelog
f18f0b34 Update bashlava to version 0.14.4 /Dockerfile
211c577b update release_message2 message
94127297 Update bashlava to version 0.14.3 /Dockerfile
dda0ef3d bypass title-accronyms
cda29134 update changelog
233ad6ba add bashlava_help.md to gitignore
a5c323d4 update our backlog
f8189fae rm fct title-accronyms
8f4733d3 Note to backlog
6be7715d Update bashlava to version 0.14.2 /CHANGELOG
ecd23e6f Update bashlava to version 0.14.2 /Dockerfile
a09e04c5 Add missing temp directory creation
2a588c2e Update bashlava to version 0.14.1 /CHANGELOG
b9e33a01 Update bashlava to version 0.14.1 /Dockerfile
e823152c Minor update to changelog template
c5b955cb Update bashlava to version 0.14.0 /CHANGELOG
4a99438d Update bashlava to version 0.14.0 /Dockerfile
72ff8f8f Update changelog template
747653cd Update bashlava to version 0.13.0 /CHANGELOG
740db4d8 Update bashlava to version 0.13.0 /Dockerfile
1e9afd7c remove checkpoint
2ee4b6e8 add checkpoint
f1415417 draft changelog
4b523e5b Update Dockerfile template
709445a0 Improve comments for hardcoded default values
5266da33 Remove checks on vars
0d06fcd2 move back three flags from Dockerfile into bashlava
24d5c246 move back three flags into bashlava
76f9a0d1 remove un-needed ‘init_dockerfile_ignore’
ec9b9052 remove alias passfull
d6e6493d Update bashlava to version 0.12.0 /CHANGELOG
c4217d08 ADD: new flags in Dockerfile for better control on configs. (squash)
dd3855e6 Update bashlava to version 0.11.0 /CHANGELOG
4177e313 Update bashlava to version 0.11.0 /Dockerfile
51632000 ADD MAJOR FEAT: In Dockerfile we have release flag (squash)
db1d09e5 Update bashlava to version 0.10.7 /CHANGELOG
1f6fe9d3 Update bashlava to version 0.10.7 /Dockerfile
1355ec43 FIX list-functions
2d035e16 Add notes in BACKLOG
e962379a fix typo in comments
0d5de09b Update passgen
14e6b561 UPDATE copy on README
7f409610 Add note to backlog + new Add-on examples (squash)
255dfdba Improve VAR handling
27058f0b Improve CHANGELOG copy (squash)
d7781f0e Update bashlava to version 0.10.6 /CHANGELOG
d1990cff Update bashlava to version 0.10.6 /Dockerfile
35c5f30c UPDATE: better handling of our paths + REMOVE unless logic App_Reset_Custom_path & App_Load_Add_on
1de4515c minor; rename message and example
09cae43e UPDATE: wip-sync-origin-from-upstream + version allow to have -r1 (squash)
95186630 Update bashlava to version 0.10.5 /CHANGELOG
230fbbf9 UPDATE release where 'edge' was sometime bypassed (squash)
07f10402 Update bashlava to version 0.10.4 /CHANGELOG
077c45b4 update master-nosq
5a70805f Update bashlava to version 0.10.4 (squash)
07f0c2b4 Update bashlava to version 0.10.4 /CHANGELOG
933846d2 Update bashlava to version 0.10.4 /Dockerfile
2389ef25 ADD: Add compare message in CHANGELOG + fix typo + add log to fct: version
872d22aa FIX: removed some rule that were in conflict when using ‘deploy’
7283fb50 update backlog
2aea16cd update backlog
786ffe9d UPDATE: make bashlava more idempotent
c19b79ec CHANGE fct shortner is now gitio
7ca586b0 UDPATE: various rules to minimize errors
bf840cd0 UPDATE: rename few fct + ADD rule to check if git repo is valid
59c9ec04 ADD init_dockerfile_ignore
0e96cf03 ADD: init_readme + regroup App rules
0124e194 add notes to backlog
f24bf7ee ADD: init_readme + regroup App rules
bfa88697 ADD: init_readme
73e2f6eb add notes to backlog
dd197aac IMPROVE copy in README
fc4ca34c FIX: reset flags + better comment indent + README updates (squash)
49d550f4 Better copy for our CHANGELOG (squash)
6cd9d70d Update bashlava to version 0.10.2 /CHANGELOG
6e242a50 Update bashlava to version 0.10.2 /Dockerfile
68992c58 UPDATE: `deploy` now without `m` + ADD: App_Is_Version_a_Valid_Number +
6d7173e9 ADD backlog notes
61501bc7 UPDATE: optimizing fct deploy
58bdbb7e UPDATE: Improve help-installation
d7d782f5 remove input_4 fct deploy is simpler
c49fc366 UPDATE: major update to deploy. It does not need the attr ‘m’ or ‘m-‘ anymore. Still wip.
469877a8 UPDATE: changelog
929d1b44 ADD: wip-sync-origin-from-upstream + reorgonize fct grouping
82fa6f1b minor move title function together
6a1cd39f minor rename fct
35809ddf minor updates README
d491fed6 UPDATE: fct edge: improve message
642b0074 IMPROVE changelog template (squash)
ed850bc8 EDIT: changelog formatting
587fadc6 UPDATE: in fct master, removed un-needed step ‘git push origin master’
43f30085 Update bashlava to version 0.10.1 /Dockerfile
c28b3ed9 REMOVE un-needed rule in App_Changelog_Update
fbc52579 UPDATE: master-merge + alias ‘m-m’
a342bfd1 ADD: fct master-merge + fct release don't need a version anymore
3745ba2e REMOVE App_UpdateDockerfileVersion logic
6441cdac improve alias
ec39e6fe IMPROVE: syntax remove space
24bfa40f UPDATE: Changelog formatting (squash)
b640130e Update bashlava to version 0.10.0 /CHANGELOG
cf6652d3 ADD: new fct deploy (d) (Expert mode), Bashlava can now receive 4 attributes (squash)
a2b27239 Update bashlava to version 0.9.22 (CHANGELOG)
821e78cb Update bashlava to version 0.9.22 (Dockerfile)
adc3e34a ADD: new fct App_Is_license + the logic to few fct parent
8006f092 UPDATE: Changelog template
6087e350 UPDATE README, help section
218598a2 Update bashlava to version 0.9.21 (CHANGELOG)
9665cf9a Update bashlava to version 0.9.21 (Dockerfile)
5eaf7392 ADD date in CHANGELOG when updating it
967cb0c6 CHANGELOG formatting updates
a1722801 Update bashlava to version 0.9.20 (CHANGELOG)
4a9a2064 Update bashlava to version 0.9.20 (Dockerfile)
07c469fd ADD: new fct shorturl (squash)
ce60e3e9 Update bashlava to version 0.9.19 (CHANGELOG)
c5ded688 UPDATE readme and video tutorials (squash)
826516a2 Update bashlava to version 0.9.18 (CHANGELOG)
c4265cb4 Update bashlava to version 0.9.18 (Dockerfile)
f7de1516 MINOR: radnom optimizations, no news features
bccb83d3 Add custom template
19543b03 Update bashlava to version 0.9.17 (CHANGELOG)
bbbe3446 Update README (squash)
2d5f7641 Update bashlava to version 0.9.16 (CHANGELOG)
9146442f Add intro video in README (squash)
d93ae7c9 UPDATE: README
0f7a9e87 Update bashlava to version 0.9.16 (Dockerfile)
8b98096f UPDATE: README (squash)
e34fcfa0 Update bashlava to version 0.9.15 (CHANGELOG)
137d0b75 Update bashlava to version 0.9.15 (Dockerfile)
31693fa7 RENAME bashLaVa (with capitals)
d06fe574 minor copy updates
e3666245 ADD section: help-installation
84158915 UPDATE: backlog, many things were shipped
c34984ff FIX: App_RemoveTmpFiles system prompt when rm un-existing file (squash)
b14c6fb2 FEAT: Add warning if not running on Mac.
04a6b95c Update bashlava to version 0.9.14 (CHANGELOG)
38b70baf Update bashlava to version 0.9.14 (Dockerfile)
5e5fe8d1 ADD: App_Configure_Custom_Path (auto-configuration), UPDATE: fct test, RENAME some VARS
7e07ad92 FIX: typo
7481bd3a UDPATE: templates
cd895100 Update LICENSE copy (still GNUv3)
6943fa59 UPDATE: Improve comments and copy
e1e096c9 typo
832e839a wip
eaf4e42b UPDATE: backlog
eeb557de FIX alias
c35bb79f UPDATE: list display, FIX: release-read (from Github), ADD: mdv for any .md files
b83101ac Fix typo
c3e0d1f6 UPDATE: help have a cleaner copy
f124c733 MOVE: cmd into utilities
2423f761 UPDATE: help have a cleaner copy
8ed85fb3 MOVE: cmd into utilities
5eda5dd7 update: help copy
3698a2af UPDATE: major fct renaming + improve /help
8b7fe7ab backlog updates
5f4605ae ADDED: /title-core-fct | Needed by /list
0090a02f rename dk dk-view cl-view / move docker_img_figlet into the global variables
fd9afb27 update BACKLOG
313e23b2 /help rename which to list
b5f59478 major alias (shortcut) revamp
bc17bd31 Update bashlava to version 0.9.13 (CHANGELOG)
628ea06f Update bashlava to version 0.9.13 (Dockerfile)
0e4dc42b ADD --help to alias
661808dd better copy for /help
a21fd909 add rule /App_Is_dockerfile in /dk
2aeb0344 init BACKLOG
bfff79a7 Update bashlava to version 0.9.12 (CHANGELOG)
554dce47 Update bashlava to version 0.9.12 (Dockerfile)
066c4be3 Add /log to /sq
d1afd4c5 FIX: re-write many > /dev/null 2>&1
212a22d5 Update bashlava to version 0.9.11 (CHANGELOG)
7b3bb76f Add fct /tag. This helps when we pushing app version. (squash)
f3cbf559 Improve: README
47c84c0d Improve: commit messages
a8724626 Improve App_Changelog_Update tmp file deletion & comments
3784b269 Update to version 0.9.10 in CHANGELOG
c00720c1 Improve commit message for <dk>, <master>, <release> /squash
be073f92 Update CHANGELOG to version 0.9.9
ac350c3f Improve release message / better explanation of what bashlava does /squashed
85ceca45 Update CHANGELOG to version 0.9.8
3edfb00c Improve Changelog and fix typo / Add <log> into <master> /squashed
98a242fd Update CHANGELOG to version 0.9.7
176d5a98 FIX changelog
878e2f28 Make the local variable more obvious / cleaner way to manage custom_scripts / better error handling
18474339 Update changelog
e91a2b4f Adding example for custom scripts
742365fd Update bashlava to version 0.9.7
beaa2e06 Improve fct CI / FIX custom_urls.sh
36685eab Improve template
71602edc Improve README
86bce502 Update CHANGELOG to version 0.9.6
0d2bec12 Optimize App_changelog_update & remove vars during QA
2d79b651 FEAT: in CHANGELOG create URLs from git commits, RENAME out-m & out-e
6ee27a2e new alias
22ead688 Changelog_Update / create URLs from git commits
b27be256 improved fct log
af815678 remove / New feat to add a compare link in changelog
174d22cd New feat to add a compare link in changelog / rename fct to App_Is_Input2 + App_Is_Input3
a14ccf70 init alias
909c531a improve prompt messages
4862c974 add alias, improve prompt messages
1b036307 FIX logic on <release>, improve comments
bd1e1c75 The abstraction is real. <cl> is now under <release>
67699989 dk: add comment
cdea7db0 improve comments
c2414dd4 bypass some code useful to debug
b67096b2 minor copy update
58960310 cl-push is now cl thanks to App_Changelog_Update
c8ce3b2f update release default copy
f8c12a13 Fix comment warnings
09f32afe fct dk: add logic to show version when no attributs are passed
e8e68615 rename dk-version to dk
1dfe01a9 update Dockerfile template
299082df improve alias
0e282f3a improve comments
fcb40750 fct cl FIX var, minor optimzations
c230360c init App_GetVarFromDockerile, dk-version now auto commit, various optimizations
e4ec3ab8 add comment
901d373f Improve help
24d5b90e Improve help splash
a777bf16 update logo size
aea9d7ac remove un-needed checkpoint
727e789a Update bashlava to v0.9.5
45345aa1 FIX if logic
e93682a1 Update bashlava to v0.9.4
12bbab05 Fix typo /squash
e947ebd5 Merge branch 'master' of github.com:firepress-org/bashlava
708cd60b Update bashlava to v0.9.3
f600a926 FIX var
f43fcddb FIX var
c6570d81 FIX tag when release AND add checkpoints when updating Dockerfile version /squash
f465731a add checkpoints when updating Dockerfile version
a446f622 debug tag during release
187009c7 debug tag fct
57a60a45 Update bashlava to v0.9.2
ffbfbfaf Add logic to see actual version when not providing a version
1addff9a help-workflow ==> major copy update
1c289613 fix lost &&, rename cl-read to cl-view, update version within the Dockerfile
567788a8 add alias: dk-show, cl-show
fb13a875 init cl-push, update Dockerfile version
932756a1 FIX missing title
3c0550fc remove checkpoints
0915afbe Updated to version: 0.9.1
97b37382 update to v0.9.1
52edb2f6 FIX img url in README
c2f8e617 add checkpoint to fct release
a51697dd Updated to version: 0.9.0
91c733c7 Update bashlava to 0.9.0
befb4c7f Update bashlava to 0.9.0
16f98cc3 init fct App_Is_commit_unpushed, merge App_Tag into fct release, Add missing rules, rename dk_update to dk_version
20954d5b update copy for workflow
e8c86a0c init alias version
5d991508 add alias r
2f85d175 rm App_is_env_local_path logic, it was a bad idea
8fc20a62 rm unrelated note
c37344ea Init App_is_env_local_path, Init App_Is_hub_installed, move functions by groups
a68f3add init init_env_local_path
c0d3d5e9 add env_local_path.sh to gitignore template
d01c4e4f removed fct App_release bc it’s now in fct release
937dc03c add checkpoint in fct master
bc8c1874 add alias appversion
640e3a05 remove comments
1bb36a2e rename edge-init to edge
6286fa8a minor
5e1f5f82 init App_Is_changelog
ed6ecae8 init App_Is_master, App_Is_Dockerfile
c82fe1c4 refactor fct release
f7a05515 Optimize Dockerfile template
8841eac0 update README, refactor fct cl, alias c /squash
8a0994c7 various code optimizations
610dbf0e init add-on/utilities.sh
43b7a907 update add-on/help
4b80939b move some fct under add-on/docker
2f7d67d4 update App_Stop
97128309 Rename project + new logo /squash
280e8308 update local path to this project
2754a0c1 Improve READ, Init add-on /squash
2cae444a Improve README, help: improve var /squash
7675c708 Shuffle fct positions AND various optimisations /squash
f06f4192 remove edge, use glow to read markdown /squash
07efa6d4 Merge branch 'master' of github.com:firepress-org/bash-script-template
5589586f major refactoring / master* edge* master-sq* /squash
fa60338a rm dummy file
cc3c42b5 major refactoring / master* edge* master-sq*
f15f7dc3 fct master is stable
6f174659 update edge
06c6f7b7 add masterv1-sq
7bba58d6 masterv2-sq / wip
2f5abd1f init stg + masterv2
b519d6d9 Merge branch 'master' into edge
07d0d2be init part 33 /squash
a695b81d part 33 fix typo
f23bbdc5 init part 33
deeff762 Merge branch 'master' into edge
00572155 Squashed commit of the following:
8ec45c70 remove part 31
0f8401ab rollback to merge
4da9c3f5 init part 32 / master-sq uses rebase /squash
d4c8b040 init section 32
5fca9036 master-sq use rebase /j
2e593332 Merge branch 'master' into edge
ccb2ee22 master-sq fix / delete part 25,26 / init part 27 /squash
09efd434 remove part 25,26
3b950786 init part 31
b4705889 fct master-sq /i
82f28586 Merge branch 'master' into edge
33c4873f Add part 26 / update master-sq /h /squash
1d5a8175 add part 26
4e5404f0 master-sq /h
4937fd00 Merge branch 'master' into edge
4c7ccfb5 master-sq /g
c15e3602 Merge branch 'master' into edge
66ad7146 RM part 22-24 / update master-sq /squash
1ba37475 RM part 22-24
4c064196 update master-sq /f
1a3fe291 Merge branch 'master' into edge
db5e01b5 fix master-sq / add part 25 /squash
ecd6d271 add part 25
9c2cbbfd master-sq /e
f1d4c2ad Merge branch 'master' into edge
623c0665 Merge branch 'edge'
7a5cb073 add part 23,24 /squash
cf87d907 master-sq /c
b3b16c0b add part 24
66691dff add part 23
ba28075d Merge branch 'edge' of github.com:firepress-org/bash-script-template into edge
5163f467 add part 22
1d97e919 add part 23
43a014f3 add part 22
18bcb239 add part 22
f1e35494 Add part 22,23 /squash
d6b8b8c9 add part 23
3ad88b4e add part 22
67f42015 fct master-sq /a
da0e58ad fct master updates /d
1ee65893 fct master updates /c
0f9d3bce remove dummyb file
60c06505 fct master Qa /b
bf9eadee Merge branch 'mrg_edge_2_master'
ee47f102 fct master test /a
e2794dad fct master test /a
93e3580b add part 11 + 12 /squash
a5c18192 add part 12
d3cd89fc add part 11
725407b0 Merge branch 'mrg_edge_2_master'
f0fff813 remove dummy file
aeaabe14 add part 8
68c80ae0 update edge
ad77a6e1 commit concflict
47c8cce2 update fct master-sq / add part 8 / rm part7 /squash
a9159e99 update edge
a78bca9c commit concflict
90b5fad4 init copy / part 9
76ea0fdf rm part 7,8
dfda460b add part 9
61531866 fct master-sq remove default message
0235fce7 add part 8
69a0e5e4 update fct master-sq / add part 8 / rm part7 /squash
1b6909db add part 8
a2dc95b0 update fct master-sq / add part 8 / rm part7 /squash
91c7f77c rm part 7
956f5511 fix typo
6cfd88e3 add part 8
7f020564 update fct master-sq
62e3f0ad rm part 5,6
18d7db1b add part 7
8ec77925 add part 6
b15662c8 fct master remove prompt
b1bae809 rm part 3-4
a8f6afe1 add part 5
6d01f8af add part 4
40029cba fct master / fix edge behavior
ce4f3db2 remove part 1-2
12cc79f2 add part 3
31ab3273 add part 1 & 2
fa7c34df add part 2
1af8b4fa add part 1
95390fca FEAT: remove dummy files + add alias /squash
c432578a update to 0.8.14
0243fb7a remove dummy files
856d4cbe Add alias cl-view
c62d5598 add alias cl-view
0729e532 FEAT: Add mdv (markdown viewer) AND cl-view /squash
3d1a6bf7 add fct cl-read
619ab54d add mdv / squashed
263c015d version 0.8.12 / new changelog fct
d86bb3ba update cl /d
ee553065 update cl /c
8212f0a0 update cl
d7c3cc05 reset changelog
49fc7238 add function cl /b
ff0038ce add dummy1
05ff9738 add function cl / changelog
fcc0efe4 docs
3b01cfae update to 0.8.11
bb6b2fb4 improve function master AND master-sq
90606f2f update master, master-sq, edge /a
471c4152 FEAT: Add file dummy 6 + 7 /squash
51919ad1 remove dummy file
f32bf6a5 FEAT: Add file dummy 6 + 7 /squash
87892941 add dummy7
3c13d075 add dummy6
1b21b458 FEAT: clean dummy files /squash
9f0f02a7 remove dummy 1 to 4
af73feee add dummy5
c6d8279b Merge branch 'master' into edge
bfae34a2 Squashed commit of the following:
4bc3b2c5 add dummy4
5085fd4f add dummy3
46d64148 add dummy2
03746869 add dummy1
6a41f91d docs
3ae02d29 add prt, still wip
bb219693 add new alias
9232548c minor fct info updates
eeee0626 Updated to version: 0.8.10
4ce54795 Updated to version: 0.8.10
74c0b47a add fct info
faa1bcc9 reorganise VAR in our fake Dockerfile
b21aa84c add status alias
5c1f91fc Updated to version: 0.8.9
3a5be951 Updated to version: 0.8.9
92b10a65 Merge branch 'master' into edge
df3ebf41 Update comment in App_release
f4bd14c4 added fct list
abbce23f Update comment in App_release
aa4d1b64 added fct list
e683f471 Updated to version: 0.8.8
14f572ab overall reorganisation to make it easier to read / squashed
09cf1665 minor reorg
37b5163a overall reorganisation to make it easier to read
4af6a157 copu updates
cdcaa131 rename App_Draft
354c6809 Updated to version: 0.8.7
91577151 Add help, version / Renamed master, edge, release
909ad8e1 Add fct version
6ff8fd0e Updated to version: 0.8.6
180a9af2 Improve comments and vars
191b3f02 Fix and rename add_dockerignore / squashed
c6b2f453 Update add_dockerfile template
a93e691d Updated to version: 0.8.5
d1c31644 Fix logic where the APP_NAME is not the same as the git repo name
04962508 introduce a new var in Dockerfile
131ee9e4 Updated to version: 0.8.4
d1299bb4 rename fct release_find_the_latest
95ae92fd Add find_latest_release (on github) / squashed
1338cd06 Updated to version: 0.8.3
2e9b65fd Add fct add_dockerignore, update changelog URL
5858e5ea Init dockerignore
a5d5ad88 Merge branch 'edge'
af05b492 fct tag / now can be executed on any branches
24ca29e6 Updated to version: 0.8-r2
11abc512 FIX release message
59640863 Updated to version: 0.8-r1
930f9e52 Improve error output if temp file is not existing
a0abfdd6 Improve functions ordering + README / squashed
50b755b5 Rename passgen / instead passfull
65eda6a6 Rename fct tag / instead of version
fbbb5fbe Improve the dynamic between updatecl and pushcl
3b61bd4e Improve README
707d8a67 Updated to version: 0.8-r0
8323af65 rename ci (imply status)
2cedf381 Update README / see what which output
df4b26c5 Add fct add_dockerfile
2c023a32 Ensure fct add_license add_changelog add_gitignore does not override existing file
c64623fc remove fct wip_bisect
f42ba952 Init fct add_license
e3464b5b Init fct addcl + addgiti
188de4b3 Add fct updatecl / squashed
14761b56 Improve LICENSE
6f14811c Improve README
3d72d30f Updated to version: 0.7-r4
89c4f36f Esthetic updates / squashed
63a7e9d0 Esthetic update to LICENSE
30dcb9fd Updated to version: 0.7-r3
1fb4af1c Improve README / squashed
8207e9f1 Updated to version: 0.7-r2
0d56c7a1 Improve sq fct
dd7b7be6 Minor updates to utility.sh
3542b6ed Updated to version: 0.7-r1
07bb2a92 Improve release messages
c8c48da1 Updated to version: 0.7-r0
43f8ddc9 Overall code improvements
d903c470 Updated to version: 0.6-r4
7c28fe3b Improve pullcl
d0d7bc59 Updated to version: 0.6-r3
e6e44b8f Add push_cl
e706fa5c update release
0d72d1fd Updated to version: 0.6-r2
4e100d5f 0.6-r2
44b179eb update rbmaster
8faf9d7f Improve examples
257f356d Added fct which_func
8799cef8 delete dummy
9229df00 improve release
da2ceccf debug release
c226e2bf dummy change
dc490cdb Add fct log
ac63cdf8 Add fct sq (means squash)
e7b5816b Improve README
4a2a0e51 Improve README
27d57316 Add logic to version + release fct
f9dce19b Updated to version: 0.6-r1
25308d15 0.6-r1
95a37e5e Improve rebase fcts
447dfe4d Improve rebase fct
a30d7d34 Improve rebase fct
0cb74872 Improve 2x rebase fct
9510d42c Improve 2x rebase fct
3093c04b remove Dummyfile
09387da1 Improve 2x rebase fct
f3141218 Add 2x rebase fct
0d0492ed add dummyfile
e56c2aa6 Updated to version: 0.6-r0
e6769704 0.6-r0
f29c7a1d Update fct version + release
311293b0 Updated to version: 0.5-r2
b4b99a5e 0.5-r2
d9601e4e Update fct check
916f839a Add details to changelog
a7c57482 Updated to version: 0.5-r1
e0b92e77 0.5-r1
59ec99fa Updated to version: 0.5-r4
14cf901f improve prompt
4391af22 Updated to version: 0.5-r2
f68d4420 Updated to version: 0.5-r1
ea050107 improve prompt
b424f7ce Updated to version: 0.5-r0
84f00eb8 0.5-r0 / changelog
b6d462a8 Improve README / Quick win section
9de0568a Improve README / Quick win section
67c925a1 Improve README / Quick win section
155474ff Improve README / Quick win section
eb52c90e Improve README / Quick win section
72552778 Improve README / Quick win section
9737dc71 Updated to version: 0.4-r2
e6bc8029 0.4-r2
297ca9e4 Improve comments
bd6d9cc7 Updated to version: 0.4-r1
6882b355 update 0.4-r1
82b0f207 Improve comments
2360c046 Updated to version: 0.4-r0
ffb55b07 update to 0.4-r0
b4bc4c4f Improve comment, and ajust sleep times
3f22d94a Updated to version: 0.3-r0
9adb2025 update to 0.3-r0
77c17ea2 update release fct
3156b72c Updated to version: 0.2-r4
d84b90d0 Add a URL once the release is done
f9b238d6 Updated to version: 0.2-r3
2f6ed30e Fix var
adc9c1a8 Updated to version: 0.2-r2
ccaa34c7 Fix vars
005c924c Updated to version: 0.2-r1
751a0db0 release 0.2-r0
41c32782 Init fake Dockerfile
815a4540 remove file see Dockerfile
c03785b9 variable are define only in the Dockerfile
e91de728 Updated to version: 0.2-r0
00694c7a add fct gitignore /b
e8ce23f5 add fct gitignore
72a94838 update source
f8bd920c rename to set_vars.sh
4b6b70a2 remove git attributes
7b307056 Add release function
8e19849b Updated to version: 0.1-r3
c86f528e fix token var /b
fd131038 Updated to version: 0.1-r2
020f36b2 fix token var
47f3a98e Updated to version: 0.1-r1
bb00405d Init changelog
88293831 Init a fake Dockerfile
e4f8f51f Major update to fct release
47992751 Init core template
ff628fcb fixed typo in comment
4ca01e5c Disable trimTrailingWhitespace in VS Code workspace settings
aec4857f Update and simplify .gitignore
2043a580 Add additional usage guidance to README.md
bb12ced9 Remove unnecessary Vim modeline from .gitattributes
f88144ba Pedantic formatting tweaks to .git files
7e2c9ae5 Add .gitattributes
602922af Add VS Code extension recommendations
a71dae5e Add .markdownlint.json
a3673494 Add .editorconfig
1d8c17ab Add basic locking support for ensuring only a single instance runs
2d9a1d5d Remove year that never gets updated from copyright
315d34a5 Explicitly document function outputs for every function
03b61a8f Tweak parameter validation to be a little more forgiving
ca2dea46 Fix wrong BASH_SOURCE array index when sourcing in the template
d2a6c3e0 Fix wrong indentation for esac statement
7740ba04 Remove some unnecessary quoting
c98a72f4 Fix edge case where terminating sudo can result in undefined variable
14d73e7b Redirect tput stderr output to /dev/null
71f3d311 Add new parameter to optimise for running under Cron
570204fe Pedantic output tweak
60c6926e Minor README.md updates
9283f7aa Add parameter to pretty_print() to not append a new line
a3b3057d Add new build_path() function for building PATH(-like) variables
7b56bf37 Remove unneeded shellcheck hints
11832946 Improvements to handling of text attribute variables
12d49feb Fix unbounded variable when testing if no_colour is set (embarrassing!)
c8471e10 Minor updates to README.md
e6e8c7af Only initialise the colour variables if we actually want colour
78763d8e Always reset text attributes at conclusion of pretty_print()
b17028b2 Reset text attributes after each tput invocation in script_init()
e6b104a7 Monospace font for bash in motivation section of README.md
cd678cc5 Explain the rationale of some controversial decisions
c093108a Mask tput commands with true as some may fail on various terminals
b7ca14ec Use tput for terminal capabilities instead of hardcoding ANSI codes
75de97ef Make build.sh work with BSD sed as well (inc. OS X)
6db7f447 Replace all usage of echo with printf
7fb2cc21 Fix bug in handling of optional arg to check_binary()
74c57b24 Use cat w/ heredoc for script_usage() for cleaner multiline output
f9bc5e5c Update README.md with details on the various files
d83fb1ad Formally license under the MIT license terms
33e0679c Major update to make the usage of the template a bit more flexible
50b91584 Set sudo's -H parameter by default and block other parameters
0ffe1061 Fix bug in pretty_print() parameter validation
0ec7d25a Fix some ARGS documentation to be consistent with rest of the script
3dd1b0ff Add run_as_root() function to run a given command as root
cacb7675 Add check_superuser() function to check for superuser privileges
8d437fc5 Add check_binary() function to check if a binary exists
18ec7d0e Initial Bash scripting template
