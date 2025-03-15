#!/usr/bin/env bash

# passwordless login
For that you need ot push you publick key to authorized keys.
2) run "ssh-keygen" and accept the defaults, including an empty password, this will create two files: "~/.ssh/id_rsa" and "~/.ssh/id_rsa.pub".
4) Copy the public key (.pub) onto remote host
5) cat ~/.ssh/id_rsa.pub | ssh my-ec2-desktop.us-west-2.amazon.com "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

