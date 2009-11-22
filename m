From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 22 Nov 2009 22:06:21 +0000
Subject: Re: Re: Re: Sun fire V890 UltraSparc server kernel panic,
Message-Id: <20091122220621.GA16620@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Sun, Nov 22, 2009 at 11:03:28PM +0200, Aaron Sheiner wrote:
> > When you reproduce the same conditions, is the failure
> > message similar or identical?
>=20
> It would seem that they are identical, see below. Although probably
> unimportant, there is a difference in the time since boot (16.363172).

Yes. OK, let's Cc: this now to the SPARC kernel development mailing list so
that the kernel folks can see.

The machine specification is in the original post at
http://lists.debian.org/debian-sparc/2009/11/msg00013.html
There is one recorded V890 prtconf from Meelis Roos in prtconfs.git
so that's a good sign, at least one person once made it work. :)

> Booting Lenny with arguments console=3Dttya :
> "
> RSC Alert: Host System has Reset
> a|/
> Allocated 8 Megs of memory at 0x40000000 for kernel
> Loaded kernel version 2.6.26
> Loading initial ramdisk (4311252 bytes at 0xD1FE008000 phys, 0x40C00000
> virt)...
> \
> [    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23
> 13:01'
> [    0.000000] PROMLIB: Root node compatible:=20
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 2.6.26-2-sparc64 (Debian 2.6.26-19)
> (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian
> 4.1.2-25)) #1 Thu Aug 20 15:21:01 UTC 2009
> [    0.000000] console [earlyprom0] enabled
> [    0.000000] ARCH: SUN4U
> [    0.000000] Ethernet address: 00:14:4f:1e:47:f9
> [    0.000000] Kernel: Using 1 locked TLB entries for main kernel image.
> [    0.000000] Remapping the kernel... done.
> [    0.000000] OF stdout device
> is: /pci@9,700000/ebus@1/rsc-console@1,3083f8
> [    0.000000] PROM: Built device tree with 193535 bytes of memory.
> [    0.000000] Top of RAM: 0xd1ff9d0000, Total RAM: 0x7f5a5e000
> [    0.000000] Memory hole size: 827551MB
> [    0.000000] [0000000318000000-fffff8a000400000] page_structs=131072
> node=3D0 entry=1120/0
> [    0.000000] [0000000318000000-fffff8a000800000] page_structs=131072
> node=3D0 entry=1121/0
> [    0.000000] [0000000318700000-fffff8a000c00000] page_structs=131072
> node=3D0 entry=1122/0
> [    0.000000] [0000000318700000-fffff8a001000000] page_structs=131072
> node=3D0 entry=1123/0
> [    0.000000] [0000000318e00000-fffff8a001400000] page_structs=131072
> node=3D0 entry=1124/0
> [    0.000000] [0000000318e00000-fffff8a001800000] page_structs=131072
> node=3D0 entry=1125/0
> [    0.000000] [0000000319500000-fffff8a001c00000] page_structs=131072
> node=3D0 entry=1126/0
> [    0.000000] [0000000319c00000-fffff8a002000000] page_structs=131072
> node=3D0 entry=1127/0
> [    0.000000] [0000000319c00000-fffff8a002400000] page_structs=131072
> node=3D0 entry=1128/0
> [    0.000000] [000000031a300000-fffff8a002800000] page_structs=131072
> node=3D0 entry=1129/0
> [    0.000000] [000000031a300000-fffff8a002c00000] page_structs=131072
> node=3D0 entry=1130/0
> [    0.000000] [000000031aa00000-fffff8a003000000] page_structs=131072
> node=3D0 entry=1131/0
> [    0.000000] [000000031aa00000-fffff8a003400000] page_structs=131072
> node=3D0 entry=1132/0
> [    0.000000] [000000031b100000-fffff8a003800000] page_structs=131072
> node=3D0 entry=1133/0
> [    0.000000] [0000000334000000-fffff8a003c00000] page_structs=131072
> node=3D0 entry=1232/0
> [    0.000000] [0000000334000000-fffff8a004000000] page_structs=131072
> node=3D0 entry=1233/0
> [    0.000000] [0000000334700000-fffff8a004400000] page_structs=131072
> node=3D0 entry=1234/0
> [    0.000000] [0000000334700000-fffff8a004800000] page_structs=131072
> node=3D0 entry=1235/0
> [    0.000000] [0000000334e00000-fffff8a004c00000] page_structs=131072
> node=3D0 entry=1236/0
> [    0.000000] [0000000334e00000-fffff8a005000000] page_structs=131072
> node=3D0 entry=1237/0
> [    0.000000] [0000000335500000-fffff8a005400000] page_structs=131072
> node=3D0 entry=1238/0
> [    0.000000] [0000000335c00000-fffff8a005800000] page_structs=131072
> node=3D0 entry=1239/0
> [    0.000000] [0000000335c00000-fffff8a005c00000] page_structs=131072
> node=3D0 entry=1240/0
> [    0.000000] [0000000336300000-fffff8a006000000] page_structs=131072
> node=3D0 entry=1241/0
> [    0.000000] [0000000336300000-fffff8a006400000] page_structs=131072
> node=3D0 entry=1242/0
> [    0.000000] [0000000336a00000-fffff8a006800000] page_structs=131072
> node=3D0 entry=1243/0
> [    0.000000] [0000000336a00000-fffff8a006c00000] page_structs=131072
> node=3D0 entry=1244/0
> [    0.000000] [0000000337100000-fffff8a007000000] page_structs=131072
> node=3D0 entry=1245/0
> [    0.000000] [0000000350000000-fffff8a007400000] page_structs=131072
> node=3D0 entry=1344/0
> [    0.000000] [0000000350000000-fffff8a007800000] page_structs=131072
> node=3D0 entry=1345/0
> [    0.000000] [0000000350700000-fffff8a007c00000] page_structs=131072
> node=3D0 entry=1346/0
> [    0.000000] [0000000350700000-fffff8a008000000] page_structs=131072
> node=3D0 entry=1347/0
> [    0.000000] [0000000350e00000-fffff8a008400000] page_structs=131072
> node=3D0 entry=1348/0
> [    0.000000] [0000000350e00000-fffff8a008800000] page_structs=131072
> node=3D0 entry=1349/0
> [    0.000000] [0000000351500000-fffff8a008c00000] page_structs=131072
> node=3D0 entry=1350/0
> [    0.000000] [0000000351c00000-fffff8a009000000] page_structs=131072
> node=3D0 entry=1351/0
> [    0.000000] [0000000351c00000-fffff8a009400000] page_structs=131072
> node=3D0 entry=1352/0
> [    0.000000] [0000000352300000-fffff8a009800000] page_structs=131072
> node=3D0 entry=1353/0
> [    0.000000] [0000000352300000-fffff8a009c00000] page_structs=131072
> node=3D0 entry=1354/0
> [    0.000000] [0000000352a00000-fffff8a00a000000] page_structs=131072
> node=3D0 entry=1355/0
> [    0.000000] [0000000352a00000-fffff8a00a400000] page_structs=131072
> node=3D0 entry=1356/0
> [    0.000000] [0000000353100000-fffff8a00a800000] page_structs=131072
> node=3D0 entry=1357/0
> [    0.000000] [000000036c000000-fffff8a00ac00000] page_structs=131072
> node=3D0 entry=1456/0
> [    0.000000] [000000036c000000-fffff8a00b000000] page_structs=131072
> node=3D0 entry=1457/0
> [    0.000000] [000000036c700000-fffff8a00b400000] page_structs=131072
> node=3D0 entry=1458/0
> [    0.000000] [000000036c700000-fffff8a00b800000] page_structs=131072
> node=3D0 entry=1459/0
> [    0.000000] [000000036ce00000-fffff8a00bc00000] page_structs=131072
> node=3D0 entry=1460/0
> [    0.000000] [000000036ce00000-fffff8a00c000000] page_structs=131072
> node=3D0 entry=1461/0
> [    0.000000] [000000036d500000-fffff8a00c400000] page_structs=131072
> node=3D0 entry=1462/0
> [    0.000000] [000000036dc00000-fffff8a00c800000] page_structs=131072
> node=3D0 entry=1463/0
> [    0.000000] [000000036dc00000-fffff8a00cc00000] page_structs=131072
> node=3D0 entry=1464/0
> [    0.000000] [000000036e300000-fffff8a00d000000] page_structs=131072
> node=3D0 entry=1465/0
> [    0.000000] [000000036e300000-fffff8a00d400000] page_structs=131072
> node=3D0 entry=1466/0
> [    0.000000] [000000036ea00000-fffff8a00d800000] page_structs=131072
> node=3D0 entry=1467/0
> [    0.000000] [000000036ea00000-fffff8a00dc00000] page_structs=131072
> node=3D0 entry=1468/0
> [    0.000000] [000000036f100000-fffff8a00e000000] page_structs=131072
> node=3D0 entry=1469/0
> [    0.000000] Zone PFN ranges:
> [    0.000000]   Normal   83886080 -> 110099688
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[8] active PFN ranges
> [    0.000000]     0: 83886080 -> 84934656
> [    0.000000]     0: 92274688 -> 93323264
> [    0.000000]     0: 100663296 -> 101711872
> [    0.000000]     0: 109051904 -> 110071808
> [    0.000000]     0: 110071809 -> 110075984
> [    0.000000]     0: 110096388 -> 110098431
> [    0.000000]     0: 110098432 -> 110099677
> [    0.000000]     0: 110099680 -> 110099688
> [    0.000000] Booting Linux...
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 3993908
> [    0.000000] Kernel command line: console=3Dttya
> [    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
> [    0.000000] clocksource: mult[640000] shift[16]
> [    0.000000] clockevent: mult[28f5c28] shift[32]
> [   79.860575] Console: colour dummy device 80x25
> [   79.893142] Dentry cache hash table entries: 4194304 (order: 12,
> 33554432 bytes)
> [   79.938932] Inode-cache hash table entries: 2097152 (order: 11,
> 16777216 bytes)
> [   82.536736] Memory: 33096600k available (2592k kernel code, 944k
> data, 176k init) [fffff80000000000,000000d1ff9d0000]
> [   82.626683] Calibrating delay using timer specific routine.. 19.85
> BogoMIPS (lpj9705)
> [   82.634682] Security Framework initialized
> [   82.638708] SELinux:  Disabled at boot.
> [   82.642515] Capability LSM initialized
> [   82.646260] Mount-cache hash table entries: 512
> [   82.651005] Initializing cgroup subsys ns
> [   82.654941] Initializing cgroup subsys cpuacct
> [   82.659356] Initializing cgroup subsys devices
> [   82.663939] Kernel unaligned access at TPC[46d24c]
> notifier_chain_register+0x10/0x38
> [   82.671606] Unable to handle kernel paging request in mna handler<1>
> at virtual address e00000a00b000046
> [   82.681042] current->{active_,}mm->context =3D 0000000000000000
> [   82.686761] current->{active_,}mm->pgd =3D fffff8d1ff3b2104
> [   82.692134]               \|/ ____ \|/
> [   82.692136]               "@'/ .. \`@"
> [   82.692138]               /_| \__/ |_\
> [   82.692140]                  \__U_/
> [   82.706778] swapper(1): Oops [#1]
> [   82.710074] TSTATE: 0000008880f01605 TPC: 000000000046d24c TNPC:
> 000000000046d250 Y: 00000000    Not tainted
> [   82.719866] TPC: <notifier_chain_register+0x10/0x38>
> [   82.724804] g0: 00000000000200d0 g1: 0000000000000001 g2:
> 0000000000000000 g3: e00000a00b000036
> [   82.733469] g4: fffff8d1f382f6e0 g5: 0000000000000000 g6:
> fffff8d1f383c000 g7: fffff8d1f382ebe8
> [   82.742134] o0: 00000000007b7aa8 o1: 0000000000748528 o2:
> 0000000000000000 o3: fffff8d1f313dff9
> [   82.750799] o4: 0000000000774000 o5: 0000000000000005 sp:
> fffff8d1f383f581 ret_pc: 000000000046d33c
> [   82.759812] RPC: <atomic_notifier_chain_register+0x1c/0x44>
> [   82.765358] l0: fffff8d1f383c000 l1: fffff8d1f382f6e0 l2:
> fffff8d1f382f140 l3: fffff8d1f382f3c0
> [   82.774023] l4: 0000000000000002 l5: 000000000073c040 l6:
> 0000000000000020 l7: 0000000000000010
> [   82.782688] i0: 00000000007b7aa8 i1: 0000000000000000 i2:
> 0000000000426df4 i3: 0000000000000000
> [   82.791352] i4: 0000000000000000 i5: 0000000000000000 i6:
> fffff8d1f383f641 i7: 0000000000782128
> [   82.800022] I7: <kernel_init+0x38/0x204>
> [   82.803917] Caller[0000000000782128]: kernel_init+0x38/0x204
> [   82.809549] Caller[0000000000426df8]: kernel_thread+0x38/0x48
> [   82.815268] Caller[000000000067bae0]: rest_init+0x18/0x60
> [   82.820640] Instruction DUMP: 01000000  10680008  c65a0000 <c200e010>
> 80a08001  34400007  c6726008  9000e008  c65a0000=20
> [   82.831387] Kernel panic - not syncing: Attempted to kill init!
> [   82.837279] Kernel unaligned access at TPC[46d2c4]
> notifier_call_chain+0x18/0x74
> [   82.844643] Unable to handle kernel paging request in mna handler<1>
> at virtual address e00000a00b000036
> [   82.854088] current->{active_,}mm->context =3D 0000000000000000
> [   82.859807] current->{active_,}mm->pgd =3D fffff8d1ff3b2104
> [   82.865179]               \|/ ____ \|/
> [   82.865181]               "@'/ .. \`@"
> [   82.865183]               /_| \__/ |_\
> [   82.865185]                  \__U_/
> [   82.879823] swapper(1): Oops [#2]
> [   82.883119] TSTATE: 0000000080f09605 TPC: 000000000046d2c4 TNPC:
> 000000000046d2c8 Y: 00000000    Tainted: G      D =20
> [   82.893603] TPC: <notifier_call_chain+0x18/0x74>
> [   82.898196] g0: 0000000000744000 g1: 0000000000000001 g2:
> 0000000000000001 g3: 00000000007440c0
> [   82.906861] g4: fffff8d1f382f6e0 g5: 0000000000000000 g6:
> fffff8d1f383c000 g7: 0000000000000001
> [   82.915525] o0: e00000a00b000036 o1: 0000000000000000 o2:
> 00000000007b7ad0 o3: fffff8d1f383f8e8
> [   82.924192] o4: 0000000000744000 o5: 00000000007bc400 sp:
> fffff8d1f383ee01 ret_pc: 0000000000557fcc
> [   82.933213] RPC: <bust_spinlocks+0x48/0x4c>
> [   82.937363] l0: e00000a00b000036 l1: 0000000000000000 l2:
> 00000000007b7ed0 l3: ffffffffffffd59a
> [   82.946029] l4: 00000000007b7ad0 l5: 000000000073c040 l6:
> 0000000000000020 l7: 0000000000000010
> [   82.954694] i0: 0000000000000000 i1: 0000000000000000 i2:
> 00000000007b7ad0 i3: fffffffffffffffe
> [   82.963358] i4: 0000000000000000 i5: 0000000000004000 i6:
> fffff8d1f383eec1 i7: 0000000000456e88
> [   82.972027] I7: <panic+0x6c/0x164>
> [   82.975403] Caller[0000000000456e88]: panic+0x6c/0x164
> [   82.980515] Caller[000000000045a250]: do_exit+0x6c/0x6f8
> [   82.985801] Caller[0000000000428c40]: die_if_kernel+0x238/0x2d4
> [   82.991694] Caller[00000000004344b8]: kernel_mna_trap_fault+0xc8/0xfc
> [   82.998106] Caller[00000000004349c8]: kernel_unaligned_trap
> +0x4dc/0x520
> [   83.004691] Caller[0000000000428750]: mem_address_unaligned+0x58/0x90
> [   83.011104] Caller[0000000000405e08]: do_mna+0x44/0x4c
> [   83.016217] Caller[000000000046d33c]: atomic_notifier_chain_register
> +0x1c/0x44
> [   83.023410] Caller[0000000000782128]: kernel_init+0x38/0x204
> [   83.029041] Caller[0000000000426df8]: kernel_thread+0x38/0x48
> [   83.034760] Caller[000000000067bae0]: rest_init+0x18/0x60
> [   83.040133] Instruction DUMP: e05e0000  1068000f  b0102000 <c25c0000>
> e05c2008  9fc04000  01000000  03000020  b0100008=20
> [   83.050878] Fixing recursive fault but reboot is needed!
> "
>=20
> Lenny with console=3DttyS0 :
>=20
> "Allocated 8 Megs of memory at 0x40000000 for kernel
> Loaded kernel version 2.6.26
> Loading initial ramdisk (4311252 bytes at 0xD1FE008000 phys, 0x40C00000
> virt)...
> -
> [    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23
> 13:01'
> [    0.000000] PROMLIB: Root node compatible:=20
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 2.6.26-2-sparc64 (Debian 2.6.26-19)
> (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian
> 4.1.2-25)) #1 Thu Aug 20 15:21:01 UTC 2009
> [    0.000000] console [earlyprom0] enabled
> [    0.000000] ARCH: SUN4U
> [    0.000000] Ethernet address: 00:14:4f:1e:47:f9
> [    0.000000] Kernel: Using 1 locked TLB entries for main kernel image.
> [    0.000000] Remapping the kernel... done.
> [    0.000000] OF stdout device
> is: /pci@9,700000/ebus@1/rsc-console@1,3083f8
> [    0.000000] PROM: Built device tree with 193535 bytes of memory.
> [    0.000000] Top of RAM: 0xd1ff9d0000, Total RAM: 0x7f5a5e000
> [    0.000000] Memory hole size: 827551MB
> [    0.000000] [0000000318000000-fffff8a000400000] page_structs=131072
> node=3D0 entry=1120/0
> [    0.000000] [0000000318000000-fffff8a000800000] page_structs=131072
> node=3D0 entry=1121/0
> [    0.000000] [0000000318700000-fffff8a000c00000] page_structs=131072
> node=3D0 entry=1122/0
> [    0.000000] [0000000318700000-fffff8a001000000] page_structs=131072
> node=3D0 entry=1123/0
> [    0.000000] [0000000318e00000-fffff8a001400000] page_structs=131072
> node=3D0 entry=1124/0
> [    0.000000] [0000000318e00000-fffff8a001800000] page_structs=131072
> node=3D0 entry=1125/0
> [    0.000000] [0000000319500000-fffff8a001c00000] page_structs=131072
> node=3D0 entry=1126/0
> [    0.000000] [0000000319c00000-fffff8a002000000] page_structs=131072
> node=3D0 entry=1127/0
> [    0.000000] [0000000319c00000-fffff8a002400000] page_structs=131072
> node=3D0 entry=1128/0
> [    0.000000] [000000031a300000-fffff8a002800000] page_structs=131072
> node=3D0 entry=1129/0
> [    0.000000] [000000031a300000-fffff8a002c00000] page_structs=131072
> node=3D0 entry=1130/0
> [    0.000000] [000000031aa00000-fffff8a003000000] page_structs=131072
> node=3D0 entry=1131/0
> [    0.000000] [000000031aa00000-fffff8a003400000] page_structs=131072
> node=3D0 entry=1132/0
> [    0.000000] [000000031b100000-fffff8a003800000] page_structs=131072
> node=3D0 entry=1133/0
> [    0.000000] [0000000334000000-fffff8a003c00000] page_structs=131072
> node=3D0 entry=1232/0
> [    0.000000] [0000000334000000-fffff8a004000000] page_structs=131072
> node=3D0 entry=1233/0
> [    0.000000] [0000000334700000-fffff8a004400000] page_structs=131072
> node=3D0 entry=1234/0
> [    0.000000] [0000000334700000-fffff8a004800000] page_structs=131072
> node=3D0 entry=1235/0
> [    0.000000] [0000000334e00000-fffff8a004c00000] page_structs=131072
> node=3D0 entry=1236/0
> [    0.000000] [0000000334e00000-fffff8a005000000] page_structs=131072
> node=3D0 entry=1237/0
> [    0.000000] [0000000335500000-fffff8a005400000] page_structs=131072
> node=3D0 entry=1238/0
> [    0.000000] [0000000335c00000-fffff8a005800000] page_structs=131072
> node=3D0 entry=1239/0
> [    0.000000] [0000000335c00000-fffff8a005c00000] page_structs=131072
> node=3D0 entry=1240/0
> [    0.000000] [0000000336300000-fffff8a006000000] page_structs=131072
> node=3D0 entry=1241/0
> [    0.000000] [0000000336300000-fffff8a006400000] page_structs=131072
> node=3D0 entry=1242/0
> [    0.000000] [0000000336a00000-fffff8a006800000] page_structs=131072
> node=3D0 entry=1243/0
> [    0.000000] [0000000336a00000-fffff8a006c00000] page_structs=131072
> node=3D0 entry=1244/0
> [    0.000000] [0000000337100000-fffff8a007000000] page_structs=131072
> node=3D0 entry=1245/0
> [    0.000000] [0000000350000000-fffff8a007400000] page_structs=131072
> node=3D0 entry=1344/0
> [    0.000000] [0000000350000000-fffff8a007800000] page_structs=131072
> node=3D0 entry=1345/0
> [    0.000000] [0000000350700000-fffff8a007c00000] page_structs=131072
> node=3D0 entry=1346/0
> [    0.000000] [0000000350700000-fffff8a008000000] page_structs=131072
> node=3D0 entry=1347/0
> [    0.000000] [0000000350e00000-fffff8a008400000] page_structs=131072
> node=3D0 entry=1348/0
> [    0.000000] [0000000350e00000-fffff8a008800000] page_structs=131072
> node=3D0 entry=1349/0
> [    0.000000] [0000000351500000-fffff8a008c00000] page_structs=131072
> node=3D0 entry=1350/0
> [    0.000000] [0000000351c00000-fffff8a009000000] page_structs=131072
> node=3D0 entry=1351/0
> [    0.000000] [0000000351c00000-fffff8a009400000] page_structs=131072
> node=3D0 entry=1352/0
> [    0.000000] [0000000352300000-fffff8a009800000] page_structs=131072
> node=3D0 entry=1353/0
> [    0.000000] [0000000352300000-fffff8a009c00000] page_structs=131072
> node=3D0 entry=1354/0
> [    0.000000] [0000000352a00000-fffff8a00a000000] page_structs=131072
> node=3D0 entry=1355/0
> [    0.000000] [0000000352a00000-fffff8a00a400000] page_structs=131072
> node=3D0 entry=1356/0
> [    0.000000] [0000000353100000-fffff8a00a800000] page_structs=131072
> node=3D0 entry=1357/0
> [    0.000000] [000000036c000000-fffff8a00ac00000] page_structs=131072
> node=3D0 entry=1456/0
> [    0.000000] [000000036c000000-fffff8a00b000000] page_structs=131072
> node=3D0 entry=1457/0
> [    0.000000] [000000036c700000-fffff8a00b400000] page_structs=131072
> node=3D0 entry=1458/0
> [    0.000000] [000000036c700000-fffff8a00b800000] page_structs=131072
> node=3D0 entry=1459/0
> [    0.000000] [000000036ce00000-fffff8a00bc00000] page_structs=131072
> node=3D0 entry=1460/0
> [    0.000000] [000000036ce00000-fffff8a00c000000] page_structs=131072
> node=3D0 entry=1461/0
> [    0.000000] [000000036d500000-fffff8a00c400000] page_structs=131072
> node=3D0 entry=1462/0
> [    0.000000] [000000036dc00000-fffff8a00c800000] page_structs=131072
> node=3D0 entry=1463/0
> [    0.000000] [000000036dc00000-fffff8a00cc00000] page_structs=131072
> node=3D0 entry=1464/0
> [    0.000000] [000000036e300000-fffff8a00d000000] page_structs=131072
> node=3D0 entry=1465/0
> [    0.000000] [000000036e300000-fffff8a00d400000] page_structs=131072
> node=3D0 entry=1466/0
> [    0.000000] [000000036ea00000-fffff8a00d800000] page_structs=131072
> node=3D0 entry=1467/0
> [    0.000000] [000000036ea00000-fffff8a00dc00000] page_structs=131072
> node=3D0 entry=1468/0
> [    0.000000] [000000036f100000-fffff8a00e000000] page_structs=131072
> node=3D0 entry=1469/0
> [    0.000000] Zone PFN ranges:
> [    0.000000]   Normal   83886080 -> 110099688
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[8] active PFN ranges
> [    0.000000]     0: 83886080 -> 84934656
> [    0.000000]     0: 92274688 -> 93323264
> [    0.000000]     0: 100663296 -> 101711872
> [    0.000000]     0: 109051904 -> 110071808
> [    0.000000]     0: 110071809 -> 110075984
> [    0.000000]     0: 110096388 -> 110098431
> [    0.000000]     0: 110098432 -> 110099677
> [    0.000000]     0: 110099680 -> 110099688
> [    0.000000] Booting Linux...
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 3993908
> [    0.000000] Kernel command line: console=3DttyS0
> [    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
> [    0.000000] clocksource: mult[640000] shift[16]
> [    0.000000] clockevent: mult[28f5c28] shift[32]
> [   82.089904] Console: colour dummy device 80x25
> [   82.122470] Dentry cache hash table entries: 4194304 (order: 12,
> 33554432 bytes)
> [   82.168263] Inode-cache hash table entries: 2097152 (order: 11,
> 16777216 bytes)
> [   84.765404] Memory: 33096600k available (2592k kernel code, 944k
> data, 176k init) [fffff80000000000,000000d1ff9d0000]
> [   84.855352] Calibrating delay using timer specific routine.. 19.85
> BogoMIPS (lpj9705)
> [   84.863351] Security Framework initialized
> [   84.867378] SELinux:  Disabled at boot.
> [   84.871184] Capability LSM initialized
> [   84.874929] Mount-cache hash table entries: 512
> [   84.879674] Initializing cgroup subsys ns
> [   84.883608] Initializing cgroup subsys cpuacct
> [   84.888025] Initializing cgroup subsys devices
> [   84.892608] Kernel unaligned access at TPC[46d24c]
> notifier_chain_register+0x10/0x38
> [   84.900274] Unable to handle kernel paging request in mna handler<1>
> at virtual address e00000a00b000046
> [   84.909712] current->{active_,}mm->context =3D 0000000000000000
> [   84.915431] current->{active_,}mm->pgd =3D fffff8d1ff3b2104
> [   84.920804]               \|/ ____ \|/
> [   84.920806]               "@'/ .. \`@"
> [   84.920808]               /_| \__/ |_\
> [   84.920810]                  \__U_/
> [   84.935448] swapper(1): Oops [#1]
> [   84.938744] TSTATE: 0000008880f01605 TPC: 000000000046d24c TNPC:
> 000000000046d250 Y: 00000000    Not tainted
> [   84.948535] TPC: <notifier_chain_register+0x10/0x38>
> [   84.953473] g0: 00000000000200d0 g1: 0000000000000001 g2:
> 0000000000000000 g3: e00000a00b000036
> [   84.962138] g4: fffff8d1f382f6e0 g5: 0000000000000000 g6:
> fffff8d1f383c000 g7: fffff8d1f382ebe8
> [   84.970803] o0: 00000000007b7aa8 o1: 0000000000748528 o2:
> 0000000000000000 o3: fffff8d1f313dff9
> [   84.979468] o4: 0000000000774000 o5: 0000000000000005 sp:
> fffff8d1f383f581 ret_pc: 000000000046d33c
> [   84.988482] RPC: <atomic_notifier_chain_register+0x1c/0x44>
> [   84.994026] l0: fffff8d1f383c000 l1: fffff8d1f382f6e0 l2:
> fffff8d1f382f140 l3: fffff8d1f382f3c0
> [   85.002691] l4: 0000000000000002 l5: 000000000073c040 l6:
> 0000000000000020 l7: 0000000000000010
> [   85.011356] i0: 00000000007b7aa8 i1: 0000000000000000 i2:
> 0000000000426df4 i3: 0000000000000000
> [   85.020022] i4: 0000000000000000 i5: 0000000000000000 i6:
> fffff8d1f383f641 i7: 0000000000782128
> [   85.028692] I7: <kernel_init+0x38/0x204>
> [   85.032587] Caller[0000000000782128]: kernel_init+0x38/0x204
> [   85.038218] Caller[0000000000426df8]: kernel_thread+0x38/0x48
> [   85.043938] Caller[000000000067bae0]: rest_init+0x18/0x60
> [   85.049310] Instruction DUMP: 01000000  10680008  c65a0000 <c200e010>
> 80a08001  34400007  c6726008  9000e008  c65a0000=20
> [   85.060057] Kernel panic - not syncing: Attempted to kill init!
> [   85.065948] Kernel unaligned access at TPC[46d2c4]
> notifier_call_chain+0x18/0x74
> [   85.073313] Unable to handle kernel paging request in mna handler<1>
> at virtual address e00000a00b000036
> [   85.082758] current->{active_,}mm->context =3D 0000000000000000
> [   85.088477] current->{active_,}mm->pgd =3D fffff8d1ff3b2104
> [   85.093849]               \|/ ____ \|/
> [   85.093851]               "@'/ .. \`@"
> [   85.093853]               /_| \__/ |_\
> [   85.093855]                  \__U_/
> [   85.108493] swapper(1): Oops [#2]
> [   85.111788] TSTATE: 0000000080f09605 TPC: 000000000046d2c4 TNPC:
> 000000000046d2c8 Y: 00000000    Tainted: G      D =20
> [   85.122273] TPC: <notifier_call_chain+0x18/0x74>
> [   85.126864] g0: 0000000000744000 g1: 0000000000000001 g2:
> 0000000000000001 g3: 00000000007440c0
> [   85.135531] g4: fffff8d1f382f6e0 g5: 0000000000000000 g6:
> fffff8d1f383c000 g7: 0000000000000001
> [   85.144195] o0: e00000a00b000036 o1: 0000000000000000 o2:
> 00000000007b7ad0 o3: fffff8d1f383f8e8
> [   85.152860] o4: 0000000000744000 o5: 00000000007bc400 sp:
> fffff8d1f383ee01 ret_pc: 0000000000557fcc
> [   85.161883] RPC: <bust_spinlocks+0x48/0x4c>
> [   85.166032] l0: e00000a00b000036 l1: 0000000000000000 l2:
> 00000000007b7ed0 l3: ffffffffffffd599
> [   85.174697] l4: 00000000007b7ad0 l5: 000000000073c040 l6:
> 0000000000000020 l7: 0000000000000010
> [   85.183362] i0: 0000000000000000 i1: 0000000000000000 i2:
> 00000000007b7ad0 i3: fffffffffffffffe
> [   85.192028] i4: 0000000000000000 i5: 0000000000004000 i6:
> fffff8d1f383eec1 i7: 0000000000456e88
> [   85.200695] I7: <panic+0x6c/0x164>
> [   85.204072] Caller[0000000000456e88]: panic+0x6c/0x164
> [   85.209184] Caller[000000000045a250]: do_exit+0x6c/0x6f8
> [   85.214470] Caller[0000000000428c40]: die_if_kernel+0x238/0x2d4
> [   85.220361] Caller[00000000004344b8]: kernel_mna_trap_fault+0xc8/0xfc
> [   85.226773] Caller[00000000004349c8]: kernel_unaligned_trap
> +0x4dc/0x520
> [   85.233359] Caller[0000000000428750]: mem_address_unaligned+0x58/0x90
> [   85.239771] Caller[0000000000405e08]: do_mna+0x44/0x4c
> [   85.244885] Caller[000000000046d33c]: atomic_notifier_chain_register
> +0x1c/0x44
> [   85.252077] Caller[0000000000782128]: kernel_init+0x38/0x204
> [   85.257709] Caller[0000000000426df8]: kernel_thread+0x38/0x48
> [   85.263427] Caller[000000000067bae0]: rest_init+0x18/0x60
> [   85.268801] Instruction DUMP: e05e0000  1068000f  b0102000 <c25c0000>
> e05c2008  9fc04000  01000000  03000020  b0100008=20
> [   85.279546] Fixing recursive fault but reboot is needed!
> "
>=20
> Etch freezes at "Booting Linux..." with the following arguments :
> console=3Dttya
> console=3DttyS0
> console=3Dsomethingrandom
> console=EArlyprom0
>=20
> :)
>=20
> Also, I tried openBSD earlier today, the setup booted and ran properly,
> but the resulting installation dies from a kernel panic. Just thought
> this info may have some use here. I have sent an e-mail with the output
> to their mailing lists
>=20
> Aaron
>=20
>=20
>=20
> --=20
> To UNSUBSCRIBE, email to debian-sparc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian=
.org
>=20

--=20
     2. That which causes joy or happiness.
