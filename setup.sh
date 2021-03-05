#!/usr/bin/env bash

# Setup for the GitHub Actions Runner
# for macOS X64 (likely works on any macOS, Linux, POSIX systems)
# Instructions and reference are at the end of this file.

# this script is designed to setup with a required repo url that must be in #1

_USAGE="setup.sh <URL>"

if [ -z "$1" ]; then
	echo "No repo url provided."
	echo $_USAGE
    exit 1
fi


#   <span id="clipboard-copy-content-win-download-the-latest-runner-package">Invoke-WebRequest -Uri <span class="js-action-runner-url">https://github.com/actions/runner/releases/download/v2.277.1/actions-runner-osx-x64-2.277.1.tar.gz</span> -OutFile <span class="js-action-runner-filename">actions-runner-osx-x64-2.277.1.tar.gz</span></span>
PACKAGE_URL_CLASS="js-action-runner-url"
#	<span id="clipboard-copy-content-unix-create-the-runner-and-start-the-configuration-experience">./config.sh --url https://github.com/skeptycal/gorepo --token AGHP5IFLH5XATTWEHYMGRSDAIGXEE</span>
CONFIG_URL_CLASS="clipboard-copy-content-unix-create-the-runner-and-start-the-configuration-experience"

# this step from the original instructions must be done prior to running this script
# mkdir actions-runner && cd actions-runner
SOURCE="$0"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

curl -O -L https://github.com/actions/runner/releases/download/v2.277.1/actions-runner-osx-x64-2.277.1.tar.gz
tar xzf ./actions-runner-osx-x64-2.277.1.tar.gz
./config.sh --url https://github.com/skeptycal/gorepo --token AGHP5IFLH5XATTWEHYMGRSDAIGXEE
./run.sh

echo
echo "Using your self-hosted runner"
echo
echo "# Use this YAML in your workflow file for each job"
echo "    runs-on: self-hosted"
echo

# Setup for the GitHub Actions Runner
	# for macOS X64 (likely works on any macOS, Linux, POSIX systems)

# Reference: https://github.com/skeptycal/gorepo/settings/actions/add-new-runner
	# Adding a self-hosted runner requires that you download, configure, and
	# execute the GitHub Actions Runner. By downloading and configuring the
	# Github Actions Runner, you agree to the GitHub Terms of Service
	# 	https://docs.github.com/github/site-policy/github-terms-of-service
	# or GitHub Corporate Terms of Service
	#   https://docs.github.com/github/site-policy/github-corporate-terms-of-service
	# as applicable.

# Instructions
# Download
	# Create a folder
	# 	$ mkdir actions-runner && cd actions-runner
	# Download the latest runner package
	# 	$ curl -O -L https://github.com/actions/runner/releases/download/v2.277.1/actions-runner-osx-x64-2.277.1.tar.gz
	# Extract the installer
	# 	$ tar xzf ./actions-runner-osx-x64-2.277.1.tar.gz

# Configure
	# Create the runner and start the configuration experience
	# 	$ ./config.sh --url https://github.com/skeptycal/gorepo --token AGHP5IFLH5XATTWEHYMGRSDAIGXEE
	# Last step, run it!
	# 	$ ./run.sh

# Using your self-hosted runner
	# Use this YAML in your workflow file for each job
	# runs-on: self-hosted
	# For additional details about configuring, running, or shutting down the runner, please check out our product docs at:
	# https://docs.github.com/github/automating-your-workflow-with-github-actions/hosting-your-own-runners
