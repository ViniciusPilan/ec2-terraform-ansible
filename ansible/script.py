import json

## Loading the outputs json file
json_file = open("../terraform/outputs.json", "r")
json_dict = json.load(json_file)
json_file.close()

host_name = json_dict["instance_name"]["value"]
host_ipv4 = json_dict["instance_public_ipv4"]["value"]


## Generating the inventory file
inventory_file = open("hosts.yaml", "w")

inventory_file.write(
f'''[{host_name}]
{host_ipv4} ansible_user=ubuntu
'''
)

inventory_file.close()


## Generating the playbook for ansible
playbook_file = open("playbook.yaml", "w")

playbook_file.write(
f'''
- hosts: {host_name}
  tasks:
  - name: NGINX install
    apt: name=nginx state=latest
    become: yes
  - name: NGINX started
    service:
      name: nginx
      state: started
    become: yes

'''
)

playbook_file.close()

