## Install Redis on Debian
sudo apt update
sudo apt install software-properties-common apt-transport-https curl ca-certificates -y
sudo apt install redis redis-server redis-tools redis-sentinel
sudo systemctl enable redis-server --now
## Redis-1 Configuration
protected-mode yes
port 6379
masterauth complex-password-here
requirepass complex-password-here
bind redis-1-IP
## Redis-2 Configuration
protected-mode yes
port 6379
replicaof redis-1-IP 6379
masterauth complex-password-here
requirepass complex-password-here
bind redis-2-IP
## Redis-3 Configuration
protected-mode yes
port 6379
replicaof redis-1-IP 6379
masterauth a-very-complex-password-here
requirepass complex-password-here
bind redis-3-IP
## Redis-Sentinel-1 & Redis-Sentinel-2 & Redis-Sentinel-3 Configuration
port 26379
sentinel monitor mymaster redis-1-IP 6379 2
sentinel down-after-milliseconds mymaster 5000
sentinel failover-timeout mymaster 60000
sentinel auth-pass mymaster complex-password-here
protected-mode no
