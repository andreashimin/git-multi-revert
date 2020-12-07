# Git-Multi-Revert

use vim to revert multiple commits

# Installation

## 1. Install Git-Multi-Revert

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andreashimin/git-multi-revert/master/tools/install.sh)"
```

## 2. Add Git-Multi-Revert Alias

- On-My-Zsh

```sh
echo "alias git-multi-revert=\"sh ~/.git-multi-revert/scripts/multi-revert.sh\"" >> ~/.zshrc
```

- Bash

```sh
echo "alias git-multi-revert=\"sh ~/.git-multi-revert/scripts/multi-revert.sh\"" >> ~/.bashrc
```

🚗🚗🚗 Then, you‘re good to go! 🤗

# How to Use

- Will return the latest commit logs untill your select commit

```sh
git-multi-revert ${commit SHA-1}

or

sh ~/.git-multi-revert/scripts/multi-revert.sh ${commit SHA-1}
```

## Optional Revert Way

- Give a range of commits(from latest...oldest) to Git-Multi-Revert

```sh
git-multi-revert ${commit SHA-1}...${commit SHA-1}
```

- You can set a flag `--auto, -a` for Git-Multi-Revert automatic revert your commits

```sh
git-multi-revert ${commit SHA-1} --auto
```

# Others

## Edit Revert Commit Message

```sh
vi ~/.git-multi-revertrc
```

### default

```sh
ENABLE_WORD="feature-toggle(enable)"
DISABLE_WORD="feature-toggle(disable)"
```

## Uninstall Git-Multi-Revert

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andreashimin/git-multi-revert/master/tools/uninstall.sh)"
```