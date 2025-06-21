# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a VyOS-based network laboratory that demonstrates **VXLAN over WireGuard tunneling** to connect geographically separated subnets. The project implements a hub-and-spoke network topology with encrypted overlay networking.

## Architecture

**Network Components:**
- **3 VyOS Routers**: Central hub (`exp_vyos`) and two remote sites (`exp_vyos_a`, `exp_vyos_b`)
- **2 Ubuntu Clients**: Test endpoints in each remote subnet
- **Overlay Network**: 172.16.0.0/16 unified address space across all sites
- **Tunneling**: WireGuard VPN (10.1.2.0/29) + VXLAN overlay (VNI 100/101)

**Key Technologies:**
- VyOS routing platform with WireGuard and VXLAN support
- Vagrant with libvirt/QEMU for virtualization
- Ansible for configuration management
- Linux bridging for Layer 2 connectivity

## Common Commands

**Initial Setup:**
```bash
# Install prerequisites
apt install ansible-core
ansible-galaxy collection install vyos.vyos

# Start VMs and networks
vagrant up

# Discover VM IP addresses for inventory
./get-vm-ips.sh
```

**Configuration Deployment (must be run in sequence):**
```bash
# Configure VyOS routers (order matters for tunnel establishment)
ansible-playbook -i inventory.ini playbook-vyos.yml
ansible-playbook -i inventory.ini playbook-vyos-a.yml  
ansible-playbook -i inventory.ini playbook-vyos-b.yml

# Configure Ubuntu clients
ansible-playbook -i inventory.ini playbook-client.yml
```

**Environment Management:**
```bash
# Check VM status
vagrant status

# SSH into specific VMs
vagrant ssh exp_vyos
vagrant ssh exp_ubuntu_a

# Restart specific VM
vagrant reload exp_vyos_a

# Clean up environment
vagrant destroy
```

## Critical Security Note

**WireGuard keys in the playbooks are examples only.** Before deploying:

1. Generate new key pairs on each VyOS router:
```bash
vyos@vyos:~$ generate pki wireguard key-pair
```

2. Update the private keys in each playbook file
3. Update the corresponding public keys in peer configurations

## Configuration Structure

**Inventory Management:**
- `inventory.ini`: Host definitions with group-level variables for vyos and ubuntu groups
- Groups: `vyos_center`, `vyos_a`, `vyos_b`, `ubuntu_a`, `ubuntu_b`

**Playbook Architecture:**
- Each VyOS router has a dedicated playbook with specific tunnel endpoints
- Client playbook handles Ubuntu provisioning with Docker installation
- Templates use Jinja2 for dynamic MAC address detection

**Network Design:**
- WAN simulation: `expnet_wan` (172.17.0.0/16)
- Remote subnets: `expnet_subnet_a` and `expnet_subnet_b`
- VXLAN overlay provides transparent Layer 2 connectivity between sites
- NAT masquerading enables internet access for all clients

## Development Workflow

1. Modify Ansible playbooks or templates
2. Test configuration changes with individual playbook runs
3. Use `./get-vm-ips.sh` to verify network connectivity
4. Validate tunnel establishment through VyOS router interfaces
5. Test end-to-end connectivity between Ubuntu clients across subnets

## Troubleshooting

**Common Issues:**
- WireGuard tunnel not establishing: Check key pairs and endpoint addresses
- VXLAN connectivity issues: Verify VNI assignments and source/remote addresses
- Client network configuration: Check MAC address detection in netplan templates
- VM IP address changes: Re-run `./get-vm-ips.sh` and update inventory.ini