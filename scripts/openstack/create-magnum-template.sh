#!/bin/bash


# Define the parameters as variables

template_name=$1
volume_driver="cinder"
master_lb_enabled="true"
external_network="external"
image="fedora-coreos-35.20211203.3.0"
flavor="qserv-worker-v2"
master_flavor="qserv-utility"
docker_storage_driver="overlay2"
labels="auto_healing_controller=magnum-auto-healer,auto_healing_enabled=true,auto_scaling_enabled=true,autoscaler_tag=v1.23.0,cinder_csi_enabled=true,cinder_csi_plugin_tag=v1.23.0.1-shpc,cloud_provider_tag=v1.23.0,cloud_provider_enabled=true"
coe="kubernetes"
network_driver="flannel"
dns_nameserver="8.8.8.8"

# Create the cluster template using the parameters
openstack coe cluster template create \
        --volume-driver "$volume_driver" \
        --master-lb-enabled "$master_lb_enabled" \
        --external-network "$external_network" \
        --image "$image" \
        --flavor "$flavor" \
        --master-flavor "$master_flavor" \
        --docker-storage-driver "$docker_storage_driver" \
        --labels "$labels" \
        --coe "$coe" \
        --network-driver "$network_driver" \
        --dns-nameserver "$dns_nameserver" \
        "$template_name"

