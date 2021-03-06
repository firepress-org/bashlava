This **CHANGELOG** should make it easy for you to see what is happening with this project. Each release automatically generates/formats/updates this changeling thanks to [BashLaVa](https://github.com/firepress-org/bashlava). It uses the same ยซ Agile Deployment Lifecycle ยป we use at FirePress. See our [blog post](https://firepress.org/en/how-do-we-update-hundreds-of-ghosts-websites-on-docker-swarm/) about it. It follows the [keep a changelog](https://keepachangelog.com/en/1.0.0/) spirit and adheres to [semantic versioning](https://semver.org/spec/v2.0.0.html).

Status template:
| โก๏ธ Updates | ๐ Added | โ ๏ธ Changed |
๐ Fixed | ๐ Removed | ๐ Security |
๐ Oops | ๐จ Design | ๐ happy | ๐ blessed

# Releases

## 0.14.6 (2020-10-19)
### โก๏ธ Updates
- [559dd58](https://github.com/firepress-org/bashlava/commit/559dd58) typo in CHANGELOG

### ๐ Compare
- ... with previous release: [0.14.5 <> 0.14.6](https://github.com/firepress-org/bashlava/compare/0.14.5...0.14.6)

## 0.14.5 (2020-10-19)
### โก๏ธ Updates
- [8ded67d](https://github.com/firepress-org/bashlava/commit/8ded67d) Update bashlava to version 0.14.5 /Dockerfile
- [45a593a](https://github.com/firepress-org/bashlava/commit/45a593a) rollback deletion on the changelog

### ๐ Compare
- ... with previous release: [0.14.4 <> 0.14.5](https://github.com/firepress-org/bashlava/compare/0.14.4...0.14.5)

## 0.14.4 (2020-10-19)
### โก๏ธ Updates
- [f18f0b3](https://github.com/firepress-org/bashlava/commit/f18f0b3) Update bashlava to version 0.14.4 /Dockerfile
- [211c577](https://github.com/firepress-org/bashlava/commit/211c577) update release_message2 message

### ๐ Compare
- ... with previous release: [0.14.3 <> 0.14.4](https://github.com/firepress-org/bashlava/compare/0.14.4...0.14.4)

## 0.14.3 (2020-10-09)
### โก๏ธ Updates
- [9412729](https://github.com/firepress-org/bashlava/commit/9412729) Update bashlava to version 0.14.3 /Dockerfile
- [dda0ef3](https://github.com/firepress-org/bashlava/commit/dda0ef3) bypass title-accronyms
- [cda2913](https://github.com/firepress-org/bashlava/commit/cda2913) update changelog
- [233ad6](https://github.com/firepress-org/bashlava/commit/233ad6) add bashlava_help.md to gitignore 
- [a5c323d](https://github.com/firepress-org/bashlava/commit/a5c323d) update our backlog
- [f8189fa](https://github.com/firepress-org/bashlava/commit/f8189fa) rm fct title-accronyms
- [8f4733d](https://github.com/firepress-org/bashlava/commit/8f4733d) Note to backlog

### ๐ Compare
- ... with previous release: [0.14.2 <> 0.14.3](https://github.com/firepress-org/bashlava/compare/0.14.2...0.14.3)

## 0.14.2 (2020-03-01)
### โก๏ธ Updates
- [6be7715](https://github.com/firepress-org/bashlava/commit/6be7715) Update bashlava to version 0.14.2 /CHANGELOG

### ๐ Compare
- ... with previous release: [0.14.1 <> 0.14.2](https://github.com/firepress-org/bashlava/compare/0.14.1...0.14.2)

## 0.14.1 (2020-02-27)
### โก๏ธ Updates
- [b9e33a0](https://github.com/firepress-org/bashlava/commit/b9e33a0) Update bashlava to version 0.14.1 /Dockerfile
- [e823152](https://github.com/firepress-org/bashlava/commit/e823152) Minor update to changelog template

### ๐ Compare
- ... with previous release: [0.14.0 <> 0.14.1](https://github.com/firepress-org/bashlava/compare/0.14.0...0.14.1)

## 0.14.0 (2020-02-27)
### โก๏ธ Updates
- [4a99438](https://github.com/firepress-org/bashlava/commit/4a99438) Update bashlava to version 0.14.0 /Dockerfile
- [72ff8f8](https://github.com/firepress-org/bashlava/commit/72ff8f8) Update changelog template

### ๐ Compare
- ... with previous release: [0.13.0 <> 0.14.0](https://github.com/firepress-org/bashlava/compare/0.13.0...0.14.0)

## 0.13.0 (2020-02-27)
### โก๏ธ Updates

Move back three flags from Dockerfile into bashlava.sh. Why? Because it makes bashlava impossible to use without an associated Dockerfile. This was a bad idea.

- [740db4d](https://github.com/firepress-org/bashlava/commit/740db4d) Update bashlava to version 0.13.0 /Dockerfile
- [f141541](https://github.com/firepress-org/bashlava/commit/f141541) draft changelog
- [4b523e5](https://github.com/firepress-org/bashlava/commit/4b523e5) Update Dockerfile template
- [709445a](https://github.com/firepress-org/bashlava/commit/709445a) Improve comments for hardcoded default values
- [5266da3](https://github.com/firepress-org/bashlava/commit/5266da3) Remove checks on vars
- [0d06fcd](https://github.com/firepress-org/bashlava/commit/0d06fcd) move back three flags from Dockerfile into bashlava
- [24d5c24](https://github.com/firepress-org/bashlava/commit/24d5c24) move back three flags into bashlava
- [76f9a0d](https://github.com/firepress-org/bashlava/commit/76f9a0d) remove un-needed โinit_dockerfile_ignoreโ
- [ec9b905](https://github.com/firepress-org/bashlava/commit/ec9b905) remove alias passfull

### ๐ Compare
- ... with previous release: [0.12.0 <> 0.13.0](https://github.com/firepress-org/bashlava/compare/0.12.0...0.13.0)

## 0.12.0 (2020-02-27)

### โก๏ธ Updates

๐ Removed : This update was override by v0.13.0

- [c4217d0](https://github.com/firepress-org/bashlava/commit/c4217d0) ADD: new flags in Dockerfile for better control on configs.

### ๐ Compare
- ... with previous release: [0.11.0 <> 0.12.0](https://github.com/firepress-org/bashlava/compare/0.11.0...0.12.0)

## 0.11.0 (2020-02-26)
### โก๏ธ Updates
- [4177e31](https://github.com/firepress-org/bashlava/commit/4177e31) Update bashlava to version 0.11.0 /Dockerfile
- [5163200](https://github.com/firepress-org/bashlava/commit/5163200) ADD MAJOR FEAT: In Dockerfile we have release flag

### ๐ Compare
- ... with previous release: [0.10.7 <> 0.11.0](https://github.com/firepress-org/bashlava/compare/0.10.7...0.11.0)

## 0.10.7 (2020-02-26)
### โก๏ธ Updates
- [1f6fe9d](https://github.com/firepress-org/bashlava/commit/1f6fe9d) Update bashlava to version 0.10.7 /Dockerfile
- [1355ec4](https://github.com/firepress-org/bashlava/commit/1355ec4) FIX list-functions
- [2d035e1](https://github.com/firepress-org/bashlava/commit/2d035e1) Add notes in BACKLOG
- [e962379](https://github.com/firepress-org/bashlava/commit/e962379) fix typo in comments
- [0d5de09](https://github.com/firepress-org/bashlava/commit/0d5de09) Update passgen
- [14e6b56](https://github.com/firepress-org/bashlava/commit/14e6b56) UPDATE copy on README
- [7f40961](https://github.com/firepress-org/bashlava/commit/7f40961) Add note to backlog + new Add-on examples
- [255dfdb](https://github.com/firepress-org/bashlava/commit/255dfdb) Improve VAR handling
- [27058f0](https://github.com/firepress-org/bashlava/commit/27058f0) Improve CHANGELOG copy

### ๐ Compare
- ... with previous release: [0.10.6 <> 0.10.7](https://github.com/firepress-org/bashlava/compare/0.10.6...0.10.7)

## 0.10.6 (2020-02-18)
### โก๏ธ Updates
- Better handling of our paths: very useful when you want to rename `bashlava.sh` See an example over https://github.com/pascalandy/mine-a-block-using-sha256. Also it's easier to manage in the case your path is not over `/usr/local/bin/`. 
- Heavily tested `wip-sync-origin-from-upstream`. Still tip as it need better documentation.
- `test` it now call a banner function from the `add-on`. It help to ensure it is well configured.
- Version & tag will now accept something like 3.5.1-r4 (think release #4)

### commits
- [d1990cf](https://github.com/firepress-org/bashlava/commit/d1990cf) Update bashlava to version 0.10.6 /Dockerfile.
- [35c5f30](https://github.com/firepress-org/bashlava/commit/35c5f30) UPDATE: better handling of our paths + REMOVE unless logic App_Reset_Custom_path & App_Load_Add_on. 
- [09cae43](https://github.com/firepress-org/bashlava/commit/09cae43) UPDATE: wip-sync-origin-from-upstream + version allow to have -r1.

### ๐ Compare
- ... with previous release: [0.10.5 <> 0.10.6](https://github.com/firepress-org/bashlava/compare/0.10.5...0.10.6)

## 0.10.5 (2020-02-17)
### โก๏ธ Updates
- [230fbbf](https://github.com/firepress-org/bashlava/commit/230fbbf) UPDATE `release` where `edge` was sometime bypassed

### ๐ Compare
- ... with previous release: [0.10.4 <> 0.10.5](https://github.com/firepress-org/bashlava/compare/0.10.4...0.10.5)

## 0.10.4 (2020-02-17)
### โก๏ธ Updates
- [077c45b](https://github.com/firepress-org/bashlava/commit/077c45b) update `master-nosq`
- [2389ef2](https://github.com/firepress-org/bashlava/commit/2389ef2) ADD: Add compare message in CHANGELOG + fix typo + add log to `version`
- [872d22a](https://github.com/firepress-org/bashlava/commit/872d22a) FIX: removed some rules that were in conflict when using `deploy`
- [786ffe9](https://github.com/firepress-org/bashlava/commit/786ffe9) UPDATE: make `bashlava` more idempotent. It will require a lot of work to make it fully idempotent.
- [c19b79e](https://github.com/firepress-org/bashlava/commit/c19b79e) CHANGE fct `shortner` is now `gitio`
- [7ca586b](https://github.com/firepress-org/bashlava/commit/7ca586b) UDPATE: various rules to minimize errors
- [bf840cd](https://github.com/firepress-org/bashlava/commit/bf840cd) UPDATE: rename few fct + ADD rule to check if git repo is valid
- [59c9ec0](https://github.com/firepress-org/bashlava/commit/59c9ec0) ADD `init_dockerfile_ignore`
- [0e96cf0](https://github.com/firepress-org/bashlava/commit/0e96cf0) ADD: `init_readme` + regroup `App_` rules

### ๐ Compare
 ... with previous release: [0.10.3 <> 0.10.4](https://github.com/firepress-org/bashlava/compare/0.10.3...0.10.4)

## 0.10.3 (2020-02-17)
### โก๏ธ Updates
- [fc4ca34](https://github.com/firepress-org/bashlava/commit/fc4ca34) FIX: flags in `master` + better comments linting + README updates

## 0.10.2 (2020-02-16)
### โ ๏ธ Changed
We can `deploy` now without `m`. Now, we can use `deploy` this way:

- `bashlava.sh d- 3.5.2`
- `bashlava.sh d 3.5.2 "UPDATE chap 32 + FIX typo"`

We can understand that the second option will squash our commits from edge into master. See help.

It's the highest level of abstraction we can think of for the whole release cycle.

### โก๏ธ Updates
- [6e242a5](https://github.com/firepress-org/bashlava/commit/6e242a5) UPDATE: bashlava to version 0.10.2 /Dockerfile
- [68992c5](https://github.com/firepress-org/bashlava/commit/68992c5) MAJOR PDATE: `deploy` now without `m` + ADD: App_Is_Version_a_Valid_Number
- [58bdbb7](https://github.com/firepress-org/bashlava/commit/58bdbb7) UPDATE: Improve help-installation
- [d7d782f](https://github.com/firepress-org/bashlava/commit/d7d782f) REMOVE: input_4 fct as `deploy` is now simpler
- [c49fc36](https://github.com/firepress-org/bashlava/commit/
- [929d1b4](https://github.com/firepress-org/bashlava/commit/929d1b4) ADD: wip-sync-origin-from-upstream + reorgonize fct grouping
- [d491fed](https://github.com/firepress-org/bashlava/commit/d491fed) UPDATE: fct edge: improve message
- [642b007](https://github.com/firepress-org/bashlava/commit/642b007) IMPROVE changelog template

## 0.10.1 (2020-02-15)
### ๐ New feat.
alias `m-m`: Useful when we want to commit update on master without publishing a release and without updating the changelog.

- [a342bfd](https://github.com/firepress-org/bashlava/commit/a342bfd) ADD: fct master-merge (alias m-m)

### ๐ Removed
To make it simpler, we can't specify the version anymore for these functions:

- `m "FEAT: some message here`
- `m-`
- `r`

We **only** specify version for `v 3.5.1`

### โก๏ธ Updates
- [587fadc](https://github.com/firepress-org/bashlava/commit/587fadc) UPDATE: in fct master, removed un-needed step โgit push origin masterโ
- [a342bfd](https://github.com/firepress-org/bashlava/commit/a342bfd) UPDATE: fct release don't need a version anymore
- [43f3008](https://github.com/firepress-org/bashlava/commit/43f3008) UPDATE: bashlava to version 0.10.1 /Dockerfile
- [c28b3ed](https://github.com/firepress-org/bashlava/commit/c28b3ed) REMOVE: un-needed rule in App_Changelog_Update
- [fbc5257](https://github.com/firepress-org/bashlava/commit/fbc5257) UPDATE: master-merge + alias โm-mโ
- [3745ba2](https://github.com/firepress-org/bashlava/commit/3745ba2) REMOVE App_UpdateDockerfileVersion logic
- [6441cda](https://github.com/firepress-org/bashlava/commit/6441cda) UPDATE: improve alias
- [ec39e6f](https://github.com/firepress-org/bashlava/commit/ec39e6f) IMPROVE: syntax remove space
- [24bfa40](https://github.com/firepress-org/bashlava/commit/24bfa40) UPDATE: Changelog formatting

## 0.10.0 (2020-02-15)
### ๐ New feat.

We can now do our releases in only one command ๐. 
Instead of doing `v`, `m`, `r`, we can accomplish the same result using `d`. See help.

- [cf6652d](https://github.com/firepress-org/bashlava/commit/cf6652d) ADD: new fct deploy (d)

## 0.9.22 (2020-02-15)
### ๐ New feat.
- [adc3e34](https://github.com/firepress-org/bashlava/commit/adc3e34) ADD: new fct App_Is_license + the logic to few fct parent

### โก๏ธ Updates
- [8006f09](https://github.com/firepress-org/bashlava/commit/8006f09) UPDATE: Changelog template
- [6087e35](https://github.com/firepress-org/bashlava/commit/6087e35) UPDATE README, help section

## 0.9.21 (2020-02-15)
### ๐ New feat.
- [5eaf739](https://github.com/firepress-org/bashlava/commit/5eaf739) ADD date in CHANGELOG when updating it

### โก๏ธ Updates
- [967cb0c](https://github.com/firepress-org/bashlava/commit/967cb0c) CHANGELOG formatting updates

## 0.9.20
### ๐ New feat.
- [07c469f](https://github.com/firepress-org/bashlava/commit/07c469f) ADD: new fct shorturl (git.io/xyz)

## 0.9.19
### โก๏ธ Updates
- [c5ded68](https://github.com/firepress-org/bashlava/commit/c5ded68) UPDATE readme and video tutorials

## 0.9.18
### โก๏ธ Updates
- [f7de151](https://github.com/firepress-org/bashlava/commit/f7de151) MINOR: random optimizations, no news features

### ๐ New feat.
- [bccb83d](https://github.com/firepress-org/bashlava/commit/bccb83d) Add custom template

## 0.9.17
### โก๏ธ Updates
- [bbbe344](https://github.com/firepress-org/bashlava/commit/bbbe344) Update README

## 0.9.16
### โก๏ธ Updates
- [9146442](https://github.com/firepress-org/bashlava/commit/9146442) Add intro video in README

## 0.9.16
### โก๏ธ Updates
- [8b98096](https://github.com/firepress-org/bashlava/commit/8b98096) UPDATE: README

## 0.9.15
### ๐ New feat.
- [e366624](https://github.com/firepress-org/bashlava/commit/e366624) ADD section: help-installation

### โก๏ธ Updates
- [31693fa](https://github.com/firepress-org/bashlava/commit/31693fa) RENAME bashLaVa
- [8415891](https://github.com/firepress-org/bashlava/commit/8415891) UPDATE: backlog, many things were shipped
- [c34984f](https://github.com/firepress-org/bashlava/commit/c34984f) FIX: App_RemoveTmpFiles system prompt when rm un-existing file
- [b14c6fb](https://github.com/firepress-org/bashlava/commit/b14c6fb) FEAT: Add warning if not running on Mac.

## 0.9.14
### ๐ New feat.
- [5e5fe8d](https://github.com/firepress-org/bashlava/commit/5e5fe8d) ADD: App_Configure_Custom_Path , UPDATE: fct test, RENAME some VARS

### โก๏ธ Updates
- [38b70ba](https://github.com/firepress-org/bashlava/commit/38b70ba) Update bashlava to version 0.9.14
- [7481bd3](https://github.com/firepress-org/bashlava/commit/7481bd3) UDPATE: templates
- [cd89510](https://github.com/firepress-org/bashlava/commit/cd89510) Update LICENSE copy
- [6943fa5](https://github.com/firepress-org/bashlava/commit/6943fa5) UPDATE: Improve comments and copy
- [eaf4e42](https://github.com/firepress-org/bashlava/commit/eaf4e42) UPDATE: backlog
- [eeb557d](https://github.com/firepress-org/bashlava/commit/eeb557d) FIX alias
- [c35bb79](https://github.com/firepress-org/bashlava/commit/c35bb79) UPDATE: list display, FIX: release-read , ADD: mdv for any .md files
- [b83101a](https://github.com/firepress-org/bashlava/commit/b83101a) Fix typo
- [c3e0d1f](https://github.com/firepress-org/bashlava/commit/c3e0d1f) UPDATE: help have a cleaner copy
- [f124c73](https://github.com/firepress-org/bashlava/commit/f124c73) MOVE: cmd into utilities
- [2423f76](https://github.com/firepress-org/bashlava/commit/2423f76) UPDATE: help have a cleaner copy
- [8ed85fb](https://github.com/firepress-org/bashlava/commit/8ed85fb) MOVE: cmd into utilities
- [5eda5dd](https://github.com/firepress-org/bashlava/commit/5eda5dd) update: help copy
- [3698a2a](https://github.com/firepress-org/bashlava/commit/3698a2a) UPDATE: major fct renaming + improve /help
- [8b7fe7a](https://github.com/firepress-org/bashlava/commit/8b7fe7a) backlog updates
- [5f4605a](https://github.com/firepress-org/bashlava/commit/5f4605a) UPDATE: /title-core-fct | Needed by /list
- [0090a02](https://github.com/firepress-org/bashlava/commit/0090a02) rename dk dk-view cl-view / move docker_img_figlet into the global variables
- [fd9afb2](https://github.com/firepress-org/bashlava/commit/fd9afb2) update BACKLOG
- [313e23b](https://github.com/firepress-org/bashlava/commit/313e23b) /help rename which to list
- [b5f5947](https://github.com/firepress-org/bashlava/commit/b5f5947) major alias revamp

## 0.9.13
### ๐ New feat.
- [2aeb034](https://github.com/firepress-org/bashlava/commit/2aeb034) init BACKLOG
- [0e4dc42](https://github.com/firepress-org/bashlava/commit/0e4dc42) ADD --help to alias

### โก๏ธ Updates
- [628ea06](https://github.com/firepress-org/bashlava/commit/628ea06) Update bashlava to version 0.9.13
- [661808d](https://github.com/firepress-org/bashlava/commit/661808d) better copy for /help
- [a21fd90](https://github.com/firepress-org/bashlava/commit/a21fd90) add rule /App_Is_dockerfile in /dk

## 0.9.12
### โก๏ธ Updates
- [554dce4](https://github.com/firepress-org/bashlava/commit/554dce4) Update bashlava to version 0.9.12
- [066c4be](https://github.com/firepress-org/bashlava/commit/066c4be) Add /log to /sq
- [d1afd4c](https://github.com/firepress-org/bashlava/commit/d1afd4c) FIX: re-write many > /dev/null 2>&1

## 0.9.11
### ๐ New feat.
- [7b3bb76](https://github.com/firepress-org/bashlava/commit/7b3bb76) Add fct /tag. This helps when we pushing app version.

### โก๏ธ Updates
- [f3cbf55](https://github.com/firepress-org/bashlava/commit/f3cbf55) Improve: README
- [47c84c0](https://github.com/firepress-org/bashlava/commit/47c84c0) Improve: commit messages
- [a872462](https://github.com/firepress-org/bashlava/commit/a872462) Improve App_Changelog_Update tmp file deletion & comments

## 0.9.10
### โก๏ธ Updates
- [c00720c](https://github.com/firepress-org/bashlava/commit/c00720c) Improve commit message for /dk, /master, /release, /squash

## 0.9.9
### โก๏ธ Updates
- [ac350c3](https://github.com/firepress-org/bashlava/commit/ac350c3) Improve release message / better explanation of what bashlava does /squashed

## 0.9.8
### โก๏ธ Updates
- [3edfb00](https://github.com/firepress-org/bashlava/commit/3edfb00) Improve Changelog and fix typo / Add /log into /master /squashed

## 0.9.7
### ๐ New feat.
- [e91a2b4](https://github.com/firepress-org/bashlava/commit/e91a2b4) Adding 3 examples for custom scripts

### โก๏ธ Updates
- [878e2f2](https://github.com/firepress-org/bashlava/commit/878e2f2) Make the local variable more obvious
- [878e2f2](https://github.com/firepress-org/bashlava/commit/878e2f2) Cleaner way to manage custom_scripts
- [878e2f2](https://github.com/firepress-org/bashlava/commit/878e2f2) Better error handling

- [beaa2e0](https://github.com/firepress-org/bashlava/commit/beaa2e0) Improve fct CI / FIX custom_urls.sh
- [36685ea](https://github.com/firepress-org/bashlava/commit/36685ea) Improve template for Dockferfile
- [71602ed](https://github.com/firepress-org/bashlava/commit/71602ed) Improve README

## 0.9.6
### ๐ New feat.
As you can see here, our commit hash are clickable!
- [22ead68](https://github.com/firepress-org/bashlava/commit/22ead68) Changelog_Update / create URLs from git commits

### โก๏ธ Updates
- [0d2bec1](https://github.com/firepress-org/bashlava/commit/0d2bec1) App_changelog_update, Improve create URLs from git commits & remove vars during QA
- [2d79b65](https://github.com/firepress-org/bashlava/commit/2d79b65) App_changelog_update, Improve create URLs from git commits, RENAME out-m & out-e
- [6ee27a2](https://github.com/firepress-org/bashlava/commit/6ee27a2) new alias
- [b27be25](https://github.com/firepress-org/bashlava/commit/b27be25) improved fct log
- [a14ccf7](https://github.com/firepress-org/bashlava/commit/a14ccf7) init alias
- [909c531](https://github.com/firepress-org/bashlava/commit/909c531) improve prompt messages
- [4862c97](https://github.com/firepress-org/bashlava/commit/4862c97) add alias, improve prompt messages
- [1b03630](https://github.com/firepress-org/bashlava/commit/1b03630) FIX logic on /release, improve comments
- [bd1e1c7](https://github.com/firepress-org/bashlava/commit/bd1e1c7) The abstraction is real. /cl is now under /release
- [6769998](https://github.com/firepress-org/bashlava/commit/6769998) dk: add comment
- [5896031](https://github.com/firepress-org/bashlava/commit/5896031) cl-push is now cl thanks to App_Changelog_Update
- [09f32af](https://github.com/firepress-org/bashlava/commit/09f32af) fct dk: add logic to show version when no attributs are passed
- [e8e6861](https://github.com/firepress-org/bashlava/commit/e8e6861) rename dk-version to dk
- [1dfe01a](https://github.com/firepress-org/bashlava/commit/1dfe01a) update Dockerfile template
- [299082d](https://github.com/firepress-org/bashlava/commit/299082d) improve alias
- [fcb4075](https://github.com/firepress-org/bashlava/commit/fcb4075) fct cl FIX var, minor optimizations

## 0.9.5
### โก๏ธ Updates
- 45345aa FIX if logic

## 0.9.4
### โก๏ธ Updates
- 12bbab0 Fix typo /squash

## 0.9.3
### โก๏ธ Updates
- c6570d8 FIX tag when release AND add checkpoints when updating Dockerfile version /squash

## 0.9.2
### โก๏ธ Updates
- ffbfbfa Add logic to see actual version when not providing a version in fct master
- 1addff9 help-workflow /major copy update
- 1c28961 fix lost && sign, rename cl-read to cl-view, FIX version within the Dockerfile
- 567788a add alias: dk-show, cl-show
- fb13a87 init cl-push, Update Dockerfile version
- 932756a FIX missing title in CHANGELOG.md

## 0.9.1
### โก๏ธ Updates
- FIX img url in README
- c2f8e617e29df22cdcd7dbcc00dcae347f767a03 add checkpoint to fct release

## 0.9.0
This is a important release as it's introducting add-ons. This will be important to scale to project and leave the core elements at there place.

### ๐ New feat.
- 610dbf0 init add-on/utilities.sh

### โก๏ธ Updates
- 16f98cc init fct App_Is_commit_unpushed, merge App_Tag into fct release, Add missing rules, rename dk_update to dk_version
- 20954d5 ๐ update copy for workflow
- e8c86a0 init alias version
- 5d99150 add alias r
- c37344e Init App_is_env_local_path, Init App_Is_hub_installed, move functions by groups
- d01c4e4 removed merge App_release into release
- 937dc03 add checkpoints in fct master
- bc8c187 add alias appversion
- 1bb36a2 rename edge-init to edge
- 5e1f5f8 init App_Is_changelog
- ed6ecae init App_Is_master, App_Is_Dockerfile
- c82fe1c ๐ refactor fct release
- f7a0551 Optimize Dockerfile template
- 8841eac update README, refactor fct cl, alias c /squash
- 8a0994c various code optimizations
- 610dbf0 init add-on/utilities.sh
- 43b7a90 update add-on/help
- 4b80939 move few fct under add-on/docker
- 2f7d67d update App_Stop

## 0.8.14
### โก๏ธ Updates
- 0243fb7 remove dummy files
- 856d4cb Add alias cl-view

## 0.8.13
### โก๏ธ Updates
- 3d1a6bf add fct cl-read
- 619ab54 add mdv / squashed

## 0.8.12
### โก๏ธ Updates
- d86bb3b changelog update
- 05ff973 add function cl / changelog

## 0.8.11
### โก๏ธ Updates
- bb6b2fb4 improve function master AND master-sq
- 51919ad1 remove dummy files
- c6d8279b Merge branch 'master' into edge
- 3ae02d29 add prt, still wip
- bb219693 add new alias
- 9232548c minor fct info updates

## 0.8.10
### โก๏ธ Updates
- 4ce5479 Updated to version: 0.8.10
- 74c0b47 add fct info
- faa1bcc reorganise VAR in our fake Dockerfile
- b21aa84 add status alias

## 0.8.9
### โก๏ธ Updates
- 3a5be95 Updated to version: 0.8.9
- 92b10a6 Merge branch 'master' into edge
- df3ebf4 Update comment in App_release
- f4bd14c added fct list
- abbce23 Update comment in App_release
- aa4d1b6 added fct list

## 0.8.8
### โก๏ธ Updates
- overall reorganisation to make it easier to read

## 0.8.7
### โก๏ธ Updates
9157715 Add help, version / Renamed master, edge, release
909ad8e Add fct version

## 0.8.6
### โก๏ธ Updates
- 180a9af Improve comments and vars
- 191b3f0 Fix and rename add_dockerignore / squashed
- c6b2f45 Update add_dockerfile template

## 0.8.5
### โก๏ธ Updates
- d1c3164 Fix logic where the APP_NAME is not the same as the git repo name
- 0496250 introduce a new var in Dockerfile

## 0.8.4
### โก๏ธ Updates
- d1299bb rename fct release_find_the_latest
- 95ae92f Add find_latest_release / squashed

## 0.8.3
### โก๏ธ Updates
- 2e9b65f Add fct add_dockerignore, update changelog URL
- 5858e5e Init dockerignore
- af05b49 fct tag / now can be executed on any branches + update CHANGELOG url

## 0.8-r2
### โก๏ธ Updates
- 11abc51 FIX release message

## 0.8-r1
### โก๏ธ Updates
- a0abfdd Improve functions ordering + README / squashed
- 50b755b Rename passgen / instead passfull
- 65eda6a Rename fct tag / instead of version
- fbbb5fb Improve the dynamic between updatecl and pushcl
- 3b61bd4 Improve README

## 0.7-r4
### โก๏ธ Updates
- 89c4f36f Esthetic updates / squashed

## 0.7-r3
### โก๏ธ Updates
- 1fb4af1c Improve README / squashed

## 0.7-r2
### โก๏ธ Updates
- 0d56c7a1 Improve sq fct
- dd7b7be6 Minor updates to utility.sh

## 0.7-r1
### โก๏ธ Updates
- 07bb2a92 Improve release messages

## 0.7-r0
### โก๏ธ Updates
43f8ddc9 Overall code improvements

## 0.6-r4
### โก๏ธ Updates
- 7c28fe3b Improve pullcl

## 0.6-r3
### โก๏ธ Updates
- e6e44b8f ๐ New feat. Add push_cl

## 0.6-r2
### โก๏ธ Updates
- 44b179eb update rbmaster
- 8faf9d7f Improve README examples
- 257f356d ๐ New feat. Added fct which_func
- 9229df00 improve release
- dc490cdb ๐ New feat. Add fct log
- ac63cdf8 ๐ New feat. Add fct sq (means squash)
- e7b5816b Improve README
- 27d57316 ๐ New feat. Add logic to version + release fct

## 0.6-r1
### ๐ Added (new feat.)
- 2x rebase functions

## 0.6-r0
### โก๏ธ Updates
- Update fct **version** and **release**.
- **release** fct is now based on https://github.com/github/hub

## 0.5-r2
### โก๏ธ Updates
- Update fct check

## 0.5-r1
### โก๏ธ Updates
- Improve Prompt before doing a git push
- Testing `utility.sh` / git push, tag, version, release, etc. That's why there are many release today :-p

## 0.5-r0
### โก๏ธ Updates
- Improve README

## 0.4-r2
### โก๏ธ Updates
- Improve comments

## 0.4-r1
### โก๏ธ Updates
- improve comments

## 0.4-r0
### ๐ Added (new feat.)
- update release fct

## 0.3-r0
### ๐ Added (new feat.)
- Intensely developed. Ignore this version and any previous versions.
