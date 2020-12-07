# !/bin/sh
NOCOLOR="\033[0m"
GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[0;34m"

GIT_MULTI_REVERT=${GIT_MULTI_REVERT:-~/.git-multi-revert}
GIT_MULTI_REVERTRC=${GIT_MULTI_REVERT:-~/.multi-revertrc}
REPO=${REPO:-andreashimin/git-multi-revert}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-master}

error_output() {
  echo ${RED}"Error: $@"${NOCOLOR} >&2
}

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

setup_git_multi_revert() {
    if command_exists git-multi-revert; then
        error_output "Git-Multi-Revert already installed!"
        exit 1;
    fi

    git clone -c core.eol=lf -c core.autocrlf=false \
    -c fsck.zeroPaddedFilemode=ignore \
    -c fetch.fsck.zeroPaddedFilemode=ignore \
    -c receive.fsck.zeroPaddedFilemode=ignore \
    --depth=1 --branch "$BRANCH" "$REMOTE" "$GIT_MULTI_REVERT" || {
    error_output "${RED}git clone of git-multi-revert repo failed${NOCOLOR}"
        exit 1
    }

    # Setup alias to config
    if [ -f ~/.zshrc ]; then
        echo "alias git-multi-revert=\"sh $GIT_MULTI_REVERT/scripts/multi-revert.sh\"" >> ~/.zshrc
    elif [ -f ~/.bashrc]; then
        echo "alias git-multi-revert=\"sh $GIT_MULTI_REVERT/scripts/multi-revert.sh\"" >> ~/.bashrc
    fi

    cp $GIT_MULTI_REVERT/scripts/multi-revertrc-template > $GIT_MULTI_REVERTRC

    echo "${GREEN}Git-Multi-Revert install successfully!${NOCOLOR}"
}

setup_git_multi_revert