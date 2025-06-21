# vyos-tunneling-vagrant


## 概要
- VyOSで構成されたルーター3台を用いてVXLAN over WireGuardトンネルを形成
- 遠隔地に離れた２つのサブネットを通信可能にする


## 動作環境

- Ubuntu 24.04
- libvirt x QEMU


## 使い方

- 注意：WireGuard内部の鍵は、Ansible適用前後に随時変更すること

```bash
vyos@vyos:~$ generate pki wireguard key-pair
Private key: kEbNrVMQukFL4cwRqu5fRLmAA1pWznRCmeXg+gDUXnk=
Public key: o2//uPTyw7OG9WJLhy/RiIzqWQMMhEt36be11I9+8BE=
```

- 事前準備

```bash
$ apt install ansible-core
$ ansible-galaxy collection install vyos.vyos
```

- 仮想NW及びVMの立ち上げ

```bash
$ vagrant up
```

- inventory.iniにIPアドレスを設定

```bash
$ ./get-vm-ips.sh
```

- VyOS 3台のプロビジョニング

```bash
$ ansible-playbook -i inventory.ini playbook-vyos.yml
$ ansible-playbook -i inventory.ini playbook-vyos-a.yml
$ ansible-playbook -i inventory.ini playbook-vyos-b.yml
```

- Ubuntu (VM)のプロビジョニング

```bash
$ ansible-playbook -i inventory.ini playbook-client.yml
```
