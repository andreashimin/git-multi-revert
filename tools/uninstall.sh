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

unalias git-revert

echo "Git-Multi-Revert uninstall successfully!"