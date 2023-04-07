#!/bin/bash

# Define the cluster name as a parameter
cluster_name="$1"

# Define the rest of the parameters
cluster_template="stv-template-large"
master_count=1
node_count=5
docker_volume_size=200
labels="admission_control_list=\"NodeRestriction,NamespaceLifecycle,LimitRanger,ServiceAccount,ResourceQuota,TaintNodesByCondition,Priority,DefaultTolerationSeconds,DefaultStorageClass,StorageObjectInUseProtection,PersistentVolumeClaimResize,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,RuntimeClass\""
merge_labels=true
keypair="iris-rsp-1"

# Create the cluster using the parameters
openstack coe cluster create --cluster-template "$cluster_template" \
                             --master-count "$master_count" \
                             --node-count "$node_count" \
                             --docker-volume-size "$docker_volume_size" \
                             --labels "$labels" \
                             --merge-labels \
                             --keypair "$keypair" \
                             "$cluster_name"
