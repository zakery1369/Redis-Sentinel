# Redis-Sentinel
![Redis Sentinel](https://github.com/zakery1369/Redis-Sentinel/blob/master/Redis.png)

- ## Install Redis on Debian

1.Update Debian System Packages
```
sudo apt update
```
2.Install Required Packages
```
sudo apt install software-properties-common apt-transport-https curl ca-certificates -y
```
3.Install Redis with APT Debian Repository
```
sudo apt install redis redis-server redis-tools redis-sentinel
```
4.Activate the redis-sentinel service to start on boot.
```
sudo systemctl enable redis-server --now
```

- ## Redis-1 Configuration

Edit /etc/redis/redis.conf
```
protected-mode yes
port 6379
masterauth a-very-complex-password-here
requirepass a-very-complex-password-here
bind redis-1-IP
```
- ## Redis-2 Configuration

Edit /etc/redis/redis.conf
```
protected-mode yes
port 6379
replicaof redis-1-IP 6379
masterauth complex-password-here
requirepass complex-password-here
bind redis-2-IP
```

- ## Redis-3 Configuration

Edit /etc/redis/redis.conf
```
protected-mode yes
port 6379
replicaof redis-1-IP 6379
masterauth a-very-complex-password-here
requirepass complex-password-here
bind redis-3-IP
```

- ## Redis-Sentinel-1 & Redis-Sentinel-2 & Redis-Sentinel-3 Configuration

Edit /etc/redis/sentinel.conf
```
port 26379
sentinel monitor mymaster redis-1-IP 6379 2
sentinel down-after-milliseconds mymaster 5000
sentinel failover-timeout mymaster 60000
sentinel auth-pass mymaster complex-password-here
protected-mode no
```
Next
```
redis-cli -p 26379
127.0.0.1:26379> sentinel master mymaster
```
- ## Check Sentinels

Run this command To check the Redis sentinel information.
```
redis-cli -h redis-(1-2-3)-IP -p 26379
redis-IP:26379> info sentinel
```
OR
```
redis-cli -p 26379
redis-IP:26379> info sentinel
```
- ## Check Replication

Run this command To check the Redis replication information.

```
redis-cli -h redis-(1-2-3)-IP
redis-IP:6379> auth complex-password-here
OK
redis-IP:6379> info replication
```
