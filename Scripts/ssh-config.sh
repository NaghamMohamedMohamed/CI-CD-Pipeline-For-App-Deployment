#!/bin/bash

# Load Terraform outputs
OUTPUT_FILE="../Terraform/tf_output.json"

# Replace with your key generated name
SSH_KEY_NAME="ssh-key"

KEY_PATH="$HOME/ITI-Jenkins/Extra-Project/$SSH_KEY_NAME"
BASTION_IP=$(jq -r '.bastion_public_ip.value' $OUTPUT_FILE)
MASTER_IP=$(jq -r '.jenkins_master_private_ip.value' $OUTPUT_FILE)
SLAVE_IP=$(jq -r '.jenkins_slave_private_ip.value' $OUTPUT_FILE)
NODEJS_APP_1_IP=$(jq -r '.nodejs_app1_private_ip.value' $OUTPUT_FILE)
NODEJS_APP_2_IP=$(jq -r '.nodejs_app2_private_ip.value' $OUTPUT_FILE)

SSH_CONFIG="$HOME/.ssh/config"

# Generate SSH config
cat <<EOF > $SSH_CONFIG
Host bastion
  HostName $BASTION_IP
  User ubuntu
  IdentityFile $KEY_PATH

Host jenkins-master
  HostName $MASTER_IP
  User ubuntu
  IdentityFile $KEY_PATH
  ProxyJump bastion

Host jenkins-slave
  HostName $SLAVE_IP
  User ubuntu
  IdentityFile $KEY_PATH
  ProxyJump bastion

Host nodejs-app1
  HostName $NODEJS_APP_1_IP
  User ubuntu
  IdentityFile $KEY_PATH
  ProxyJump bastion

Host nodejs-app2
  HostName $NODEJS_APP_2_IP
  User ubuntu
  IdentityFile $KEY_PATH
  ProxyJump bastion
EOF

chmod 600 "$SSH_CONFIG"

echo "✅ SSH config written to : $SSH_CONFIG"