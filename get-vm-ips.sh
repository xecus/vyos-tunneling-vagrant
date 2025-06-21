#!/bin/bash

echo "=========================================="
echo "Network Experiment VM IP Address Information"
echo "=========================================="

# Get VyOS Router 1 VM IP (exp_vyos)
echo "VyOS Router 1 (exp_vyos):"
vyos_ip=$(vagrant ssh exp_vyos -c "ip addr show eth0 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$vyos_ip" ]; then
    echo "  Management IP (eth0): $vyos_ip"
else
    echo "  Management IP (eth0): Not available"
fi

vyos_wan=$(vagrant ssh exp_vyos -c "ip addr show eth1 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$vyos_wan" ]; then
    echo "  WAN IP (eth1):        $vyos_wan"
else
    echo "  WAN IP (eth1):        Not configured"
fi

echo ""

# Get VyOS Router A VM IP (exp_vyos_a)
echo "VyOS Router A (exp_vyos_a):"
vyos_a_ip=$(vagrant ssh exp_vyos_a -c "ip addr show eth0 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$vyos_a_ip" ]; then
    echo "  Management IP (eth0): $vyos_a_ip"
else
    echo "  Management IP (eth0): Not available"
fi

vyos_a_wan=$(vagrant ssh exp_vyos_a -c "ip addr show eth1 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$vyos_a_wan" ]; then
    echo "  WAN IP (eth1):        $vyos_a_wan"
else
    echo "  WAN IP (eth1):        Not configured"
fi

vyos_a_subnet=$(vagrant ssh exp_vyos_a -c "ip addr show eth2 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$vyos_a_subnet" ]; then
    echo "  Subnet A IP (eth2):   $vyos_a_subnet"
else
    echo "  Subnet A IP (eth2):   Not configured"
fi

echo ""

# Get VyOS Router B VM IP (exp_vyos_b)
echo "VyOS Router B (exp_vyos_b):"
vyos_b_ip=$(vagrant ssh exp_vyos_b -c "ip addr show eth0 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$vyos_b_ip" ]; then
    echo "  Management IP (eth0): $vyos_b_ip"
else
    echo "  Management IP (eth0): Not available"
fi

vyos_b_wan=$(vagrant ssh exp_vyos_b -c "ip addr show eth1 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$vyos_b_wan" ]; then
    echo "  WAN IP (eth1):        $vyos_b_wan"
else
    echo "  WAN IP (eth1):        Not configured"
fi

vyos_b_subnet=$(vagrant ssh exp_vyos_b -c "ip addr show eth2 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$vyos_b_subnet" ]; then
    echo "  Subnet B IP (eth2):   $vyos_b_subnet"
else
    echo "  Subnet B IP (eth2):   Not configured"
fi

echo ""

# Get Ubuntu A VM IP (exp_ubuntu_a)
echo "Ubuntu A VM (exp_ubuntu_a):"
ubuntu_a_ip=$(vagrant ssh exp_ubuntu_a -c "ip addr show ens5 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$ubuntu_a_ip" ]; then
    echo "  Management IP (ens5): $ubuntu_a_ip"
else
    echo "  Management IP (ens5): Not available"
fi

ubuntu_a_subnet=$(vagrant ssh exp_ubuntu_a -c "ip addr show ens6 | grep 'inet ' | awk '{print \$2}'" 2>/dev/null | tr -d '\r')
if [ -n "$ubuntu_a_subnet" ]; then
    echo "  Subnet A IP (ens6):   $ubuntu_a_subnet"
else
    echo "  Subnet A IP (ens6):   Not configured"
fi

echo ""

# Get Ubuntu B VM IP (exp_ubuntu_b)
echo "Ubuntu B VM (exp_ubuntu_b):"
ubuntu_b_ip=$(vagrant ssh exp_ubuntu_b -c "ip addr show ens5 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
if [ -n "$ubuntu_b_ip" ]; then
    echo "  Management IP (ens5): $ubuntu_b_ip"
else
    echo "  Management IP (ens5): Not available"
fi

ubuntu_b_subnet=$(vagrant ssh exp_ubuntu_b -c "ip addr show ens6 | grep 'inet ' | awk '{print \$2}'" 2>/dev/null | tr -d '\r')
if [ -n "$ubuntu_b_subnet" ]; then
    echo "  Subnet B IP (ens6):   $ubuntu_b_subnet"
else
    echo "  Subnet B IP (ens6):   Not configured"
fi

echo ""
echo "=========================================="
echo "Network Experiment Configuration Summary:"
echo "  WAN Network:      expnet_wan"
echo "  Subnet A Network: expnet_subnet_a"
echo "  Subnet B Network: expnet_subnet_b"
echo "  VyOS Routers:     exp_vyos (WAN), exp_vyos_a (WAN+Subnet A), exp_vyos_b (WAN+Subnet B)"
echo "  Ubuntu Clients:   exp_ubuntu_a (Subnet A), exp_ubuntu_b (Subnet B)"
echo "=========================================="
