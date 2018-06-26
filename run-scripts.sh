#!/bin/bash

set -o xtrace
chmod 777 /scripts/*.*
./scripts/run-playbook-initial-setup.sh
./scripts/run-playbook-main.sh