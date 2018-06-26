#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/hosts playbooks/main.yml