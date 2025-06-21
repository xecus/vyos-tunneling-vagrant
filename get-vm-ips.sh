#!/bin/bash

echo "=========================================="
echo "Network Experiment VM IP Address Information"
echo "=========================================="

# Get VyOS Router 1 VM IP (exp_vyos)
vyos_ip=$(vagrant ssh exp_vyos -c "ip addr show eth0 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
vyos_wan=$(vagrant ssh exp_vyos -c "ip addr show eth1 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')

printf "VyOS Router 1 (exp_vyos): "
printf "eth0: %-15s " "${vyos_ip:-Not available}"
printf "eth1: %-15s\n" "${vyos_wan:-Not configured}"

echo ""

# Get VyOS Router A VM IP (exp_vyos_a)
vyos_a_ip=$(vagrant ssh exp_vyos_a -c "ip addr show eth0 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
vyos_a_wan=$(vagrant ssh exp_vyos_a -c "ip addr show eth1 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
vyos_a_subnet=$(vagrant ssh exp_vyos_a -c "ip addr show eth2 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')

printf "VyOS Router A (exp_vyos_a): "
printf "eth0: %-15s " "${vyos_a_ip:-Not available}"
printf "eth1: %-15s " "${vyos_a_wan:-Not configured}"
printf "eth2: %-15s\n" "${vyos_a_subnet:-Not configured}"

echo ""

# Get VyOS Router B VM IP (exp_vyos_b)
vyos_b_ip=$(vagrant ssh exp_vyos_b -c "ip addr show eth0 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
vyos_b_wan=$(vagrant ssh exp_vyos_b -c "ip addr show eth1 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
vyos_b_subnet=$(vagrant ssh exp_vyos_b -c "ip addr show eth2 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')

printf "VyOS Router B (exp_vyos_b): "
printf "eth0: %-15s " "${vyos_b_ip:-Not available}"
printf "eth1: %-15s " "${vyos_b_wan:-Not configured}"
printf "eth2: %-15s\n" "${vyos_b_subnet:-Not configured}"

echo ""

# Get Ubuntu A VM IP (exp_ubuntu_a)
ubuntu_a_ip=$(vagrant ssh exp_ubuntu_a -c "ip addr show ens5 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
ubuntu_a_subnet=$(vagrant ssh exp_ubuntu_a -c "ip addr show ens6 | grep 'inet ' | awk '{print \$2}'" 2>/dev/null | tr -d '\r')

printf "Ubuntu A VM (exp_ubuntu_a): "
printf "ens5: %-15s " "${ubuntu_a_ip:-Not available}"
printf "ens6: %-15s\n" "${ubuntu_a_subnet:-Not configured}"

echo ""

# Get Ubuntu B VM IP (exp_ubuntu_b)
ubuntu_b_ip=$(vagrant ssh exp_ubuntu_b -c "ip addr show ens5 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1" 2>/dev/null | tr -d '\r')
ubuntu_b_subnet=$(vagrant ssh exp_ubuntu_b -c "ip addr show ens6 | grep 'inet ' | awk '{print \$2}'" 2>/dev/null | tr -d '\r')

printf "Ubuntu B VM (exp_ubuntu_b): "
printf "ens5: %-15s " "${ubuntu_b_ip:-Not available}"
printf "ens6: %-15s\n" "${ubuntu_b_subnet:-Not configured}"

echo ""
echo "=========================================="
