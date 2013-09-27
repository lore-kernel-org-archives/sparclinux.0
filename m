From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 27 Sep 2013 19:21:25 +0000
Subject: Re: [PATCH 0/3] Fully support 47-bit physical addresses.
Message-Id: <77831380309685@web5h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <20130926.165242.1048533011152185981.davem@redhat.com>
In-Reply-To: <20130926.165242.1048533011152185981.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

27.09.2013, 00:52, "David Miller" <davem@redhat.com>:
> Ok, this patch set builds on top of the variable PAGE_OFFSET
> patches.
>
> First we move to 8MB huge pages. =9AThe chips don't really have
> 8MB page support, but we fabricate such a thing using 4MB
> PTEs.
>
> Next we move to 64-bit pmd_t and pgd_t entries, which is the
> most trivial of the changes here.
>
> Finally, we encode huge PMDs using the plain PTE encoding of
> huge pages. =9A=9AAll of the ugly huge PMD --> PTE translation
> code disappears, and the TLB miss path is smaller and faster.
>
> I just got this stuff fully working so caveat emptor :-)
>
> Signed-off-by: David S. Miller <davem@davemloft.net>

Hi, David,

I've tryed the series on UltraSparc II with Spitfire MMU. Boot is ok,
and some LTP tests are passed (short tests of mm).

Below is head of dmesg if it can be useful:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.11.25 1998/01/16 12:22'
[    0.000000] PROMLIB: Root node compatible:=20
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.11.0+ (tkhai@loc) (gcc version 3.3.1) #110 S=
MP Fri Sep 27 20:41:51 MSK 2013
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:9a:71:59
[    0.000000] PAGE_OFFSET is 0xffffff0000000000 (max_phys_bits =3D 40)
[    0.000000] Kernel: Using 4 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 51604 bytes of memory.
[    0.000000] Top of RAM: 0xbff28000, Total RAM: 0x3ff24000
[    0.000000] Memory hole size: 2048MB
[    0.000000]  [1000000-17fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x80000000-0xbff27fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x80000000-0xbfefdfff]
[    0.000000]   node   0: [mem 0xbff00000-0xbff0ffff]
[    0.000000]   node   0: [mem 0xbff12000-0xbff27fff]
[    0.000000] On node 0 totalpages: 130962
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130962 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 7 pages/cpu @ffffff00bf000000 s23104 r8192 =
d26048 u2097152
[    0.000000] pcpu-alloc: s23104 r8192 d26048 u2097152 alloc=3D1*4194304
[    0.000000] pcpu-alloc: [0] 0 2=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 129938
[    0.000000] Kernel command line: root=3D/dev/sda1 ro rcu_nocbs=3D1
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 b=
ytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 byte=
s)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1023624K/1047696K available (4608K kernel code, 559K=
 rwdata, 1480K rodata, 288K init, 6989K bss, 24072K reserved)
[    0.000000] SLUB: HWalign2, Order=3D0-3, MinObjects=3D0, CPUs=3D3, Nodes=
=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS%6 to nr_cpu_ids=3D3.
[    0.000000] 	Note: kernel parameter 'rcu_nocbs=3D' contains nonexistent =
CPUs.
[    0.000000] 	Offload RCU callbacks from CPUs: .
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[360e6eb] shift[24]
[    0.000000] clockevent: mult[4bc5d28c] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[   61.014488] Calibrating delay using timer specific routine.. 595.58 Bogo=
MIPS (lpj=1191173)
[   61.014556] pid_max: default: 32768 minimum: 301
[   61.015133] Security Framework initialized
[   61.015211] AppArmor: AppArmor disabled by boot time parameter
[   61.015439] Mount-cache hash table entries: 512
[   61.018667] Initializing cgroup subsys devices
[   61.018726] Initializing cgroup subsys freezer
[   61.018767] Initializing cgroup subsys blkio
[   61.018805] Initializing cgroup subsys perf_event
[   61.019764] Performance events: No support for PMU type 'ultra12'
[   61.089165] CPU 2: synchronized TICK with master CPU (last diff -1 cycle=
s, maxerr 441 cycles)
[   61.089602] Brought up 2 CPUs
[   61.093167] devtmpfs: initialized
[   61.096168] regulator-dummy: no parameters
[   61.096922] NET: Registered protocol family 16
[   61.105599] Missing cpus node, bailing out
[   61.105764] Missing cpus node, bailing out
[   61.114400] /pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
[   61.114492] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[   61.114533] PCI: Scanning PBM /pci@1f,4000
[   61.114859] psycho f005fc4c: PCI host bridge to bus 0000:00
[   61.114930] pci_bus 0000:00: root bus resource [io  0x1fe02010000-0x1fe0=
201ffff] (bus address [0x0000-0xffff])
[   61.115046] pci_bus 0000:00: root bus resource [mem 0x1ff80000000-0x1fff=
fffffff] (bus address [0x00000000-0x7fffffff])
[   61.115218] pci_bus 0000:00: root bus resource [bus 00-01]
[   61.116917] pci 0000:00:04.0: supports D1
[   61.116953] pci 0000:00:04.0: PME# supported from D0 D1 D3hot
[   61.117433] pci 0000:00:04.0: PCI bridge to [bus 01]
[   61.117515] pci 0000:00:04.0:   bridge window [io  0x1fe02011000-0x1fe02=
011fff]
[   61.117789] pci 0000:01:00.0: supports D1 D2
[   61.118335] pci 0000:01:00.1: supports D1 D2
[   61.118986] /pci@1f,4000: PCI Error, primary error type[Excessive Retrie=
s]
[   61.119062] /pci@1f,4000: bytemask[0030] UPA_MID[00] was_block(0)
[   61.119121] /pci@1f,4000: PCI AFAR [000001fe01010004]
[   61.119175] /pci@1f,4000: PCI Secondary errors [(Master Abort)]
[   61.119570] /pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
[   61.119645] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[   61.119701] PCI: Scanning PBM /pci@1f,2000
[   61.119940] psycho f00604d8: PCI host bridge to bus 0001:80
[   61.120023] pci_bus 0001:80: root bus resource [io  0x1fe02000000-0x1fe0=
200ffff] (bus address [0x0000-0xffff])
[   61.120134] pci_bus 0001:80: root bus resource [mem 0x1ff00000000-0x1ff7=
fffffff] (bus address [0x00000000-0x7fffffff])
[   61.120240] pci_bus 0001:80: root bus resource [bus 80]

Regards,
Kirill
