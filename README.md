# git-multi-revert

use vim to revert multiple commits

# Installation

## 1. Install Git-Multi-Revert

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andreashimin/git-multi-revert/master/tools/install.sh)"
```

## 2. Add Git-Multi-Revert Alias

- On-My-Zsh

```
echo "alias git-multi-revert=\"sh ~/.git-multi-revert/scripts/multi-revert.sh\"" >> ~/.zshrc
```

- Bash

```
echo "alias git-multi-revert=\"sh ~/.git-multi-revert/scripts/multi-revert.sh\"" >> ~/.bashrc
```

🚗🚗🚗 Then, you‘re good to go! 🤗

# How to Use

```
git-multi-revert ${commit SHA-1}

or

sh ~/.git-multi-revert/scripts/multi-revert.sh ${commit SHA-1}
```

# Others

## Edit Revert Commit Message

```
vi ~/.git-multi-revertrc
```

### default

```
ENABLE_WORD="feature-toggle(enable)"
DISABLE_WORD="feature-toggle(disable)"
```

## Uninstall Git-Multi-Revert

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andreashimin/git-multi-revert/master/tools/uninstall.sh)"
```