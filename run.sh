#!/bin/bash

# Validate not sudo
user_id=`id -u`
if [ $user_id -eq 0 -a -z "$RUNNER_ALLOW_RUNASROOT" ]; then
    echo "Must not run interactively with sudo"
    exit 1
fi

# Get the script root directory
# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within

	# this does not work well with zsh or custom dotfile configs
	# even if run with bash shebang, the BASH_SOURCE environment variable
	# is not guaranteed to be available and correct.
	# SOURCE="${BASH_SOURCE[0]}"

	# $0 is in the posix standard and will resolve easily if the file is not
	# found, it is easier to fix (cd to the directory where the package archive
	# was unzipped ... as per step 1 of the instructions!)
	# resource: https://github.com/skeptycal/gorepo/settings/actions/add-new-runner

	# example of error received: ./run.sh: line 27: /Users/skeptycal/.dotfiles/zshrc_inc/bin/Runner.Listener: No such file or directory

	# macOS Big Sur Intel with BASH 5.1 and ZSH 5.8
	# Darwin Michaels-MacBook-Pro.local 20.3.0 Darwin Kernel Version 20.3.0: Thu Jan 21 00:07:06 PST 2021; root:xnu-7195.81.3~1/RELEASE_X86_64 x86_64 i386 MacBookPro11,4 Darwin

# removed in favor of gnu utilities
	# SOURCE="${BASH_SOURCE[0]}"
	# while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	#   DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	#   SOURCE="$(readlink "$SOURCE")"
	#   [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	# done

SOURCE="$0"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Do not "cd $DIR". For localRun, the current directory is expected to be the repo location on disk.

# Run
shopt -s nocasematch
if [[ "$1" == "localRun" ]]; then
    "$DIR"/bin/Runner.Listener $*
else
    "$DIR"/bin/Runner.Listener run $*

# Return code 3 means the run once runner received an update message.
# Sleep 5 seconds to wait for the update process finish
    returnCode=$?
    if [[ $returnCode == 3 ]]; then
        if [ ! -x "$(command -v sleep)" ]; then
            if [ ! -x "$(command -v ping)" ]; then
                COUNT="0"
                while [[ $COUNT != 5000 ]]; do
                    echo "SLEEP" > /dev/null
                    COUNT=$[$COUNT+1]
                done
            else
                ping -c 5 127.0.0.1 > /dev/null
            fi
        else
            sleep 5
        fi
    else
        exit $returnCode
    fi
fi
