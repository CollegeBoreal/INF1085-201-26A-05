# 300151609 
# Adding NVMe Storage to Proxmox VE

## Objective

The goal of this project was to add an NVMe drive to a Proxmox VE server, configure it as LVM-thin storage, and move a virtual machine disk onto it.



## Step 1: Connect to the server and identify the disks

I connected to the Proxmox server using SSH and ran:

```bash
lsblk
```

This command lists the disks and partitions available on the server.

The output showed:

- **`/dev/sda`**: the existing system disk, approximately 273.4 GiB.
- **`/dev/nvme0n1`**: the NVMe disk, approximately 953.9 GiB, which I planned to use for additional storage.

