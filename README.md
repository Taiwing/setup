# setup

This script installs needed dev dependencies for an arch based linux system.

## Setup

```shell
# clone the repo
git clone https://github.com/Taiwing/setup
# run the script
cd setup/ && ./setup.bash
```

## Usage

setup will install the dependencies and the configuration files by default.
It can also remove them if needed.

```
Usage:
    ./setup.bash
    ./setup.bash -u

Options:
    -h, --help
        Print this.

    -v, --verbose
	Show each line of this script before execution.

    -i, --install
	Install packet managers and dependencies. Also creates the configuration
	files. This is the default behavior.

    -u, --uninstall
        Uninstall packet managers, every program installed with them, and remove
	the configuration files created by this script (make sure to save them
	if any meaningful local modification has been made).
```
