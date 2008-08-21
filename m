From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 10:29:21 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.SOC.4.64.0808211324470.17855@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> But please turn this thing off and see if that clears everything
> up.

Well, it cleared the strange hang up and got to USB problem again.
Now I can see the looping in usb startup. Note that there really is a=20
'getting stuck' mesasage somewhere down in the messages.

PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.18 2002/05/23 18:22'
PROMLIB: Root node compatible: sun4u
Linux version 2.6.27-rc3-00661-g82d63fc-dirty (mroos@janku) (gcc version 4.=
3.1 (Debian 4.3.1-8) ) #39 Thu Aug 21 13:15:08 EEST 2008
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:11:b3:71
Kernel: Using 4 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/isa@7/serial@0,3f8
PROM: Built device tree with 46357 bytes of memory.
Top of RAM: 0x6fec6000, Total RAM: 0x3fe42000
Memory hole size: 768MB
[0000000200000000-fffff80000400000] page_structs=131072 node=3D0 entry=3D0/0
[0000000200000000-fffff80000800000] page_structs=131072 node=3D0 entry=3D1/0
[0000000200700000-fffff80000c00000] page_structs=131072 node=3D0 entry=3D2/0
[0000000200700000-fffff80001000000] page_structs=131072 node=3D0 entry=3D3/0
Allocated 1056768 bytes for kernel page tables.
Zone PFN ranges:
  Normal   0x00000000 -> 0x00037f63
Movable zone start PFN for each node
early_node_map[7] active PFN ranges
    0: 0x00000000 -> 0x00008000
    0: 0x00010000 -> 0x00018000
    0: 0x00020000 -> 0x00028000
    0: 0x00030000 -> 0x000377ff
    0: 0x00037800 -> 0x00037f00
    0: 0x00037f40 -> 0x00037f5f
    0: 0x00037f60 -> 0x00037f63
On node 0 totalpages: 130849
  Normal zone: 129282 pages, LIFO batch:15
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129282
Kernel command line: ro root=3D/dev/sda2 debug initcall_debug
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[b40001] shift[16]
clockevent: mult[16c16bf] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.18 2002/05/23 18:22'
PROMLIB: Root node compatible: sun4u
Linux version 2.6.27-rc3-00661-g82d63fc-dirty (mroos@janku) (gcc version 4.=
3.1 (Debian 4.3.1-8) ) #39 Thu Aug 21 13:15:08 EEST 2008
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:11:b3:71
Kernel: Using 4 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/isa@7/serial@0,3f8
PROM: Built device tree with 46357 bytes of memory.
Top of RAM: 0x6fec6000, Total RAM: 0x3fe42000
Memory hole size: 768MB
[0000000200000000-fffff80000400000] page_structs=131072 node=3D0 entry=3D0/0
[0000000200000000-fffff80000800000] page_structs=131072 node=3D0 entry=3D1/0
[0000000200700000-fffff80000c00000] page_structs=131072 node=3D0 entry=3D2/0
[0000000200700000-fffff80001000000] page_structs=131072 node=3D0 entry=3D3/0
Allocated 1056768 bytes for kernel page tables.
Zone PFN ranges:
  Normal   0x00000000 -> 0x00037f63
Movable zone start PFN for each node
early_node_map[7] active PFN ranges
    0: 0x00000000 -> 0x00008000
    0: 0x00010000 -> 0x00018000
    0: 0x00020000 -> 0x00028000
    0: 0x00030000 -> 0x000377ff
    0: 0x00037800 -> 0x00037f00
    0: 0x00037f40 -> 0x00037f5f
    0: 0x00037f60 -> 0x00037f63
