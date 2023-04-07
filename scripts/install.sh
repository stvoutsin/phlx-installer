#!/bin/sh

# Run helper script
./root/helper.sh

# Clone Repo and set to appropriate branch
git clone $REPO /phalanx
git -C /phalanx checkout $BRANCH

# Install RSP
cd /phalanx/installer/
./install.sh $ENVIRONMENT $VAULT_TOKEN
