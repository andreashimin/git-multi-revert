# !/bin/sh
# Temp file export path
TMP_DEST=~/.git-multi-revert/REVERT_MSG.tmp

ENABLE_WORD="feature-toggle(enable)"
DISABLE_WORD="feature-toggle(disable)"

if test -f ~/.git-multi-revertrc ; then
   . ~/.git-multi-revertrc
fi

# Colors Print
NOCOLOR="\033[0m"
GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[0;34m"

# Check if temp file exist
if [ -f $TMP_DEST ]; then
    rm -rf $TMP_DEST
fi

check_revert_exception () {
    if [[ $(echo $@ | grep -i 'Revert \"') = "" ]]; then
        echo "Revert Exception: $@"
        echo "Multiple revert terminate"
        rm -rf $TMP_DEST
        exit;
    fi
}

# Commit starting point
hash=$1

if [[ $2 && "$2" == "--auto" ]]; then
    autoFlag=1
fi


if [[ $(echo $hash | grep -i '\.\.\.') != "" ]]; then
    _resetHash=$(echo $hash | sed 's/\.\.\./ /')
    endHash=$(echo $_resetHash | cut -d ' ' -f1)
    hash=$(echo $_resetHash | cut -d ' ' -f2)
    echo "From Commit: ${BLUE}$endHash...$hash${NOCOLOR}"
else
    echo "From Commit: ${BLUE}$hash${NOCOLOR}"
fi

create_logs_to_tmpfile() {
    line=$(git log --oneline --topo-order | grep -n $@ | cut -d ':' -f1)

    content=$(git log -$line --topo-order --pretty=format:"%h %s")

    # Get history revert status
    content=$(echo "$content" | \
        grep -i -v 'merge' | \
        sed '/toggle(disable/ s/^/disable /' | \
        sed '/toggle(disable/! s/^/enable  /')

    # Remove line not contain latestHash
    if [ $endHash ]; then
        content=$(echo "$content" | sed "/$endHash/,$ !d")
    fi

    # Auto Revert
    if [ $autoFlag ]; then
        content=$(echo "$content" | sed '/toggle(disable/ s/^disable/enable /;/toggle(disable/! s/^enable /disable/')
    fi

    echo "$content \n\n\n\n# alias:\n"\
    "# enable, e - Revert this commit to enable\n"\
    "# disable, d - Revert this commit to disable" > $TMP_DEST
}

create_logs_to_tmpfile $hash

if [ ! $autoFlag ]; then
    vi $TMP_DEST
fi

# Start Revert
echo "Revert list:"
while IFS= read -r line
do
    _hash=$(echo $line | cut -d ' ' -f2)
    _commitMessage=$(echo $line | sed 's/^disable[[:space:]]*//;s/^d[[:space:]]*//;s/^enable[[:space:]]*//;s/^e[[:space:]]*//;s/^[[:alnum:]]\{5,40\}[[:space:]]*//')
    _action=$(echo $line | cut -d ' ' -f1)

    # Disable commit
    if [[ $_action =~ ^(d|disable) && "$(echo $line | grep -i $DISABLE_WORD)" == "" ]]; then
        _garbageMessage=$(git revert $_hash)
        check_revert_exception $_garbageMessage

        if [[ $(echo $line | grep -i $ENABLE_WORD) != "" ]]; then
            _commitMessage=$(echo "$_commitMessage" | sed "s/$ENABLE_WORD/$DISABLE_WORD/")
            _garbageMessage=$(git commit --amend -m "$_commitMessage")
        else
            _commitMessage=$(echo $DISABLE_WORD: $_commitMessage)
            _garbageMessage=$(git commit --amend -m "$_commitMessage")
        fi

        echo "${RED}disable${NOCOLOR} -> ${BLUE}$_commitMessage ${NOCOLOR}"

    # Enable commit
    elif [[ $_action =~ ^(e|enable) && "$(echo $line | grep -i $DISABLE_WORD)" != "" ]]; then
        _garbageMessage=$(git revert $_hash)
        check_revert_exception $_garbageMessage
        _commitMessage=$(echo "$_commitMessage" | sed "s/$DISABLE_WORD/$ENABLE_WORD/")
        _garbageMessage=$(git commit --amend -m "$_commitMessage")

        echo "${GREEN}enable${NOCOLOR} -> ${BLUE}$_commitMessage ${NOCOLOR}"

    # No change
    elif [[ "$line" != "" && $(echo $line | cut -d ' ' -f1) != "#"  ]]; then
        echo "not doing anything -> $_commitMessage"

    fi
done < $TMP_DEST

rm -rf $TMP_DEST