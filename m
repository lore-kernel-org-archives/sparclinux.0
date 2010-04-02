From: Frans van Berckel <fberckel@xs4all.nl>
Date: Fri, 02 Apr 2010 20:40:45 +0000
Subject: Kernel panic - not syncing: Irrecoverable deferred error trap
Message-Id: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-g+xCo2pJjDjn22N65dSq"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-g+xCo2pJjDjn22N65dSq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Booting a Sun Blade 2000 + XVR-1000, with a XVR-1200 installed into pci
as well, prints a kernel panic now. Attaching a full txt boot log.

[   84.993920] ERROR(0): Cheetah error trap taken afsr[0010100000000000]
afar[0000000000008080] TL1(0)
[   85.102492] ERROR(0): TPC[686af0] TNPC[686af4] O7[686aac]
TSTATE[4480001604]
[   85.186544] ERROR(0): TPC<e3d_pci_register+0x10c/0x404>
[   85.248417] ERROR(0): M_SYND(0),  E_SYND(0), Privileged
[   85.311262] ERROR(0): Highest priority error (0000100000000000)
"Unmapped error from system bus"
[   85.417033] ERROR(0): D-cache idx[0] tag[0000000000000000]
utag[0000000000000000] stag[0000000000000000]
[   85.530684] ERROR(0): D-cache data0[0000000000000000]
data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
[   85.666598] ERROR(0): I-cache idx[0] tag[0000000000000000]
utag[0000000000000000] stag[0000000000000000] u[0000000000000000]
l[0000000000000000]
[   85.822276] ERROR(0): I-cache INSN0[0000000000000000]
INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
[   85.957642] ERROR(0): I-cache INSN4[0000000000000000]
INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
[   86.093268] ERROR(0): E-cache idx[8080] tag[0000000000114524]
[   86.161350] ERROR(0): E-cache data0[0000000800000010]
data1[0000010000000000] data2[00000000006a0ed0] data3[0720072000000000]
[   86.297650] Kernel panic - not syncing: Irrecoverable deferred error
trap.
[   86.297655] 
[   86.396306] Press Stop-A (L1-A) to return to the boot prom

--=-g+xCo2pJjDjn22N65dSq
Content-Disposition: attachment; filename="xvr-1200-boot"
Content-Type: text/plain; name="xvr-1200-boot"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

CPU seeprom format: 0000.0000.0000.0002
Sun Blade 2000/1000 (UltraSPARC-III+) , No Keyboard
Copyright 1998-2002 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.5, 2048 MB memory installed, Serial #56329931.
Ethernet address 0:3:ba:5b:86:cb, Host ID: 835b86cb.

Initializing Memory
                                                                      
Initializing Memory
                                                                      
Initializing Memory
                                                                      