On node 0 totalpages: 130849
  Normal zone: 129282 pages, LIFO batch:15
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129282
Kernel command line: ro root=3D/dev/sda2 debug initcall_debug
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[b40001] shift[16]
clockevent: mult[16c16bf] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:           4096
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 4095 kB
 per task-struct memory footprint: 2688 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A =3D> hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A =3D> hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1013304k available (2776k kernel code, 1288k data, 144k init) [ffff=
f80000000000,000000006fec6000]
SLUB: Genslabs=13, HWalign2, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=
=3D1
Calibrating delay using timer specific routine.. 11.18 BogoMIPS (lpjU921)
Mount-cache hash table entries: 512
calling  spawn_ksoftirqd+0x8/0x64
initcall spawn_ksoftirqd+0x8/0x64 returned 0 after 9 msecs
calling  spawn_softlockup_task+0x8/0x8c
initcall spawn_softlockup_task+0x8/0x8c returned 0 after 0 msecs
calling  relay_init+0x8/0x1c
initcall relay_init+0x8/0x1c returned 0 after 0 msecs
khelper used greatest stack depth: 11056 bytes left
calling  net_ns_init+0x8/0x1e0
net_namespace: 1592 bytes
initcall net_ns_init+0x8/0x1e0 returned 0 after 0 msecs
calling  sparc_globreg_init+0x8/0xc0
initcall sparc_globreg_init+0x8/0xc0 returned 0 after 0 msecs
calling  sysctl_init+0x8/0x38
initcall sysctl_init+0x8/0x38 returned 0 after 9 msecs
calling  ksysfs_init+0x8/0xc0
initcall ksysfs_init+0x8/0xc0 returned 0 after 0 msecs
calling  init_jiffies_clocksource+0x8/0x28
initcall init_jiffies_clocksource+0x8/0x28 returned 0 after 0 msecs
calling  filelock_init+0x8/0x44
initcall filelock_init+0x8/0x44 returned 0 after 0 msecs
calling  init_script_binfmt+0x8/0x28
initcall init_script_binfmt+0x8/0x28 returned 0 after 0 msecs
calling  init_elf_binfmt+0x8/0x28
initcall init_elf_binfmt+0x8/0x28 returned 0 after 0 msecs
calling  init_compat_elf_binfmt+0x8/0x28
initcall init_compat_elf_binfmt+0x8/0x28 returned 0 after 0 msecs
calling  debugfs_init+0x8/0x5c
initcall debugfs_init+0x8/0x5c returned 0 after 0 msecs
calling  random32_init+0x8/0xbc
initcall random32_init+0x8/0xbc returned 0 after 0 msecs
calling  sock_init+0x8/0x78
initcall sock_init+0x8/0x78 returned 0 after 0 msecs
calling  netpoll_init+0x8/0x4c
initcall netpoll_init+0x8/0x4c returned 0 after 0 msecs
calling  netlink_proto_init+0x8/0x278
NET: Registered protocol family 16
initcall netlink_proto_init+0x8/0x278 returned 0 after 0 msecs
calling  of_bus_driver_init+0x8/0xa0
khelper used greatest stack depth: 10480 bytes left
initcall of_bus_driver_init+0x8/0xa0 returned 0 after 85 msecs
calling  bdi_class_init+0x8/0x60
initcall bdi_class_init+0x8/0x60 returned 0 after 0 msecs
calling  kobject_uevent_init+0x8/0x60
initcall kobject_uevent_init+0x8/0x60 returned 0 after 0 msecs
calling  pcibus_class_init+0x8/0x30
initcall pcibus_class_init+0x8/0x30 returned 0 after 9 msecs
calling  pci_driver_init+0x8/0x28
initcall pci_driver_init+0x8/0x28 returned 0 after 0 msecs
calling  tty_class_init+0x8/0x44
initcall tty_class_init+0x8/0x44 returned 0 after 0 msecs
calling  vtconsole_class_init+0x8/0xf4
initcall vtconsole_class_init+0x8/0xf4 returned 0 after 0 msecs
calling  topology_init+0x8/0x68
initcall topology_init+0x8/0x68 returned 0 after 9 msecs
calling  pcibios_init+0x8/0x138
PCI: Probing for controllers.
/pci@1f,0: SABRE PCI Bus Module
/pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
PCI: Scanning PBM /pci@1f,0
pci 0000:00:03.0: quirk: region 2000-203f claimed by ali7101 ACPI
pci 0000:00:03.0: quirk: region 4000-401f claimed by ali7101 SMB
pci 0000:00:0c.0: PME# supported from D3hot D3cold
pci 0000:00:0c.0: PME# disabled
pci 0000:00:05.0: PME# supported from D3hot D3cold
pci 0000:00:05.0: PME# disabled
ebus: No EBus's found.
power: Control reg at 1fe02002000
initcall pcibios_init+0x8/0x138 returned 0 after 19 msecs
calling  param_sysfs_init+0x8/0x1dc
initcall param_sysfs_init+0x8/0x1dc returned 0 after 19 msecs
calling  readahead_init+0x8/0x40
initcall readahead_init+0x8/0x40 returned 0 after 9 msecs
calling  init_bio+0x8/0xd8
initcall init_bio+0x8/0xd8 returned 0 after 0 msecs
calling  blk_settings_init+0x8/0x44
initcall blk_settings_init+0x8/0x44 returned 0 after 0 msecs
calling  blk_ioc_init+0x8/0x40
initcall blk_ioc_init+0x8/0x40 returned 0 after 0 msecs
calling  genhd_device_init+0x8/0x78
initcall genhd_device_init+0x8/0x78 returned 0 after 0 msecs
calling  pci_slot_init+0x8/0x60
initcall pci_slot_init+0x8/0x60 returned 0 after 0 msecs
calling  misc_init+0x8/0xb0
initcall misc_init+0x8/0xb0 returned 0 after 0 msecs
calling  cn_init+0x8/0xf0
initcall cn_init+0x8/0xf0 returned 0 after 0 msecs
calling  init_scsi+0x8/0xc8
SCSI subsystem initialized
initcall init_scsi+0x8/0xc8 returned 0 after 9 msecs
calling  ata_init+0x8/0x38c
libata version 3.00 loaded.
initcall ata_init+0x8/0x38c returned 0 after 0 msecs
calling  sbus_init+0x8/0x2d4
initcall sbus_init+0x8/0x2d4 returned 0 after 0 msecs
calling  input_init+0x8/0x118
initcall input_init+0x8/0x118 returned 0 after 0 msecs
calling  proto_init+0x8/0x40
initcall proto_init+0x8/0x40 returned 0 after 0 msecs
calling  net_dev_init+0x8/0x170
initcall net_dev_init+0x8/0x170 returned 0 after 0 msecs
calling  neigh_init+0x8/0x94
initcall neigh_init+0x8/0x94 returned 0 after 0 msecs
calling  fib_rules_init+0x8/0xc4
initcall fib_rules_init+0x8/0xc4 returned 0 after 0 msecs
calling  pktsched_init+0x8/0xe0
initcall pktsched_init+0x8/0xe0 returned 0 after 0 msecs
calling  tc_filter_init+0x8/0x60
initcall tc_filter_init+0x8/0x60 returned 0 after 0 msecs
calling  tc_action_init+0x8/0x60
initcall tc_action_init+0x8/0x60 returned 0 after 0 msecs
calling  genl_init+0x8/0xf0
initcall genl_init+0x8/0xf0 returned 0 after 38 msecs
calling  wireless_nlevent_init+0x8/0x4c
initcall wireless_nlevent_init+0x8/0x4c returned 0 after 0 msecs
calling  sysctl_init+0x8/0x58
initcall sysctl_init+0x8/0x58 returned 0 after 0 msecs
calling  auxio_init+0x8/0x30
initcall auxio_init+0x8/0x30 returned 0 after 0 msecs
calling  clock_init+0x8/0xd8
/pci@1f,0/isa@7/rtc@0,70: Clock regs at 000001fe02000070
initcall clock_init+0x8/0xd8 returned 0 after 17592186043462 msecs
calling  clocksource_done_booting+0x8/0x28
initcall clocksource_done_booting+0x8/0x28 returned 0 after 0 msecs
calling  tracer_alloc_buffers+0x8/0x4b4
Switched to high resolution mode on CPU 0
tracer: 643 pages allocated for 65536 entries of 80 bytes
   actual entries 65586
