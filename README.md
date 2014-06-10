# Puppet in a Continuous Delivery environment

This repository contains the demo for the Puppet Meetup
presentation. One can read the presentation at these locations:

* [Meetup] (http://www.meetup.com/Denver-Puppet-User-Group/events/184000272/)
* [Slides] (http://technolo-g.github.io/cd_puppet/)
* [Outline] (https://github.com/technolo-g/cd_puppet/blob/gh-pages/README.md)

## What it should do

- Create two SGs in AWS with appropriate rules
- Create two nodes
- Configure the base system on both
- Configure the puppetmaster
    - install puppetmaster
    - autosign certs
    - install a puppet tree from a repo
- Configure the client
    - request cert
    - install ntp # We'll be doing this manually for show



## Setting it up

### Upload your public key

You must upload your public key to AWS in the region in which
you are deploying prior to running the ansible script. 
Upload it and call it `meetup-demo` in the us-west-2 region for
this version

### Install Ansible
```shell
brew install ansbile
```

## Install boto
Boto is a python client for AWS's API. Unfortunately
it does not like virtualenv and so one must install
it as root.

```
sudo pip install boto
```

Then you must configure ~/.boto with your credentails

```
$ cat ~/.boto
[Credentials]
aws_access_key_id = YOURACCESSKEYID
aws_secret_access_key = YOuRsecRetAcceSSkey939
```

## How to use it
## Instructions Unclear!?

```
git clone https://github.com/technolo-g/cd_puppet.git
cd ansible/
ansible-playbook -i hosts demo_playbook.yaml
```
![](images/giphy.gif)
