# Initial Ubuntu 16.04 Server Setup

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

$ scripts/run-scripts.sh
```

To run only specific roles

```bash
ansible-playbook main.yml --roles=user
```
