#!/usr/bin/env python2
from subprocess import call
ip_addresses = [
    # Træfik node
    ("192.38.56.37", "172.19.0.233"),
    # Backup (Temporary)
    ("130.225.198.207", "172.19.0.235"),
    # Git (Temporary)
    ("192.38.56.36", "172.19.0.232"),
    # Web (Temporary)
    ("192.38.56.38", "172.19.0.234")
]
for (src, dest) in ip_addresses:
    call(["sudo", "iptables", "-t", "nat", "-I", "PREROUTING", "-d", src, "-j", "DNAT", "--to-destination", dest])
    call(["sudo", "iptables", "-t", "nat", "-I", "OUTPUT", "-d", src, "-j", "DNAT", "--to-destination", dest])
call(["sudo", "iptables-save"])
