from subprocess import call

ip_addresses = [
    ("192.38.56.37", "172.19.0.233"),
    ("130.225.198.207", "172.19.0.235"),
    ("192.38.56.36", "172.19.0.232"),
    ("192.38.56.38", "172.19.0.234")
]

for (from, to) in ip_addresses:
    call(["sudo", "iptables", "-t", "nat", "-I", "PREROUTING", "-d", from, "-j", "DNAT", "--to-destination", to])
    call(["sudo", "iptables", "-t", "nat", "-I", "OUTPUT", "-d", from, "-j", "DNAT", "--to-destination", to])
    call(["sudo", "iptables-save"])
