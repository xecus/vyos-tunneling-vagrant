# -*- mode: ruby -*-
# vi: set ft=ruby :

# ネットワーク設定を定義
NETWORKS = {
  expnet_wan: {
    name: "expnet_wan",
    dhcp_enabled: false,
    forward_mode: "none",
    #host_ip: "172.16.0.253"
  },
  expnet_subnet_a: {
    name: "expnet_subnet_a",
    dhcp_enabled: false,
    forward_mode: "none",
    #host_ip: "192.168.10.253"
  },
  expnet_subnet_b: {
    name: "expnet_subnet_b",
    dhcp_enabled: false,
    forward_mode: "none",
    #host_ip: "192.168.20.254"
  },
}.freeze

LIBVIRT_CONFIG = {
  memory: 1024,
  cpus: 1,
  driver: "kvm",
  uri: 'qemu:///system',
  graphics_type: "vnc",
  graphics_ip: "0.0.0.0",
  video_type: "cirrus"
}.freeze

VIRTUALBOX_CONFIG = {
  memory: 1024,
  cpus: 1
}.freeze

# VM設定を配列で定義
MACHINES = [
  {
    name: :exp_vyos,
    box: "vyos/current",
    hostname: "vyos1",
    networks: [:expnet_wan]
  },
  {
    name: :exp_vyos_a,
    box: "vyos/current",
    hostname: "vyos2",
    networks: [:expnet_wan, :expnet_subnet_a]
  },
  {
    name: :exp_vyos_b,
    box: "vyos/current",
    hostname: "vyos3",
    networks: [:expnet_wan, :expnet_subnet_b]
  },
  {
    name: :exp_ubuntu_a,
    box: "cloud-image/ubuntu-24.04",
    hostname: "ubuntu1",
    networks: [:expnet_subnet_a]
  },
  {
    name: :exp_ubuntu_b,
    box: "cloud-image/ubuntu-24.04",
    hostname: "ubuntu2",
    networks: [:expnet_subnet_b]
  },
].freeze

Vagrant.configure("2") do |config|
  # 共通設定
  config.vm.guest = :linux

  # 各マシンの設定
  MACHINES.each do |machine|
    config.vm.define machine[:name] do |vm_config|
      vm_config.vm.box = machine[:box]
      vm_config.vm.hostname = machine[:hostname]

      # ネットワーク設定（プロバイダー別）
      networks = machine[:networks] || [machine[:network]]

      # プロバイダーごとの設定
      vm_config.vm.provider :libvirt do |libvirt, override|
        networks.each do |net|
          network = NETWORKS[net]
          override.vm.network :private_network,
            #ip: machine[:ip],
            libvirt__network_name: network[:name],
            libvirt__dhcp_enabled: network[:dhcp_enabled],
            libvirt__forward_mode: network[:forward_mode]
            #libvirt__host_ip: network[:host_ip]
        end
      end

      vm_config.vm.provider :virtualbox do |vb, override|
        networks.each do |net|
          override.vm.network :private_network, ip: machine[:ip]
        end
      end
    end
  end

  # libvirtプロバイダー設定
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = LIBVIRT_CONFIG[:memory]
    libvirt.cpus = LIBVIRT_CONFIG[:cpus]
    libvirt.driver = LIBVIRT_CONFIG[:driver]
    libvirt.uri = LIBVIRT_CONFIG[:uri]
    libvirt.graphics_type = LIBVIRT_CONFIG[:graphics_type]
    libvirt.graphics_ip = LIBVIRT_CONFIG[:graphics_ip]
    libvirt.video_type = LIBVIRT_CONFIG[:video_type]
  end

  # VirtualBoxプロバイダー設定
  config.vm.provider :virtualbox do |vb|
    vb.memory = VIRTUALBOX_CONFIG[:memory]
    vb.cpus = VIRTUALBOX_CONFIG[:cpus]
  end
end
