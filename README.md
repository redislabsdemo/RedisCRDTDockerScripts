# Redis CRDT Docker Scripts

This project provides you the shell scripts necessary to:
1. Setup a CRDT-based active-active Redis Enterprise database
2. Test your applications with connected and partitioned networks
3. Stop the database.

With these scripts, you can create your development and testing environment without the need to use Redis Enterprise's web application. Please note that this setup is not meant for production deployment.

## Pre-requisites

Install Docker in your development/testing environment. Go to Docker -> Preferences -> Advanced and increase your memory to atleast 6.0 GiB.


## What the scripts do and how they work?

### 1. create_3_node_redis_crdt.sh

This script does the following:
1. Creates three subnets - 172.18.0.0/16, 172.19.0.0/16, 172.20.0.0/16 - and adds routes between them
2. Pulls Redis Enterprise (redislabs/redis) from Docker hub
3. Installs three instances of Redis Enterprise - one in each subnet - and opens up the ports 12000, 12002, 12004.
4. Creates a three-node Redis Enterprise cluster
5. Provisions a CRDT-based database on the three-node cluster

When the script completes executing its commands, you will have a master Redis Enterprise database on each node. The databases are exposed via ports 12000, 12002, and 12004. You can test connecting to your database by running:

```
redis-cli -p 12000
redis-cli -p 12002
redis-cli -p 12004
```

A sample screenshot of executing the script is shown below:

```
Creating new subnets...
58237230f6a599aa9def252047f3b3fcfe2c7a6d9a3991c1c5ec60e4514f6045
204084cb96d774d20b1d47f3ec45d6df567ba9f226868ab4a5bd0f7b80a3b807
8737f94f6a4a80f33eaa1c210cdd582a6334726d34a56a2d7dc73cddb589d378
Starting Redis Enterprise as Docker containers...
686f65746026f210547018a443bbd074d84e37699319b1c5ca71937386eefe96
08576b31d609732a552107486e17010ca2607d3d6998e7e86d7e44709bf519bf
cb3f083308004b2485fa267688ce9d9603ed8a981ca969e7eecea68c8a8284f1
Waiting for the servers to start...
Creating clusters
Creating a new cluster... ok
Creating a new cluster... ok
Creating a new cluster... ok
Creating a CRDB
Task 1393ef07-ba3c-42b4-bd14-2928403dca70 created
  ---> CRDB GUID Assigned: crdb:35128955-afdb-42d3-b144-8cab3d4525e0
  ---> Status changed: queued -> started
  ---> Status changed: started -> finished
```

### 2. split_network.sh

This script removes the routes between the subnets, and hence breaking the communication between the Redis CRDT replicas in the three-node cluster.

### 3. restore_network.sh

Use this script to restore the network routes and hence the communication between the replicas.

### 4. stop.sh

This script stops all the Redis Enteprise services and removes all the Docker processes and subnets.