initcall tracer_alloc_buffers+0x8/0x4b4 returned 0 after 13 msecs
calling  init_pipe_fs+0x8/0x60
initcall init_pipe_fs+0x8/0x60 returned 0 after 0 msecs
calling  init_mnt_writers+0x8/0x58
initcall init_mnt_writers+0x8/0x58 returned 0 after 0 msecs
calling  eventpoll_init+0x8/0xa8
initcall eventpoll_init+0x8/0xa8 returned 0 after 0 msecs
calling  anon_inode_init+0x8/0xfc
initcall anon_inode_init+0x8/0xfc returned 0 after 0 msecs
calling  chr_dev_init+0x8/0xcc
initcall chr_dev_init+0x8/0xcc returned 0 after 16 msecs
calling  firmware_class_init+0x8/0x8c
initcall firmware_class_init+0x8/0x8c returned 0 after 1 msecs
calling  loopback_init+0x8/0x28
initcall loopback_init+0x8/0x28 returned 0 after 3 msecs
calling  inet_init+0x8/0x2c4
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 8, 2097152 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
initcall inet_init+0x8/0x2c4 returned 0 after 1071 msecs
calling  af_unix_init+0x8/0x64
NET: Registered protocol family 1
initcall af_unix_init+0x8/0x64 returned 0 after 0 msecs
calling  default_rootfs+0x8/0x84
initcall default_rootfs+0x8/0x84 returned 0 after 0 msecs
calling  rtc_mini_init+0x8/0xe4
Mini RTC Driver
initcall rtc_mini_init+0x8/0xe4 returned 0 after 2 msecs
calling  chmc_init+0x8/0xa8
initcall chmc_init+0x8/0xa8 returned -19 after 0 msecs
calling  mdesc_misc_init+0x8/0x28
initcall mdesc_misc_init+0x8/0x28 returned 0 after 1 msecs
calling  ioresources_init+0x8/0x5c
initcall ioresources_init+0x8/0x5c returned 0 after 0 msecs
calling  uid_cache_init+0x8/0xa0
initcall uid_cache_init+0x8/0xa0 returned 0 after 0 msecs
calling  init_posix_timers+0x8/0xcc
initcall init_posix_timers+0x8/0xcc returned 0 after 0 msecs
calling  init_posix_cpu_timers+0x8/0xdc
initcall init_posix_cpu_timers+0x8/0xdc returned 0 after 0 msecs
calling  nsproxy_cache_init+0x8/0x40
initcall nsproxy_cache_init+0x8/0x40 returned 0 after 0 msecs
calling  create_proc_profile+0x8/0x64
initcall create_proc_profile+0x8/0x64 returned 0 after 0 msecs
calling  timekeeping_init_device+0x8/0x40
initcall timekeeping_init_device+0x8/0x40 returned 0 after 2 msecs
calling  init_clocksource_sysfs+0x8/0x78
initcall init_clocksource_sysfs+0x8/0x78 returned 0 after 2 msecs
calling  init_timer_list_procfs+0x8/0x40
initcall init_timer_list_procfs+0x8/0x40 returned 0 after 0 msecs
calling  lockdep_proc_init+0x8/0x9c
initcall lockdep_proc_init+0x8/0x9c returned 0 after 0 msecs
calling  futex_init+0x8/0xb8
initcall futex_init+0x8/0xb8 returned 0 after 0 msecs
calling  init_rttest+0x8/0x1a0
Initializing RT-Tester: OK
initcall init_rttest+0x8/0x1a0 returned 0 after 20 msecs
calling  kallsyms_init+0x8/0x3c
initcall kallsyms_init+0x8/0x3c returned 0 after 0 msecs
calling  backtrace_regression_test+0x8/0x100
=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3DTesting a backtrace from process =
context.
The following trace is a kernel self test and not a bug!
Call Trace:
 [000000000048ccb8] backtrace_regression_test+0x38/0x100
 [0000000000426c28] do_one_initcall+0x28/0x180
 [0000000000806228] kernel_init+0xa8/0x108
 [000000000042723c] kernel_thread+0x3c/0x60
 [00000000006acf7c] rest_init+0x1c/0x80
