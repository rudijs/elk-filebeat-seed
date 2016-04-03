#!/usr/bin/env bash

# iptables nat rules
sudo iptables -A FORWARD -i eth0 -s 10.0.2.0/24 -d 0.0.0.0/0 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -s 10.0.2.0/24 -j MASQUERADE

# make iptables rules persistent
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -q iptables-persistent

# Enable forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# make forwarding rules persistent
sudo sed -i 's/#net\.ipv4\.ip_forward=1/net\.ipv4\.ip_forward=1/' /etc/sysctl.conf
sudo sed -i 's/#net\.ipv6\.conf\.all\.forwarding=1/net\.ipv6\.conf\.all\.forwarding=1/' /etc/sysctl.conf
