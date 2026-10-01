# 300151315
# Nested Proxmox VE VM on a Proxmox Host

This guide documents how to create a virtual machine running **Proxmox VE 9.2** inside an existing Proxmox VE host (nested virtualization), entirely from the command line over SSH.

## Overview

| Item | Value |
|---|---|
| Host | Proxmox VE (Debian-based), hostname `server56` |
| Guest OS | Proxmox VE 9.2 (`proxmox-ve_9.2-1.iso`) |
| VM ID | `100` |
| VM name | `ayoubVM` |
| Pool | `rahma` |
| CPU | 4 cores, type `host` |
| Memory | 8 GB |
| Disk | 64 GB on `local-lvm` |
| Network | VirtIO on bridge `vmbr0` |

## Prerequisites

- A running Proxmox VE host with root SSH access
- Internet access from the host (see [DNS fix](#2-fix-dns-if-needed) if names don't resolve)
- CPU virtualization enabled (Intel VT-x or AMD-V)
- Enough free resources: at least 8 GB RAM, 4 cores and 64 GB of storage

> **Note:** Proxmox is Linux, not Windows. Hyper-V PowerShell commands such as `New-VM` or `Install-WindowsFeature` do not exist on it. Use `qm` and `pvesm` instead.

## Steps

### 1. Connect to the host

From PowerShell (Windows) or any terminal:

```bash
ssh root@<SERVER_IP>
```

To find the host IP once connected:

```bash
hostname -I
```

The web interface is available at `https://<SERVER_IP>:8006` (login: `root`, realm: Linux PAM).

### 2. Fix DNS (if needed)

If `curl` returns `Could not resolve host`, test raw connectivity first:

```bash
ping -c 3 8.8.8.8
```

If the ping succeeds, only DNS is broken. Back up and replace the resolver config:

```bash
cp /etc/resolv.conf /etc/resolv.conf.bak
printf "nameserver 1.1.1.1\nnameserver 8.8.8.8\n" > /etc/resolv.conf
ping -c 3 enterprise.proxmox.com
```

The same setting can be made in the web interface under **Node → System → DNS**.

### 3. Download the Proxmox VE ISO

ISOs must be stored on the host in the `local` storage's ISO folder:

```bash
cd /var/lib/vz/template/iso/
```

List the available Proxmox ISOs:

```bash
curl -s https://enterprise.proxmox.com/iso/ | grep -o 'proxmox-ve_[^"]*\.iso' | sort -u
```

Download the latest x86_64 version (not the `arm64` build, and not the `.asc` signature):

```bash
curl -L -O https://enterprise.proxmox.com/iso/proxmox-ve_9.2-1.iso
```

Confirm Proxmox sees it:

```bash
pvesm list local --content iso
```

Expected: `local:iso/proxmox-ve_9.2-1.iso`

### 4. Check storage and the next free VM ID

```bash
pvesm status
pvesh get /cluster/nextid
```

### 5. Check nested virtualization

```bash
cat /sys/module/kvm_intel/parameters/nested 2>/dev/null || cat /sys/module/kvm_amd/parameters/nested
```

`Y` or `1` means nested virtualization is enabled.

### 6. Create a pool (folder)

Pools group VMs in the web interface (switch the left panel to **Pool View** to see them):

```bash
pvesh create /pools --poolid rahma
```

### 7. Create the VM

```bash
qm create 100 \
  --name ayoubVM \
  --pool rahma \
  --memory 8192 \
  --cores 4 \
  --cpu host \
  --ostype l26 \
  --scsihw virtio-scsi-single \
  --scsi0 local-lvm:64 \
  --ide2 local:iso/proxmox-ve_9.2-1.iso,media=cdrom \
  --net0 virtio,bridge=vmbr0 \
  --boot order='scsi0;ide2'
```

`--cpu host` passes the host CPU features through, which the nested Proxmox needs to run its own VMs.

### 8. Start the VM and install Proxmox

```bash
qm start 100
```

In the web interface, open **100 (ayoubVM) → Console** and run the installer:

1. Choose **Install Proxmox VE (Graphical)**.
2. Accept the license.
3. Keep the 64 GB target disk.
4. Set country, time zone and keyboard.
5. Set the root password and an email.
6. **Network:** assign a free static IP on the same subnet as the host, the same gateway, and `1.1.1.1` as DNS.
7. Click **Install**.

### 9. Remove the ISO after installation

```bash
qm set 100 --ide2 none,media=cdrom
```

The nested Proxmox is then reachable at `https://<VM_IP>:8006`.

## Useful commands

```bash
qm list                 # list all VMs
qm start 100            # start the VM
qm shutdown 100         # graceful shutdown
qm stop 100             # force stop
qm config 100           # show VM configuration
qm destroy 100          # delete the VM and its disks
```

## Troubleshooting

| Problem | Cause | Fix |
|---|---|---|
| `New-VM: command not found` | Hyper-V command run on Linux | Use `qm create` |
| `storage ID 'local:iso' contains illegal characters` | Wrong `pvesm list` syntax | `pvesm list local --content iso` |
| `pvesm list` shows only column headers | No ISO in that storage | Download or upload one to `/var/lib/vz/template/iso/` |
| `curl: (6) Could not resolve host` | DNS not configured | See [step 2](#2-fix-dns-if-needed) |
| Download stuck at 0 bytes | No DNS or no internet | Press `Ctrl + C`, then test with `ping` |
| `$'\r': command not found` | Windows line ending pasted into bash | Retype the command or paste it again cleanly |
