# !/bin/sh
read -r -p "Are you sure you want to remove Git-Multi-Revert? [Y/N] " confirmation
if [ "$confirmation" != y ] && [ "$confirmation" != Y ]; then
  echo "Uninstall cancelled"
  exit
fi

echo "Removing ~/.git-multi-revert"
if [ -d ~/.git-multi-revert ]; then
  rm -rf ~/.git-multi-revert
fi

if [ -e ~/.multi-revertrc ]; then
  rm -rf ~/.multi-revertrc
  echo "Remove ~/.multi-revertrc"
fi

# Remove alias from config
if [ -f ~/.zshrc ]; then
    sed -e "/sh $GIT_MULTI_REVERT/scripts/multi-revert.sh\"/d" ~/.zshrc > ~.zshrc
elif [ -f ~/.bashrc]; then
    sed -e "/sh $GIT_MULTI_REVERT/scripts/multi-revert.sh\"/d" ~/.bashrc > ~.bashrc
fi

echo "Git-Multi-Revert uninstall successfully!"