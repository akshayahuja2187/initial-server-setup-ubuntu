# Initial Ubuntu 16.04 Server Setup

## Pre-Requisites
Git - To checkout this codebase
Ansible 2.1 or higher - To run the Ansible playbooks

## What this playbook does

- installs python2 and aptitude
- upgrades all software
- creates user with sudo rights
- configures sshd: disables root login and password authentication, also allows to login only user created on prev step
- installs
  - git
  - ntp
  - vim
  - tmux
  - htop
  - curl
- configures automatic security updates (do not reloads server, only installs updates)
- setups timezone
- configures iptables and fail2ban
- Updates MOTD to print "Hello Assurity DevOps"

## inventory file

Edit `inventory\hosts` file. Its content is something like this

```
[DEV]
xx.xxx.xx.xx
```

## Initial setup

By default on ubuntu 16.04 there is no python 2 and aptitude.
To fix it run:

```bash
ansible-playbook initial-setup.yml
```

Beside it this playbook also creates user and configures ssh server.

## UFW

Enables only port 22(ssh) for login. You need to edit from_ip=IP replacing IP with your IP Address to restrict to particular IP.

## Environment variables

Copy `vars/main.yml.example` to `vars/main.yml` and change
variable values for your needs.

To generate password use

```bash
sudo apt-get install -y whois
mkpasswd --method=SHA-512
```

## Run

```bash
run the plabooks by executing:

$ ./run-scripts.sh
```

To run only specific roles

```bash
ansible-playbook main.yml --roles=user
```
## Can also be run through Jenkins

Jenkinsfile code snippet:

stage('Checkout Source Code') {
       deleteDir()
       checkout scm
      notifyStash();
    }
	
stage('Run Ansible Playbook'){
			withEnv(['ANSIBLE_HOST_KEY_CHECKING=False']) {
				ansiblePlaybook credentialsId: 'sudouser', 
				extras: "-v -e target_server=${target_env} -e username= -e env_id=${target_env} -e comp_name=sudo_deploy, 
				installation: 'Ansible 2.1', 
				inventory: 'inventory', 
				playbook: 'playbooks/initial-setup.yml', 'playbooks/main.yml'
				}