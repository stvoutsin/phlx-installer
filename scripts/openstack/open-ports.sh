# Open the required Openstack ports

# Check if the first parameter is provided
if [ -z "$1" ]; then
  echo "Error: Cluster name not provided."
  exit 1
fi

cluster_name="$1"

sec_group_list=$(openstack security group list -f json)
sec_groups=($(echo $sec_group_list | jq -r --arg search_string "${cluster_name}" "[.[] | select(.Name | contains(\$search_string)) | .Name] | join(\" \")"))


for group in "${sec_groups[@]}"
do
    openstack security group rule create --ingress --protocol tcp --dst-port 80:80 --remote-ip 0.0.0.0/0 "$group"
    openstack security group rule create --ingress --protocol tcp --dst-port 443:443 --remote-ip 0.0.0.0/0 "$group"
    openstack security group rule create --ingress --protocol tcp --dst-port 8443:8443 --remote-ip 0.0.0.0/0 "$group"
    openstack security group rule create --ingress --protocol tcp --dst-port 6379:6379 --remote-ip 0.0.0.0/0 "$group"
done
