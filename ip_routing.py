#!/usr/bin/env python2
from subprocess import call
ip_addresses = [
    # Backup
    ("130.225.198.207", "172.19.0.235"),
    # Node03 (AKA git atm, remove public IP in future)
    ("192.38.56.36", "172.19.0.232"),
    # Web
    ("192.38.56.38", "172.19.0.234")
    # Master node
    ("192.38.56.136", "172.19.0.243")
]
for (src, dest) in ip_addresses:
    call(["sudo", "iptables", "-t", "nat", "-I", "PREROUTING", "-d", src, "-j", "DNAT", "--to-destination", dest])
    call(["sudo", "iptables", "-t", "nat", "-I", "OUTPUT", "-d", src, "-j", "DNAT", "--to-destination", dest])

# This only dumps what iptables looks like right now, use 'iptables save'. 
# call(["sudo", "iptables-save"])
