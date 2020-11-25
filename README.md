# Ansible Cassandra
Ansible Cassandra Cluster

## Supported Distributions
* CentOS 7

## Cassandra Cluster
|Server Name  |  Ip Address    |
|-------------|----------------|
|cassandra01  |  192.168.1.239 |
|cassandra02  |  192.168.1.237 |
|cassandra03  |  192.168.1.240 |

# Setup Multi Node
```
ansible -m ping cassandra -o
ansible -m shell -a "sudo reboot" cassandra -v -o
ansible-playbook main.yml
```
## Testing & Verification
When ansible completes, login to one of the nodes and type ```nodetool status```. You should see this:
```
Datacenter: DEVDC1
==================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address        Load        Tokens  Owns (effective)  Host ID                               Rack       
UN  192.168.1.239  215.62 KiB  256     ?                 f0aa8dfb-5c10-4bd6-91b5-9c11ce658237  DEVLABRACK1
UN  192.168.1.237  191.15 KiB  256     ?                 99d137fc-8807-440f-9956-6813c58bc4a9  DEVLABRACK1
UN  192.168.1.240  215.6 KiB   256     ?                 145cba34-2621-488b-bff3-3df127ce3326  DEVLABRACK1
```
***NOTE: Update Data Center and Rack Settings as needed***


# Setup Single Node
```
ansible -m ping cassandraone -o
ansible -m shell -a "sudo reboot" cassandraone -v -o
ansible-playbook cassandra-one.yml
```
## Testing & Verification
When ansible completes, login to one of the nodes and type ```nodetool status```. You should see this:
```
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load      Tokens  Owns (effective)  Host ID                               Rack 
UN  127.0.0.1  73.3 KiB  256     ?                 42cbbf52-07eb-4b88-a502-77d7ae29cf04  rack1
```
