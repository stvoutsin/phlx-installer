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
export VAULT_ADDR=
export VAULT_ROLE_ID=
export VAULT_SECRET_ID=
export REPO=
export BRANCH=
export ENVIRONMENT=
export CUR_DIRECTORY=/home/ubuntu # Or whichever directory you have cloned to

```


## Run Docker install for the RSP:

```
	 sudo docker run   \
	   -it  \
	   --hostname installer  \
	   --env REPO=${REPO:?}  \
	   --env VAULT_ADDR=${VAULT_ADDR:?}  \
	   --env VAULT_SECRET_ID=${VAULT_SECRET_ID:?}  \
	   --env VAULT_ROLE_ID=${VAULT_ROLE_ID:?}  \
	   --env BRANCH=${BRANCH:?}  \
	   --env ENVIRONMENT=${ENVIRONMENT:?}     \
	   --volume ${CUR_DIRECTORY:?}"/phlx-installer/certs:/etc/kubernetes/certs"  \
	   --volume ${CUR_DIRECTORY:?}"/phlx-installer/kube/config:/root/.kube/config" \
	   --volume ${CUR_DIRECTORY:?}"/phlx-installer/scripts/install.sh:/root/install.sh"  \
	   --volume ${CUR_DIRECTORY:?}"/phlx-installer/scripts/helper.sh:/root/helper.sh" \
	   installer
```

