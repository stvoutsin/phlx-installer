# phlx-installer
Docker Container for installing the RSP

# Instructions

Clone this repo on the VM / host on which you will be installing from:
```
  git clone https://github.com/stvoutsin/phlx-installer
```


Create ENVIRONMENT vars for the required deployment params:

```
export VAULT_TOKEN=YOUR_VAULT_TOKEN
export REPO=YOUR_PHALANX_REPO
export BRANCH=YOUR_PHALANX_BRANCH
export ENVIRONMENT=YOUR_PHALANX_ENVIRONMENT
export CUR_DIRECTORY=pwd
```


Run Docker install for the RSP:

```
sudo docker run \        
       -it \   
       --hostname installer  \
       -e REPO=${REPO:?} \ 
       -e VAULT_TOKEN=${VAULT_TOKEN:?} \
       -e BRANCH=${BRANCH:?} \
       -e ENVIRONMENT=${ENVIRONMENT:?}   \  
       --volume "${CUR_DIRECTORY:?}/phlx-installer/certs:/etc/kubernetes/certs"   \      
       --volume "${CUR_DIRECTORY:?}/phlx-installer/kube/config:/root/.kube/config"  \   
       --volume "${CUR_DIRECTORY:?}/phlx-installer/scripts/install.sh:/root/install.sh" \ 
       --volume "${CUR_DIRECTORY:?}/phlx-installer/scripts/helper.sh:/root/helper.sh" \            
       installer
```

