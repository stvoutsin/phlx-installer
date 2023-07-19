# Instructions for using a Docker Container to install the RSP


## Requirements

* Docker
* Git



## Clone this repo on the VM / host on which you will be installing from:

```
git clone https://github.com/stvoutsin/phlx-installer
```


## Build Docker image

```
sudo docker build phlx-installer/ --tag installer
```

## Add your Kubernetes certs & config file

Add your kubernetes cluster certs under certs/

Also, add your kube config under kube/config

## Create ENVIRONMENT vars for the required deployment params:

```
export VAULT_TOKEN=YOUR_VAULT_TOKEN
export REPO=YOUR_PHALANX_REPO
export BRANCH=YOUR_PHALANX_BRANCH
export ENVIRONMENT=YOUR_PHALANX_ENVIRONMENT
export CUR_DIRECTORY=/home/ubuntu # Or whichever directory you have cloned to
export VAULT_ADDR=YOUR_VAULT_ADDRESS
export VAULT_TOKEN_LEASE_DURATION=1000000 # Set to something less than the vault expiration TTL

```


## Run Docker install for the RSP:

```
sudo docker run   \
-it  \
--hostname installer  \
--env REPO=${REPO:?}  \
--env VAULT_TOKEN=${VAULT_TOKEN:?}  \
--env BRANCH=${BRANCH:?}  \
--env ENVIRONMENT=${ENVIRONMENT:?}     \
--env VAULT_ADDR=${VAULT_ADDR:?}     \
--env VAULT_TOKEN_LEASE_DURATION=${VAULT_TOKEN_LEASE_DURATION:?}     \
--volume ${CUR_DIRECTORY:?}"/phlx-installer/certs:/etc/kubernetes/certs"  \
--volume ${CUR_DIRECTORY:?}"/phlx-installer/kube/config:/root/.kube/config" \
--volume ${CUR_DIRECTORY:?}"/phlx-installer/scripts/install.sh:/root/install.sh"  \
--volume ${CUR_DIRECTORY:?}"/phlx-installer/scripts/helper.sh:/root/helper.sh" \
installer
```

