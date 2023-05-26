```
              _          _
  __ _  ___  | |__   ___| |_ __
 / _` |/ __| | '_ \ / _ \ | '_ \
| (_| | (__  | | | |  __/ | |_) |
 \__, |\___| |_| |_|\___|_| .__/
 |___/                    |_|
```

# Install git-crypt on Mac

I use Mac OS (M1) 12.3.1.

```
brew install git-crypt gnupg
git-crypt version

>>
git-crypt 0.7.0
```

Also install the GUI - https://gpgtools.org/

gpg can have mixed up installation configs:
https://stackoverflow.com/questions/39494631/gpg-failed-to-sign-the-data-fatal-failed-to-write-commit-object-git-2-10-0

# Method #1

One commun symetric key for everybody. (Less secure over time.)

## Set up the repository to use git-crypt

Let's create a Symetric key (basic set up)
Let's export the key

```
git-crypt init

git-crypt export-key ~/Documents/.../git-crypt-key
```

## Set up rules

Create file `.gitattributes` at the root of your project.

Here is my template:

```
### DO encrypt these:
secret*/** filter=git-crypt diff=git-crypt
# files to encrypt by default
**.key filter=git-crypt diff=git-crypt

### DO NOT encrypt these:
.gitattributes !filter !diff
.gitignore !filter !diff
node_modules/** !filter !diff
Dockerfile !filter !diff
LICENSE !filter !diff
README.md !filter !diff

# /private is part of .gitignore so we do not encrypt it
private/** !filter !diff
```

## Status, see what is encrypted (or not)

```
git-crypt status -e && echo
git-crypt status -u && echo
git-crypt status -f

>>
encrypted: secrets/contract_2022_05_01.md
encrypted: secrets/list.txt
encrypted: secrets/token_aws.key
encrypted: secrets/token_do.key

not encrypted: .git-crypt/.gitattributes
not encrypted: .git-crypt/keys/default/0/9D99B155628F9AC9DDD9ED8B8A4F19B6D38E7253.gpg
not encrypted: .gitattributes
not encrypted: .gitignore
not encrypted: Dockerfile
not encrypted: LICENSE
not encrypted: README.md
not encrypted: docs/DUMMY.md
```

Confirm our file is uncrypted:

```
cat api.key

>
b9dd2892257ffb0ce4e6fd0cdf202f131a03afd17769feabe9effaca265e98be
```

## Lock the projet

Lock our projet and confirm our file is crypted:

```
git-crypt lock && cat api.key

>>
File: secrets/token_aws.key <BINARY>
```

## UnLock the projet (symetric key)

```
git-crypt unlock ~/Documents/.../git-crypt-key
```

## Re-use key in other git repo

To use an existing key file, just use git-crypt unlock instead of git-crypt init when you set up your git repository to use git-crypt, like this:

```
mkdir my-other-project # At the same directory level as myproject
cd my-other-project
git init
echo "Something" > file.txt
git add file.txt
git commit -m "initial commit"

git-crypt unlock ~/Documents/.../git-crypt-key
```

# Method #2 using public/private keys

You should use public/private keys which is much more secure.

## As a USER_DEV

As a USER_DEV, check the gpg keys
`gpg --list-keys`

As a USER_DEV must create a key
`gpg --gen-key`

As a USER_DEV, check the gpg keys and list the keys and copy the key ID (KEY_ID ex: 9F9VD135y67289ACGGD349E8S345TSRY4ECC53):

`gpg --list-keys`

As a USER_DEV, print the public key and pass it to the admin that will be granting the permissions to git-crypt:
`gpg --export --armor $KEY_ID`

As a USER_DEV, export key as file:

```
cd ~/Documents/.../pascalandy
gpg --output public.pgp --armor --export username@email.ca
```

## As an ADMIN (git repo owner)

As an ADMIN import USER_DEV

```
file ~/Documents/.../pascalandy/public.pgp
gpg --import ~/Documents/.../pascalandy/public.pgp
```

As an ADMIN, import USER_DEV within the git repo:

```
cd ~/Documents/.../mycrypt
git-crypt add-gpg-user --trusted username@email.ca

>>
andy16@andy16-2:~/Documents/.../mycrypt|master ⇒ cd ~/Documents/.../mycrypt
andy16@andy16-2:~/Documents/.../mycrypt|master ⇒ git-crypt add-gpg-user --trusted username@email.ca
[master db3e97f] Add 1 git-crypt collaborator
2 files changed, 4 insertions(+)
create mode 100644 .git-crypt/.gitattributes
create mode 100644 .git-crypt/keys/default/0/9F9VD135y67289ACGGD349E8S345TSRY4ECC53.gpg
```

# Conclusion

Symetric steup: It's a good idea to have ../git-crypt-key as an absolut path to you can encrypt everything from anywhere on your computer.

## Bonus

export/backup your keys:

```
gpg --output public.pgp --armor --export pascalandy@users.noreply.github.com
gpg --output private.pgp --armor --export-secret-key pascalandy@users.noreply.github.com
```

source: https://unix.stackexchange.com/a/482559

## Great references

- https://hackernoon.com/things-you-must-know-about-git-crypt-to-successfully-protect-your-secret-data-kyi3wi6
- https://buddy.works/guides/git-crypt
- https://medium.com/@ahmed.kamel/git-crypt-unattended-unlock-with-gpg-passphrase-in-docker-f0aa39b85a
- manage gpg key to sign commits on github - https://www.youtube.com/watch?v=4166ExAnxmo
  - code ~/.gitconfig

## What is great

- The major advantage with a tool like git-crypt is that even if locally you can see all your encrypted files,
  when your commit to your git repo, these secrets ARE ALWAYS ENCRYPTED. You cant mess up once you define which DIR files should be a secret.
- easy symetric key OR gpg user access management

## Key rotation

- No key rotation tool build in, but folks have create script to do just that
- https://github.com/AGWA/git-crypt/issues/47

See this doc online: https://github.com/firepress-org/bashlava/tree/main/docs/help_gitcrypt.md
