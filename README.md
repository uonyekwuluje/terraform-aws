# Ansible Cassandra
Ansible Cassandra Cluster

## Supported Distributions
* CentOS 7

## Cassandra Cluster
|Server Name  |  Ip Address    |
|-------------|----------------|
|cassandra01  |  192.168.1.12  |
|cassandra02  |  192.168.1.2   |
|cassandra03  |  192.168.1.190 |

### Setup Multi Node
```
ansible -m ping cassandra -o
ansible -m shell -a "sudo reboot" cassandra -v -o
ansible-playbook main.yml
```