Boot device: disk  File and args: 
SILO Version 1.4.14
boot: 
Linux                    LinuxOLD                 LinuxSda2                
LinuxSda2OLD             LinuxSda2Serial          
boot: LinuxSda2Serial
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loading initial ramdisk (6820846 bytes at 0x7F000000 phys, 0x40C00000 virt)...
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.5.21 2003/02/24 17:23'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-2-sparc64 (Debian 2.6.26-21lenny4) (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Tue Mar 9 22:14:38 UTC 2010
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5b:86:cb
[    0.000000] Kernel: Using 1 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@8,700000/ebus@5/serial@1,400000:a
[    0.000000] PROM: Built device tree with 69704 bytes of memory.
[    0.000000] Top of RAM: 0x7fe7e000, Total RAM: 0x7fe68000
[    0.000000] Memory hole size: 0MB
[    0.000000] [0000000200000000-fffff80000800000] page_structs=131072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80000c00000] page_structs=131072 node=0 entry=1/0
[    0.000000] [0000000200700000-fffff80001000000] page_structs=131072 node=0 entry=2/0
[    0.000000] [0000000200700000-fffff80001400000] page_structs=131072 node=0 entry=3/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal          0 ->   261951
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0:        0 ->   260095
[    0.000000]     0:   260096 ->   261842
[    0.000000]     0:   261844 ->   261928
[    0.000000]     0:   261936 ->   261951
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260149
[    0.000000] Kernel command line: root=/dev/sda2 ro console=tty0 console=ttyS0,9600n8
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[c80000] shift[16]
[    0.000000] clockevent: mult[147ae14] shift[32]
[   77.747207] Console: colour dummy device 80x25
[   77.800298] console [tty0] enabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.5.21 2003/02/24 17:23'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-2-sparc64 (Debian 2.6.26-21lenny4) (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Tue Mar 9 22:14:38 UTC 2010
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5b:86:cb
[    0.000000] Kernel: Using 1 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@8,700000/ebus@5/serial@1,400000:a
[    0.000000] PROM: Built device tree with 69704 bytes of memory.
[    0.000000] Top of RAM: 0x7fe7e000, Total RAM: 0x7fe68000
[    0.000000] Memory hole size: 0MB
[    0.000000] [0000000200000000-fffff80000800000] page_structs=131072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80000c00000] page_structs=131072 node=0 entry=1/0
[    0.000000] [0000000200700000-fffff80001000000] page_structs=131072 node=0 entry=2/0
[    0.000000] [0000000200700000-fffff80001400000] page_structs=131072 node=0 entry=3/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal          0 ->   261951
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0:        0 ->   260095
[    0.000000]     0:   260096 ->   261842
[    0.000000]     0:   261844 ->   261928
[    0.000000]     0:   261936 ->   261951
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260149
[    0.000000] Kernel command line: root=/dev/sda2 ro console=tty0 console=ttyS0,9600n8
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[c80000] shift[16]
[    0.000000] clockevent: mult[147ae14] shift[32]
[   77.747207] Console: colour dummy device 80x25
[   77.800298] console [tty0] enabled
[   79.964564] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[   80.050811] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[   80.193735] Memory: 2064288k available (2592k kernel code, 944k data, 176k init) [fffff80000000000,000000007fe7e000]
[   80.397918] Calibrating delay using timer specific routine.. 9.98 BogoMIPS (lpj=19973)
[   80.491051] Security Framework initialized
[   80.539906] SELinux:  Disabled at boot.
[   80.585730] Capability LSM initialized
[   80.630548] Mount-cache hash table entries: 512
[   80.685093] Initializing cgroup subsys ns
[   80.732610] Initializing cgroup subsys cpuacct
[   80.785725] Initializing cgroup subsys devices
[   80.839556] net_namespace: 1208 bytes
[   80.883066] NET: Registered protocol family 16
[   80.944180] PCI: Probing for controllers.
[   80.990338] /pci@8,700000: SCHIZO PCI Bus Module ver[7:0]
[   81.054981] /pci@8,700000: PCI IO[7ffef000000] MEM[7fe00000000]
[   81.129970] /pci@8,600000: SCHIZO PCI Bus Module ver[7:0]
[   81.192821] /pci@8,600000: PCI IO[7ffed000000] MEM[7fd00000000]
[   81.267773] PCI: Scanning PBM /pci@8,600000
[   81.316467] PCI: Scanning PBM /pci@8,700000
[   81.367307] ebus0: [flashprom] [bbc] [ppm] [i2c -> (dimm-fru) (dimm-fru) (dimm-fru) (dimm-fru) (nvram) (idprom)] [i2c -> (cpu-fru) (temperature) (fan-control) (card-reader) (motherboard-fru) (i2c-bridge)] [beep] [audio] [rtc] [gpio] [pmc] [floppy] [parallel] [serial]
[   81.652250] usbcore: registered new interface driver usbfs
[   81.716330] usbcore: registered new interface driver hub
[   81.779847] usbcore: registered new device driver usb
[   81.852269] /pci@8,700000/ebus@5/rtc@1,300070: Clock regs at 000007fe7e300070
[   81.937084] NET: Registered protocol family 2
[   82.024150] IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
[   82.109021] TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
[   82.209785] TCP bind hash table entries: 65536 (order: 6, 524288 bytes)
[   82.288905] TCP: Hash tables configured (established 262144 bind 65536)
[   82.366578] TCP reno registered
[   82.416181] NET: Registered protocol family 1
[   82.466786] checking if image is initramfs... it is
[   83.817848] Freeing initrd memory: 6660k freed
[   83.869847] Mini RTC Driver
[   83.902793] /memory-controller@0,400000: US3 memory controller at 0000040000400000 [ACTIVE]
[   84.003201] audit: initializing netlink socket (disabled)
[   84.067151] type=2000 audit(1270239635.655:1): initialized
[   84.133198] Total HugeTLB memory allocated, 0
[   84.185086] VFS: Disk quotas dquot_6.5.1
[   84.231851] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[   84.310016] msgmni has been set to 4046
[   84.356045] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   84.444216] io scheduler noop registered
[   84.491078] io scheduler anticipatory registered
[   84.546285] io scheduler deadline registered
[   84.597353] io scheduler cfq registered (default)
[   84.654563] e3d: Found device at 0000:00:02.0
[   84.816934] Console: switching to colour frame buffer device 144x56
[   84.993920] ERROR(0): Cheetah error trap taken afsr[0010100000000000] afar[0000000000008080] TL1(0)
[   85.102492] ERROR(0): TPC[686af0] TNPC[686af4] O7[686aac] TSTATE[4480001604]
[   85.186544] ERROR(0): TPC<e3d_pci_register+0x10c/0x404>
[   85.248417] ERROR(0): M_SYND(0),  E_SYND(0), Privileged
[   85.311262] ERROR(0): Highest priority error (0000100000000000) "Unmapped error from system bus"
[   85.417033] ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
[   85.530684] ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
[   85.666598] ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
[   85.822276] ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
[   85.957642] ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
[   86.093268] ERROR(0): E-cache idx[8080] tag[0000000000114524]
[   86.161350] ERROR(0): E-cache data0[0000000800000010] data1[0000010000000000] data2[00000000006a0ed0] data3[0720072000000000]
[   86.297650] Kernel panic - not syncing: Irrecoverable deferred error trap.
[   86.297655] 
[   86.396306] Press Stop-A (L1-A) to return to the boot prom

--=-g+xCo2pJjDjn22N65dSq--

