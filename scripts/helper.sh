#!/bin/sh

cat > "/root/storageclass.yml" << 'EOF'
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: standard
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: kubernetes.io/cinder
parameters:
  availability: nova
EOF

kubectl create -f /root/storageclass.yml
