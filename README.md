&nbsp;

<p align="center">
  <a href="https://github.com/firepress-org/bashlava">
    <img src="https://user-images.githubusercontent.com/6694151/74113494-746ee100-4b72-11ea-9601-bd7b1d786b41.jpg" width="1024px" alt="FirePress" />
  </a>
</p>

&nbsp;

> BashLaVa makes your bash scripts a bunch of pieces of cakes.

# BashLava

BashLaVa is a utility-first bash framework. The idea is to abstract your git workflow to minimize the time to do some repetitive actions.

**Update May 2022**: There are so many new features, I must re-write the whole README.

## Features

- A Super fast git flow
- Sane default, see `.bl_env.sh`
- Custom configuration to quickly use bashlava accross your project
- manage your own bashscript scripts under /private
- crypt secrets

Below from the `bashlava.sh h`

```
  git flow

  •  e  ....... | create a branch edge from main ........ | standalone
  •  c  ....... | commit ................................ | usage: c "This feature rocks"
  •  sq  ...... | squash commits ........................ | usage: sq 3 "Add: feat xyz, issue 123"
  •  pr  ...... | create pull request  .................. | standalone
  •  ci  ...... | show ci status on GitHub Actions ...... | standalone
  •  mrg  ..... | merge to mainbranch ................... | standalone
  •  m  ....... | checkout to main_branch  .............. | standalone
  •  v  ....... | version code .......................... | standalone or usage: v 1.4.2
  •  t  ....... | tag  .................................. | standalone
  •  r  ....... | release  and open GUI on GitHub ....... | standalone
  •  d  ....... | dummy  commits ........................ | standalone
```

## cli that are abstracted

- git
- gh
- docker
- git-crypt

## Getting Started

## License

- This git repo is under the **GNU V3** license.