Testing a backtrace from irq context.
The following trace is a kernel self test and not a bug!
Call Trace:
 [000000000048cc50] backtrace_test_irq_callback+0x10/0x40
 [000000000045bd54] tasklet_action+0x74/0x100
 [000000000045c55c] __do_softirq+0x7c/0x120
 [000000000042e520] do_softirq+0xa0/0xc0
 [000000000045b8e8] ksoftirqd+0x68/0x120
 [000000000046e36c] kthread+0x4c/0x80
 [000000000042723c] kernel_thread+0x3c/0x60
 [000000000046e2a8] kthreadd+0x168/0x1e0
Testing a saved backtrace.
The following trace is a kernel self test and not a bug!
 [<0000000000426c28>] do_one_initcall+0x28/0x180
 [<0000000000806228>] kernel_init+0xa8/0x108
 [<000000000042723c>] kernel_thread+0x3c/0x60
 [<00000000006acf7c>] rest_init+0x1c/0x80
=3D=3D[ end of backtrace testing ]=3D=3D
initcall backtrace_regression_test+0x8/0x100 returned 0 after 1 msecs
calling  ikconfig_init+0x8/0x54
initcall ikconfig_init+0x8/0x54 returned 0 after 0 msecs
calling  init_kprobes+0x8/0x14c
Kprobe smoke test started
Kprobe smoke test passed successfully
initcall init_kprobes+0x8/0x14c returned 0 after 105 msecs
calling  utsname_sysctl_init+0x8/0x28
initcall utsname_sysctl_init+0x8/0x28 returned 0 after 0 msecs
calling  init_sched_switch_trace+0x8/0x60
initcall init_sched_switch_trace+0x8/0x60 returned 0 after 0 msecs
calling  init_irqsoff_tracer+0x8/0x28
initcall init_irqsoff_tracer+0x8/0x28 returned 0 after 0 msecs
calling  init_wakeup_tracer+0x8/0x28
initcall init_wakeup_tracer+0x8/0x28 returned 0 after 0 msecs
calling  init_per_zone_pages_min+0x8/0x6c
initcall init_per_zone_pages_min+0x8/0x6c returned 0 after 0 msecs
calling  pdflush_init+0x8/0x2c
initcall pdflush_init+0x8/0x2c returned 0 after 1 msecs
calling  kswapd_init+0x8/0x2c
initcall kswapd_init+0x8/0x2c returned 0 after 0 msecs
calling  mm_sysfs_init+0x8/0x3c
initcall mm_sysfs_init+0x8/0x3c returned 0 after 0 msecs
calling  procswaps_init+0x8/0x3c
initcall procswaps_init+0x8/0x3c returned 0 after 0 msecs
calling  init_tmpfs+0x8/0x140
initcall init_tmpfs+0x8/0x140 returned 0 after 0 msecs
calling  slab_sysfs_init+0x8/0x134
khelper used greatest stack depth: 9464 bytes left
initcall slab_sysfs_init+0x8/0x134 returned 0 after 246 msecs
calling  fasync_init+0x8/0x40
initcall fasync_init+0x8/0x40 returned 0 after 2 msecs
calling  aio_setup+0x8/0x8c
initcall aio_setup+0x8/0x8c returned 0 after 7 msecs
calling  inotify_setup+0x8/0x24
initcall inotify_setup+0x8/0x24 returned 0 after 0 msecs
calling  inotify_user_setup+0x8/0xdc
initcall inotify_user_setup+0x8/0xdc returned 0 after 6 msecs
calling  init_sys32_ioctl+0x8/0xa0
initcall init_sys32_ioctl+0x8/0xa0 returned 0 after 0 msecs
calling  init_mbcache+0x8/0x28
initcall init_mbcache+0x8/0x28 returned 0 after 0 msecs
calling  dquot_init+0x8/0x130
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
initcall dquot_init+0x8/0x130 returned 0 after 4 msecs
calling  init_v1_quota_format+0x8/0x28
initcall init_v1_quota_format+0x8/0x28 returned 0 after 0 msecs
calling  init_v2_quota_format+0x8/0x28
initcall init_v2_quota_format+0x8/0x28 returned 0 after 0 msecs
calling  dnotify_init+0x8/0x40
initcall dnotify_init+0x8/0x40 returned 0 after 2 msecs
calling  init_devpts_fs+0x8/0x48
initcall init_devpts_fs+0x8/0x48 returned 0 after 0 msecs
calling  init_ext3_fs+0x8/0x8c
initcall init_ext3_fs+0x8/0x8c returned 0 after 5 msecs
calling  journal_init+0x8/0xd8
initcall journal_init+0x8/0xd8 returned 0 after 11 msecs
calling  init_ramfs_fs+0x8/0x28
initcall init_ramfs_fs+0x8/0x28 returned 0 after 0 msecs
calling  ipc_init+0x8/0x40
msgmni has been set to 1980
initcall ipc_init+0x8/0x40 returned 0 after 0 msecs
calling  ipc_sysctl_init+0x8/0x28
initcall ipc_sysctl_init+0x8/0x28 returned 0 after 0 msecs
calling  init_mqueue_fs+0x8/0xec
initcall init_mqueue_fs+0x8/0xec returned 0 after 3 msecs
calling  key_proc_init+0x8/0x80
initcall key_proc_init+0x8/0x80 returned 0 after 0 msecs
calling  crypto_algapi_init+0x8/0x24
initcall crypto_algapi_init+0x8/0x24 returned 0 after 0 msecs
calling  cryptomgr_init+0x8/0x28
initcall cryptomgr_init+0x8/0x28 returned 0 after 0 msecs
calling  hmac_module_init+0x8/0x28
initcall hmac_module_init+0x8/0x28 returned 0 after 0 msecs
calling  md5_mod_init+0x8/0x28
initcall md5_mod_init+0x8/0x28 returned 0 after 0 msecs
calling  bsg_init+0x8/0x14c
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
initcall bsg_init+0x8/0x14c returned 0 after 4 msecs
calling  noop_init+0x8/0x28
io scheduler noop registered
initcall noop_init+0x8/0x28 returned 0 after 0 msecs
calling  as_init+0x8/0x28
io scheduler anticipatory registered
initcall as_init+0x8/0x28 returned 0 after 0 msecs
calling  deadline_init+0x8/0x28
io scheduler deadline registered
initcall deadline_init+0x8/0x28 returned 0 after 0 msecs
calling  cfq_init+0x8/0xbc
io scheduler cfq registered (default)
initcall cfq_init+0x8/0xbc returned 0 after 5 msecs
calling  debug_objects_init_debugfs+0x8/0x84
initcall debug_objects_init_debugfs+0x8/0x84 returned 0 after 0 msecs
calling  pci_init+0x8/0x50
pci 0000:00:07.0: Activating ISA DMA hang workarounds
initcall pci_init+0x8/0x50 returned 0 after 0 msecs
calling  pci_proc_init+0x8/0x90
initcall pci_proc_init+0x8/0x90 returned 0 after 1 msecs
calling  rand_initialize+0x8/0x40
initcall rand_initialize+0x8/0x40 returned 0 after 0 msecs
calling  tty_init+0x8/0x1f4
initcall tty_init+0x8/0x1f4 returned 0 after 127 msecs
calling  pty_init+0x8/0x1f8
initcall pty_init+0x8/0x1f8 returned 0 after 0 msecs
calling  cn_proc_init+0x8/0x50
initcall cn_proc_init+0x8/0x50 returned 0 after 0 msecs
calling  suncore_init+0x8/0x1c
initcall suncore_init+0x8/0x1c returned 0 after 0 msecs
calling  sunsu_init+0x8/0x184
f0076e0c: ttyS0 at MMIO 0x1fe020003f8 (irq =3D 7) is a 16550A
Console: ttyS0 (SU)
console [ttyS0] enabled
f0078af8: ttyS1 at MMIO 0x1fe020002e8 (irq =3D 7) is a 16550A
initcall sunsu_init+0x8/0x184 returned 0 after 24682 msecs
calling  sunsab_init+0x8/0x114
initcall sunsab_init+0x8/0x114 returned 0 after 3 msecs
calling  loop_init+0x8/0x224
loop: module loaded
initcall loop_init+0x8/0x224 returned 0 after 57 msecs
calling  net_olddevs_init+0x8/0x104
initcall net_olddevs_init+0x8/0x104 returned 0 after 0 msecs
calling  init_netconsole+0x8/0x20c
console [netcon0] enabled
netconsole: network logging started
initcall init_netconsole+0x8/0x20c returned 0 after 69 msecs
calling  init_sd+0x8/0xd8
Driver 'sd' needs updating - please use bus_type methods
initcall init_sd+0x8/0xd8 returned 0 after 66 msecs
calling  uli_init+0x8/0x34
initcall uli_init+0x8/0x34 returned 0 after 1 msecs
calling  ali_init+0x8/0x34
PCI: Enabling device: (0000:00:0d.0), cmd 5
scsi0 : pata_ali
scsi1 : pata_ali
ata1: PATA max UDMA/66 cmd 0x1fe02010200 ctl 0x1fe02010218 bmdma 0x1fe02010=
220 irq 12
ata2: PATA max UDMA/66 cmd 0x1fe02010210 ctl 0x1fe02010208 bmdma 0x1fe02010=
228 irq 12
ata2.00: ATA-6: ST3120026A, 3.06, max UDMA/100
ata2.00: 234441648 sectors, multi 0: LBA48=20
ata2.01: ATAPI: CD-224E, 1.7A, max UDMA/33
ata2.01: WARNING: ATAPI DMA disabled for reliablity issues.  It can be enab=
led
ata2.01: WARNING: via pata_ali.atapi_dma modparam or corresponding sysfs no=
de.
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
scsi 1:0:0:0: Direct-Access     ATA      ST3120026A       3.06 PQ: 0 ANSI: 5
sd 1:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 1:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sda: sda1 sda2 sda3 sda4 sda5
sd 1:0:0:0: [sda] Attached SCSI disk
scsi 1:0:1:0: CD-ROM            TEAC     CD-224E          1.7A PQ: 0 ANSI: 5
initcall ali_init+0x8/0x34 returned 0 after 2102 msecs
calling  mousedev_init+0x8/0x74
mice: PS/2 mouse device common for all mice
initcall mousedev_init+0x8/0x74 returned 0 after 51 msecs
calling  sysctl_core_init+0x8/0x3c
initcall sysctl_core_init+0x8/0x3c returned 0 after 1 msecs
calling  flow_cache_init+0x8/0x158
initcall flow_cache_init+0x8/0x158 returned 0 after 2 msecs
calling  blackhole_module_init+0x8/0x28
initcall blackhole_module_init+0x8/0x28 returned 0 after 0 msecs
calling  sysctl_ipv4_init+0x8/0x64
initcall sysctl_ipv4_init+0x8/0x64 returned 0 after 7 msecs
calling  init_syncookies+0x8/0x2c
initcall init_syncookies+0x8/0x2c returned 0 after 0 msecs
calling  ipv4_netfilter_init+0x8/0x40
initcall ipv4_netfilter_init+0x8/0x40 returned 0 after 0 msecs
calling  inet_diag_init+0x8/0x84
initcall inet_diag_init+0x8/0x84 returned 0 after 0 msecs
calling  tcp_diag_init+0x8/0x28
initcall tcp_diag_init+0x8/0x28 returned 0 after 0 msecs
calling  cubictcp_register+0x8/0xa0
TCP cubic registered
initcall cubictcp_register+0x8/0xa0 returned 0 after 24 msecs
calling  packet_init+0x8/0x54
NET: Registered protocol family 17
initcall packet_init+0x8/0x54 returned 0 after 39 msecs
calling  init_oops_id+0x8/0x40
initcall init_oops_id+0x8/0x40 returned 0 after 0 msecs
calling  disable_boot_consoles+0x8/0x64
initcall disable_boot_consoles+0x8/0x64 returned 0 after 0 msecs
calling  pm_qos_power_init+0x8/0xd8
initcall pm_qos_power_init+0x8/0xd8 returned 0 after 5 msecs
calling  debugfs_kprobe_init+0x8/0xa0
initcall debugfs_kprobe_init+0x8/0xa0 returned 0 after 0 msecs
calling  taskstats_init+0x8/0xa4
registered taskstats version 1
initcall taskstats_init+0x8/0xa4 returned 0 after 35 msecs
calling  random32_reseed+0x8/0x6c
initcall random32_reseed+0x8/0x6c returned 0 after 0 msecs
calling  pci_sysfs_init+0x8/0x74
initcall pci_sysfs_init+0x8/0x74 returned 0 after 1 msecs
calling  seqgen_init+0x8/0x24
initcall seqgen_init+0x8/0x24 returned 0 after 0 msecs
calling  scsi_complete_async_scans+0x8/0x100
initcall scsi_complete_async_scans+0x8/0x100 returned 0 after 0 msecs
calling  tcp_congestion_default+0x8/0x28
initcall tcp_congestion_default+0x8/0x28 returned 0 after 0 msecs
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mount failed for selinuxfs on /selinux:  No such file or directory
INIT: version 2.86 booting
stty used greatest stack depth: 7168 bytes left
sed used greatest stack depth: 6848 bytes left
mount used greatest stack depth: 6064 bytes left
create_static_n used greatest stack depth: 256 bytes left
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...calling  tulip_init+0x8/0x6c [tul=
ip]
Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
tulip0: Old style EEPROM with no media selection information.
tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
eth0: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00000000, EEPROM not prese=
nt, 00:03:ba:11:b3:71, IRQ 9.
tulip1: Old style EEPROM with no media selection information.
tulip1:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
eth1: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00002000, EEPROM not prese=
nt, 00:03:ba:11:b3:72, IRQ 10.
initcall tulip_init+0x8/0x6c [tulip] returned 0 after 613 msecs
calling  usb_init+0x8/0x140 [usbcore]
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
done.
Waiting for /dev to be fully populated...usbcore: registered new device dri=
ver usb
initcall usb_init+0x8/0x140 [usbcore] returned 0 after 759 msecs
calling  cdrom_init+0x8/0x84 [cdrom]
initcall cdrom_init+0x8/0x84 [cdrom] returned 0 after 0 msecs
calling  ohci_hcd_mod_init+0x8/0xb0 [ohci_hcd]
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 80 td 96
PCI: Enabling device: (0000:00:0a.0), cmd 2
ohci_hcd 0000:00:0a.0: OHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0a.0: created debug files
ohci_hcd 0000:00:0a.0: irq 11, io mem 0x1ff01000000
calling  init_sr+0x8/0x58 [sr_mod]
Driver 'sr' needs updating - please use bus_type methods
usb_hcd_poll_rh_status start
ohci_hcd 0000:00:0a.0: OHCI controller state
ohci_hcd 0000:00:0a.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:0a.0: control 0x083 HCFS=3Doperational CBSR=3D3
ohci_hcd 0000:00:0a.0: cmdstatus 0x00000 SOC=3D0
ohci_hcd 0000:00:0a.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:0a.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:0a.0: hcca frame #01a0
ohci_hcd 0000:00:0a.0: roothub.a 02000202 POTPGT=3D2 NPS NDP=3D2(2)
ohci_hcd 0000:00:0a.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:0a.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:0a.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:0a.0: roothub.portstatus [1] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 4ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: trying to enable port power on non-switchable hub
sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:1:0: Attached scsi CD-ROM sr0
initcall init_sr+0x8/0x58 [sr_mod] returned 0 after 1756 msecs
drivers/usb/core/inode.c: creating file '001'
usb usb1: New USB device found, idVendor=1D6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.27-rc3-00661-g82d63fc-dirty ohci_hcd
usb usb1: SerialNumber: 0000:00:0a.0
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
initcall ohci_hcd_mod_init+0x8/0xb0 [ohci_hcd] returned 0 after 3579 msecs
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
BUG: soft lockup - CPU#0 stuck for 61s! [khubd:493]
Modules linked in: sr_mod ohci_hcd cdrom usbcore tulip
irq event stamp: 3797
hardirqs last  enabled at (3796): [<000000000047e4f0>] trace_hardirqs_on+0x=
10/0x20
hardirqs last disabled at (3797): [<000000000047c5d0>] trace_hardirqs_off+0=
x10/0x20
softirqs last  enabled at (3780): [<000000000045c5b8>] __do_softirq+0xd8/0x=
120
softirqs last disabled at (3789): [<000000000042e520>] do_softirq+0xa0/0xc0
TSTATE: 0000000080009605 TPC: 0000000000456fec TNPC: 0000000000456ff0 Y: 00=
000000    Not tainted
TPC: <vprintk+0x1ec/0x4c0>
g0: 000000000000000f g1: 0000000000000000 g2: 00000000007b2698 g3: fffff800=
6caf7bc1
g4: fffff8006ca34480 g5: 0000000000000020 g6: fffff8006caf8000 g7: 00000000=
007e1350
o0: 00000000007b26e0 o1: 0000000000832ecc o2: 0000000000832ed0 o3: 00000000=
00832ec8
o4: 0000000000832ecc o5: 00000000007b26e0 sp: fffff8006feab241 ret_pc: 0000=
000000456fdc
RPC: <vprintk+0x1dc/0x4c0>
l0: 0000000000842fb8 l1: 0000000000842fe9 l2: 0000000000000001 l3: 00000000=
007b27d0
l4: fffff8006feabb08 l5: 0000000000832ea0 l6: 0000000000000006 l7: 00000000=
3b9aca00
i0: 0000000000000031 i1: fffff8006feabca8 i2: 00000000007b2400 i3: 00000000=
0075d310
i4: 00000000007b2400 i5: 0000000000000001 i6: fffff8006feab351 i7: 00000000=
006b30dc
I7: <printk+0x30/0x44>
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=20
usb_hcd_poll_rh_status before hub_status_data
ohci_hub_status_data before spin_lock_irqsave
ohci_hub_status_data after spin_lock_irqsave
ohci_hub_status_data return
usb_hcd_poll_rh_status after hub_status_data
usb_hcd_poll_rh_status start
usb_hcd_poll_rh_status: uses_new_polling
...
(and so on)

--=20
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
