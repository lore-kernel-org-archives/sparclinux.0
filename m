From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 11 Sep 2009 19:09:10 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090911190910.GA26362@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Sun, Sep 06, 2009 at 11:21:42PM +0200, S=E9bastien Bernard wrote:
>> > > > > the sid kernels are not booting on my machine (SunBlade 1000), a=
nd I have
>> > > > > an independent confirmation from someone with a similar machine =
that they
>> > > > > are experiencing similar problems - I'm going to file a bug for =
that if
>> > > > > the situation does not improve with the next kernel upload.
>> [   61.022918] CPU 1: synchronized TICK with master CPU (last diff 0 cyc=
les, maxerr 5 cycles)
>> [   61.022933] Brought up 2 CPUs
>> [   61.024050] net_namespace: 1936 bytes
>> [   61.200137] regulator: core version 0.5
>> [   61.245754] NET: Registered protocol family 16
>> [   61
>>
>> It just hangs right there, with the last string only partially displayed
>> and cursor blinking right after '61'.

> I think you hit the same bug as I do on my V240 (same hardware I think).

I just tried to upgrade from 2.6.26/2.6.28.7 to 2.6.31 on one of our V240s
and I seem to have reproduced this pretty peculiar problem:

PROMLIB: Sun IEEE Boot Prom 'OBP 4.11.4 2003/07/23 08:04'
PROMLIB: Root node compatible:=20
Linux version 2.6.31 (joy@schroeder) (gcc version 4.3.2 (Debian 4.3.2-1.1) =
) #1 SMP Fri Sep 11 18:39:54 UTC 2009
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:5a:53:a5
Kernel: Using 1 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
PROM: Built device tree with 85818 bytes of memory.
Top of RAM: 0x123fedc000, Total RAM: 0xffed4000
Memory hole size: 70656MB
[0000000200000000-fffff80000400000] page_structs=131072 node=3D0 entry=3D0/0
[0000000200000000-fffff80000800000] page_structs=131072 node=3D0 entry=3D1/0
[0000000204000000-fffff80000c00000] page_structs=131072 node=3D0 entry=16/0
[0000000204000000-fffff80001000000] page_structs=131072 node=3D0 entry=17/0
[0000000220000000-fffff80001400000] page_structs=131072 node=3D0 entry=128/0
[0000000220000000-fffff80001800000] page_structs=131072 node=3D0 entry=129/0
[0000000224000000-fffff80001c00000] page_structs=131072 node=3D0 entry=144/0
[0000000224000000-fffff80002000000] page_structs=131072 node=3D0 entry=145/0
Zone PFN ranges:
  Normal   0x00000000 -> 0x0091ff6e
Movable zone start PFN for each node
early_node_map[7] active PFN ranges
    0: 0x00000000 -> 0x00020000
    0: 0x00100000 -> 0x00120000
    0: 0x00800000 -> 0x00820000
    0: 0x00900000 -> 0x0091f7ff
    0: 0x0091f800 -> 0x0091fef3
    0: 0x0091fef5 -> 0x0091ff60
    0: 0x0091ff61 -> 0x0091ff6e
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 449387
Kernel command line: root=3D/dev/md1 ro rootdelay  console=3DttyS0,9600n1
PID hash table entries: 4096 (order: 12, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 4148904k available (2520k kernel code, 928k data, 200k init) [fffff=
80000000000,000000123fedc000]
NR_IRQS:255
clocksource: mult[535555] shift[16]
clockevent: mult[3126e97] shift[32]
Console: colour dummy device 80x25
Calibrating delay using timer specific routine.. 24.01 BogoMIPS (lpjH029)
Mount-cache hash table entries: 512
CPU 0: synchronized TICK with master CPU (last diff -1 cycles, maxerr 7 cyc=
les)
Brought up 2 CPUs
NET: Registered protocol family 16
Test

It just froze right there.

This V240 doesn't actually include any qla2xxx hardware, so the 5->30 second
NMI patch which is included in 2.6.31 doesn't sound to me like it would ever
affect it anyway...

I noticed in other thread that initcall_debug=3D1 ignore_loglevel informati=
on=20
may be useful, so here goes:

PROMLIB: Sun IEEE Boot Prom 'OBP 4.11.4 2003/07/23 08:04'
PROMLIB: Root node compatible:=20
Linux version 2.6.31 (joy@schroeder) (gcc version 4.3.2 (Debian 4.3.2-1.1) =
) #1 SMP Fri Sep 11 18:39:54 UTC 2009
debug: ignoring loglevel setting.
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:5a:53:a5
Kernel: Using 1 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
PROM: Built device tree with 85818 bytes of memory.
Top of RAM: 0x123fedc000, Total RAM: 0xffed4000
Memory hole size: 70656MB
[0000000200000000-fffff80000400000] page_structs=131072 node=3D0 entry=3D0/0
[0000000200000000-fffff80000800000] page_structs=131072 node=3D0 entry=3D1/0
[0000000204000000-fffff80000c00000] page_structs=131072 node=3D0 entry=16/0
[0000000204000000-fffff80001000000] page_structs=131072 node=3D0 entry=17/0
[0000000220000000-fffff80001400000] page_structs=131072 node=3D0 entry=128/0
[0000000220000000-fffff80001800000] page_structs=131072 node=3D0 entry=129/0
[0000000224000000-fffff80001c00000] page_structs=131072 node=3D0 entry=144/0
[0000000224000000-fffff80002000000] page_structs=131072 node=3D0 entry=145/0
Zone PFN ranges:
  Normal   0x00000000 -> 0x0091ff6e
Movable zone start PFN for each node
early_node_map[7] active PFN ranges
    0: 0x00000000 -> 0x00020000
    0: 0x00100000 -> 0x00120000
    0: 0x00800000 -> 0x00820000
    0: 0x00900000 -> 0x0091f7ff
    0: 0x0091f800 -> 0x0091fef3
    0: 0x0091fef5 -> 0x0091ff60
    0: 0x0091ff61 -> 0x0091ff6e
On node 0 totalpages: 524138
  Normal zone: 74751 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 449387 pages, LIFO batch:15
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 449387
Kernel command line: root=3D/dev/md1 ro rootdelay  console=3DttyS0,9600n1 i=
nitcall_debug=3D1 ignore_loglevel
PID hash table entries: 4096 (order: 12, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 4148904k available (2520k kernel code, 928k data, 200k init) [fffff=
80000000000,000000123fedc000]
NR_IRQS:255
clocksource: mult[535555] shift[16]
clockevent: mult[3126e97] shift[32]
Console: colour dummy device 80x25
Calibrating delay using timer specific routine.. 24.01 BogoMIPS (lpjH028)
Mount-cache hash table entries: 512
calling  migration_init+0x0/0x6c @ 1
initcall migration_init+0x0/0x6c returned 1 after 0 usecs
initcall migration_init+0x0/0x6c returned with error code 1=20
calling  spawn_ksoftirqd+0x0/0x64 @ 1
initcall spawn_ksoftirqd+0x0/0x64 returned 0 after 0 usecs
calling  init_call_single_data+0x0/0xac @ 1
initcall init_call_single_data+0x0/0xac returned 0 after 0 usecs
calling  relay_init+0x0/0x8 @ 1
initcall relay_init+0x0/0x8 returned 0 after 0 usecs
CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 6 cycl=
es)
Brought up 2 CPUs
calling  init_mmap_min_addr+0x0/0x18 @ 1
initcall init_mmap_min_addr+0x0/0x18 returned 0 after 0 usecs
calling  net_ns_init+0x0/0x144 @ 1
initcall net_ns_init+0x0/0x144 returned 0 after 0 usecs
calling  sparc_globreg_init+0x0/0x1c @ 1
initcall sparc_globreg_init+0x0/0x1c returned 0 after 0 usecs
calling  sstate_init+0x0/0x78 @ 1
initcall sstate_init+0x0/0x78 returned 0 after 0 usecs
calling  sysctl_init+0x0/0x2c @ 1
initcall sysctl_init+0x0/0x2c returned 0 after 0 usecs
calling  ksysfs_init+0x0/0xc4 @ 1
initcall ksysfs_init+0x0/0xc4 returned 0 after 0 usecs
calling  async_init+0x0/0x64 @ 1
initcall async_init+0x0/0x64 returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x18 @ 1
initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 0 usecs
calling  filelock_init+0x0/0x38 @ 1
initcall filelock_init+0x0/0x38 returned 0 after 1023437 usecs
calling  init_script_binfmt+0x0/0x1c @ 1
initcall init_script_binfmt+0x0/0x1c returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x1c @ 1
initcall init_elf_binfmt+0x0/0x1c returned 0 after 0 usecs
calling  init_compat_elf_binfmt+0x0/0x1c @ 1
initcall init_compat_elf_binfmt+0x0/0x1c returned 0 after 0 usecs
calling  debugfs_init+0x0/0x64 @ 1
initcall debugfs_init+0x0/0x64 returned 0 after 0 usecs
calling  random32_init+0x0/0xec @ 1
initcall random32_init+0x0/0xec returned 0 after 0 usecs
calling  sock_init+0x0/0x64 @ 1
initcall sock_init+0x0/0x64 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x250 @ 1
NET: Registered protocol family 16
initcall netlink_proto_init+0x0/0x250 returned 0 after 3906 usecs
calling  of_bus_driver_init+0x0/0x54 @ 1
initcall of_bus_driver_init+0x0/0x54 returned 0 after 7812 usecs
calling  bdi_class_init+0x0/0x54 @ 1
initcall bdi_class_init+0x0/0x54 returned 0 after 0 usecs
calling  kobject_uevent_init+0x0/0x64 @ 1
initcall kobject_uevent_init+0x0/0x64 returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x20 @ 1
initcall pcibus_class_init+0x0/0x20 returned 0 after 0 usecs
calling  pci_driver_init+0x0/0x18 @ 1
initcall pci_driver_init+0x0/0x18 returned 0 after 0 usecs
calling  backlight_class_init+0x0/0x74 @ 1
initcall backlight_class_init+0x0/0x74 returned 0 after 0 usecs
calling  tty_class_init+0x0/0x38 @ 1
initcall tty_class_init+0x0/0x38 returned 0 after 0 usecs
calling  vtconsole_class_init+0x0/0xe4 @ 1
initcall vtconsole_class_init+0x0/0xe4 returned 0 after 0 usecs
calling  i2c_init+0x0/0x70 @ 1
initcall i2c_init+0x0/0x70 returned 0 after 0 usecs
calling  cpu_type_probe+0x0/0x234 @ 1
initcall cpu_type_probe+0x0/0x234 returned 0 after 0 usecs
calling  pcr_arch_init+0x0/0x130 @ 1
Test

I'll test Dave's image later, and if that fails, I guess it's best to start
bisecting?

--=20
     2. That which causes joy or happiness.
