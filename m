From: Frank Scheiner <frank.scheiner@web.de>
Date: Sun, 31 Dec 2017 20:35:30 +0000
Subject: Re: SPARC regressions in 4.14.7
Message-Id: <a930513b-c317-3bce-f8eb-3ead7a83a45a@web.de>
List-Id: <sparclinux.vger.kernel.org>
References: <6cb2f5fa-970c-6122-0fb5-47b9b5b5ef82@physik.fu-berlin.de>
In-Reply-To: <6cb2f5fa-970c-6122-0fb5-47b9b5b5ef82@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On 12/29/2017 12:55 PM, John Paul Adrian Glaubitz wrote:
> Hi!
>=20
> I just updated of the Sun Fire T2000 we have in Debian from 4.14.2 to 4.1=
4.7 which
> apparently introduced a regression:
>=20
> Segmentation fault

Same here for a T1000 (of course, but already with v4.14.2 as I just=20
found out, output below) and for a V445 w/UltraSPARC IIIi (output=20
further below). Interestingly, no issues on an Enterprise 250 with=20
UltraSPARC II. I get an Oops (output even further below) on my Ultra 80=20
(also w/UltraSPARC II), but it looks unrelated to the issues on US IIIi=20
and T1 and it's also not fatal.

UPDATE: Before moving the SAS disk from the V445 to the T1000 for=20
testing I upgraded a few packages, which triggered initramfs updates for=20
both Linux kernels v4.14.2 and v4.14.7. After reusing that disk in the=20
V445, segfaults now also happen with v4.14.2. So maybe some recently=20
upgraded package is responsible and not the (newer) kernel.

This is the list of packages that were upgraded on the V445:
```
root@v445:/etc/network# apt upgrade
[...]
The following NEW packages will be installed:
   apparmor firmware-linux-free irqbalance libdns-export169 libglib2.0-0
   libglib2.0-data libisc-export166 libnuma1=20
linux-image-4.14.0-2-sparc64-smp
   shared-mime-info xdg-user-dirs
The following packages will be upgraded:
   bsdmainutils debian-ports-archive-keyring debianutils isc-dhcp-client
   klibc-utils libklibc libpython3-stdlib linux-image-sparc64-smp python3
   python3-minimal python3-reportbug reportbug
12 upgraded, 11 newly installed, 0 to remove and 0 not upgraded.
Need to get 38.3 MB of archives.
After this operation, 173 MB of additional disk space will be used.
Do you want to continue? [Y/n]
```

I assume it's "klibc" then (Anatoly Pugachev mentioned issues with it=20
and James Clarke provided patches to fix them in other emails).

UPDATE2: Retested the Ultra 80 with upgraded packages and indeed it now=20
also segfaults just like the other machines.

Cheers,
Frank

****

T1000:
```
[    0.000027] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.d 2011/07/06 14:27'
[    0.000035] PROMLIB: Root node compatible: sun4v
[    0.000098] Linux version 4.14.0-1-sparc64-smp=20
(debian-kernel@lists.debian.org) (gcc version 7.2.0 (Debian 7.2.0-16))=20
#1 SMP Debian 4.14.2-1 (2017-11-30)
[...]
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top=20
... done.
Begin: Running /scripts/local-premount ... [   20.867252] fstype[209]:=20
segfault at 38 ip 00000000800106cc (rpc 0000000080004820) sp=20
000007fefff23011 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
Segmentation fault
[   20.902819] fstype[213]: segfault at 38 ip 00000000800106cc (rpc=20
0000000080004820) sp 000007feffa0f011 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
Segmentation fault
[   20.911720] PM: Starting manual resume from disk
done.
[   20.943747] fstype[219]: segfault at 38 ip 00000000800106cc (rpc=20
0000000080004820) sp 000007feffb65011 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
Segmentation fault
[   21.000643] fstype[223]: segfault at 38 ip 00000000800106cc (rpc=20
0000000080004820) sp 000007feff93b011 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
Segmentation fault
[   21.010658] fstype[226]: segfault at 38 ip 00000000800106cc (rpc=20
0000000080004820) sp 000007feffd57031 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
Segmentation fault
[   21.024151] aes_sparc64: sparc64 aes opcodes not available.
[   21.071705] crc32c_sparc64: sparc64 crc32c opcode not available.
Begin: Will now check root file system ... fsck from util-linux 2.30.2
[/sbin/fsck.ext4 (1) -- /dev/sda2] fsck.ext4 -a -C0 /dev/sda2
/dev/sda2: clean, 32564/3973120 files, 579945/15886276 blocks
done.
[   21.313331] EXT4-fs (sda2): mounted filesystem with ordered data=20
mode. Opts: (null)
done.
Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ... [   21.388016] nuke[250]:=20
segfault at 38 ip 00000000800106cc (rpc 00000000001001d0) sp=20
000007feffd7b131 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
Segmentation fault
done.
[   21.498916] run-init[1]: segfault at 38 ip 00000000800106cc (rpc=20
0000000000100500) sp 000007feffee2ec1 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
[   21.499403] Kernel panic - not syncing: Attempted to kill init!=20
exitcode=3D0x0000000b
[...]
```

V445:
```
[    0.000023] PROMLIB: Sun IEEE Boot Prom 'OBP 4.25.9 2007/08/23 14:12'
[    0.000029] PROMLIB: Root node compatible:
[    0.000089] Linux version 4.14.0-2-sparc64-smp=20
(debian-kernel@lists.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18))=20
#1 SMP Debian 4.14.7-1 (2017-12-22)
[...]
Begin: Loading essential drivers ... done.
Begin: Running /scri[   48.219768] fstype[138]: segfault at 38 ip=20
00000000800106cc (rpc 0000000080004820) sp 000007feff821011 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
pts/init-premount ... done.
Begin: Mounting root file system ..[   48.500920] fstype[142]: segfault=20
at 38 ip 00000000800106cc (rpc 0000000080004820) sp 000007feff995011=20
error 1 in klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
. Begin: Running /scripts/local-[   48.740068] PM: Starting manual=20
resume from disk
top ... done.
Begin: Running /s[   48.855666] fstype[148]: segfault at 38 ip=20
00000000800106cc (rpc 0000000080004820) sp 000007fefffb1011 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
cripts/local-premount ... Segmen[   49.103918] fstype[152]: segfault at=20
38 ip 00000000800106cc (rpc 0000000080004820) sp 000007feffb45011 error=20
1 in klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
tation fault
Segmentation fault[   49.334827] fstype[155]: segfault at 38 ip=20
00000000800106cc (rpc 0000000080004820) sp 000007feffe73031 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]

done.
Segmentation fault
Seg[   49.583973] aes_sparc64: sparc64 aes opcodes not available.
mentation fault
Segmentation fault
[   49.731252] crc32c_sparc64: sparc64 crc32c opcode not available.
Begin: Will now check root file system ... fsck from util-linux 2.30.2
[/sbin/fsck.ext4 (1) -- [   49.991241] EXT4-fs (sda2): mounted=20
filesystem with ordered data mode. Opts: (null)
/dev/sda2] fsck.ext4 -a -C0 /dev/sda2
/dev/sda2: clean, 32564/[   50.159017] nuke[178]: segfault at 38 ip=20
00000000800106cc (rpc 00000000001001d0) sp 000007fefff35131 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
3973120 files, 579945/15886276 blocks
done.
done.
Begin: Running /scripts/local-bottom ... do[   50.473844] run-init[1]:=20
segfault at 38 ip 00000000800106cc (rpc 0000000000100500) sp=20
000007feff982ec1 error 1 in=20
klibc-gioU2Ql6Bpp06841ZXKfdH4dunE.so[80000000+14000]
ne.
Begin: Running /scripts/init-bottom ... Segmentation fault
done.
[   50.773282] Kernel panic - not syncing: Attempted to kill init!=20
exitcode=3D0x0000000b
[   50.773282]
[   50.904571] CPU: 1 PID: 1 Comm: run-init Not tainted=20
4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   51.025807] Call Trace:
[   51.060814]  [000000000046be88] panic+0xe8/0x2a0
[   51.127064]  [0000000000471600] do_exit+0xb60/0xb80
[   51.197064]  [00000000004716cc] do_group_exit+0x2c/0xe0
[   51.272072]  [000000000047d4ac] get_signal+0x3ac/0x640
[   51.345828]  [000000000042db3c] do_signal+0x3c/0x480
[   51.417076]  [000000000042e7d0] do_notify_resume+0x50/0xa0
[   51.495832]  [0000000000404b44] __handle_signal+0xc/0x2c
[   51.572103] Press Stop-A (L1-A) from sun keyboard or send break
[   51.572103] twice on console to return to the boot prom
[   51.572131] kernel BUG at=20
/build/linux-xv5MF8/linux-4.14.7/kernel/cpu.c:815!
[   51.572137]               \|/ ____ \|/
[   51.572137]               "@'/ .. \`@"
[   51.572137]               /_| \__/ |_\
[   51.572137]                  \__U_/
[   51.572139] swapper/3(0): Kernel bad sw trap 5 [#1]
[   51.572145] CPU: 3 PID: 0 Comm: swapper/3 Not tainted=20
4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   51.572150] task: 0000000000c060c0 task.stack: 0000000000bec000
[   51.572153] TSTATE: 0000000080001606 TPC: 000000000046ea98 TNPC:=20
000000000046ea9c Y: 00000008    Not tainted
[   51.572166] TPC: <cpuhp_report_idle_dead+0x78/0x80>
[   51.572171] kernel BUG at=20
/build/linux-xv5MF8/linux-4.14.7/kernel/cpu.c:815!
[   51.572173] g0: 0000001c5d09af00 g1: 0000000000d33160 g2:=20
0000000000000000 g3: 0000000000d83800
[   51.572176] g4: 0000000000c060c0 g5: fff000323ddd0000 g6:=20
0000000000bec000 g7: 000000000000000e
[   51.572178]               \|/ ____ \|/
[   51.572178]               "@'/ .. \`@"
[   51.572178]               /_| \__/ |_\
[   51.572178]                  \__U_/
[   51.572181] o0: 0000000000b32fa0 o1: 000000000000032f o2:=20
0000000000004000 o3: 0000000000000001
[   51.572184] swapper/2(0): Kernel bad sw trap 5 [#2]
[   51.572187] o4: 0000000000d35178 o5: fff000323eb05184 sp:=20
0000000000bef301 ret_pc: 000000000046ea90
[   51.572193] CPU: 2 PID: 0 Comm: swapper/2 Not tainted=20
4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   51.572197] RPC: <cpuhp_report_idle_dead+0x70/0x80>
[   51.572207] kernel BUG at=20
/build/linux-xv5MF8/linux-4.14.7/kernel/cpu.c:815!
[   51.572211] task: fff000323c1c5420 task.stack: fff000323c1f8000
[   51.572214] l0: 0000000000001000 l1: 0000004480001605 l2:=20
00000000004b4264 l3: 0000000000000400
[   51.572217] TSTATE: 0000000080001604 TPC: 000000000046ea98 TNPC:=20
000000000046ea9c Y: 00000008    Not tainted
[   51.572220]               \|/ ____ \|/
[   51.572220]               "@'/ .. \`@"
[   51.572220]               /_| \__/ |_\
[   51.572220]                  \__U_/
[   51.572223] l4: 0000000000000000 l5: 0000000000000000 l6:=20
0000000000000000 l7: 0000000000000008
[   51.572238] TPC: <cpuhp_report_idle_dead+0x78/0x80>
[   51.572241] swapper/0(0): Kernel bad sw trap 5 [#3]
[   51.572244] i0: 000000000000000e i1: 0000000000bec008 i2:=20
0000000000004000 i3: fff000323eb00ec0
[   51.572247] g0: 0000000000a2f224 g1: 0000000000d33160 g2:=20
0000000000000000 g3: 0000000000d83800
[   51.572253] CPU: 0 PID: 0 Comm: swapper/0 Not tainted=20
4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   51.572256] i4: fff000323ddd0000 i5: 0000000000d30ec0 i6:=20
0000000000bef3b1 i7: 00000000004b42bc
[   51.572259] g4: fff000323c1c5420 g5: fff000323dcd0000 g6:=20
fff000323c1f8000 g7: 000000000000000e
[   51.572264] task: fff000323c17ca40 task.stack: fff000323c1f0000
[   51.572272] I7: <do_idle+0x13c/0x1a0>
[   51.572275] o0: 0000000000b32fa0 o1: 000000000000032f o2:=20
0000000000004000 o3: 0000000000000001
[   51.572278] TSTATE: 0000000080001604 TPC: 000000000046ea98 TNPC:=20
000000000046ea9c Y: 00000008    Not tainted
[   51.572280] Call Trace:
[   51.572283] o4: 0000000000d35178 o5: fff000323ea05184 sp:=20
fff000323c1fb481 ret_pc: 000000000046ea90
[   51.572299] TPC: <cpuhp_report_idle_dead+0x78/0x80>
[   51.572303]  [00000000004b42bc] do_idle+0x13c/0x1a0
[   51.572307] RPC: <cpuhp_report_idle_dead+0x70/0x80>
[   51.572310] g0: 00000000004dec20 g1: 0000000000d33160 g2:=20
0000000000000000 g3: 0000000000d83800
[   51.572314]  [00000000004b455c] cpu_startup_entry+0x1c/0x40
[   51.572318] l0: 0000000000001000 l1: 0000000080001603 l2:=20
0000000000a3e314 l3: 0000000000000400
[   51.572321] g4: fff000323c17ca40 g5: fff000323dad0000 g6:=20
fff000323c1f0000 g7: 000000000000000e
[   51.572332]  [0000000000a37de0] rest_init+0xa0/0xc0
[   51.572335] l4: 0000000000000000 l5: 0000000000000000 l6:=20
0000000000000000 l7: 0000000000000008
[   51.572338] o0: 0000000000b32fa0 o1: 000000000000032f o2:=20
0000000000004000 o3: 0000000000000001
[   51.572346]  [0000000000cb6b64] start_kernel+0x498/0x4a8
[   51.572350] i0: 000000000000000e i1: fff000323c1f8008 i2:=20
0000000000004000 i3: fff000323ea00ec0
[   51.572353] o4: 0000000000d35178 o5: fff000323e805184 sp:=20
fff000323c1f3481 ret_pc: 000000000046ea90
[   51.572358]  [0000000000cb9408] start_early_boot+0x2b8/0x2c8
[   51.572361] i4: fff000323dcd0000 i5: 0000000000d30ec0 i6:=20
fff000323c1fb531 i7: 00000000004b42bc
[   51.572364] RPC: <cpuhp_report_idle_dead+0x70/0x80>
[   51.572369]  [0000000000a37d38] tlb_fixup_done+0x4c/0x54
[   51.572380] I7: <do_idle+0x13c/0x1a0>
[   51.572383] l0: 0000000000001000 l1: 0000004480001603 l2:=20
00000000004b4264 l3: 0000000000000400
[   51.572387]  [00000000000277a4] 0x277a4
[   51.572389] Call Trace:
[   51.572391] l4: 0000000000000000 l5: 0000000000000000 l6:=20
0000000000000000 l7: 0000000000000008
[   51.572396] Caller[00000000004b42bc]: do_idle+0x13c/0x1a0
[   51.572401]  [00000000004b42bc] do_idle+0x13c/0x1a0
[   51.572404] i0: 000000000000000e i1: fff000323c1f0008 i2:=20
0000000000004000 i3: fff000323e800ec0
[   51.572408] Caller[00000000004b455c]: cpu_startup_entry+0x1c/0x40
[   51.572413]  [00000000004b4564] cpu_startup_entry+0x24/0x40
[   51.572416] i4: fff000323dad0000 i5: 0000000000d30ec0 i6:=20
fff000323c1f3531 i7: 00000000004b42bc
[   51.572420] Caller[0000000000a37de0]: rest_init+0xa0/0xc0
[   51.572434]  [000000000043fbc0] smp_callin+0x100/0x140
[   51.572445] I7: <do_idle+0x13c/0x1a0>
[   51.572449] Caller[0000000000cb6b64]: start_kernel+0x498/0x4a8
[   51.572454]  [0000000000c0ddb4] 0xc0ddb4
[   51.572456] Call Trace:
[   51.572460] Caller[0000000000cb9408]: start_early_boot+0x2b8/0x2c8
[   51.572463]  [0000000040000000] 0x40000000
[   51.572467]  [00000000004b42bc] do_idle+0x13c/0x1a0
[   51.572471] Caller[0000000000a37d38]: tlb_fixup_done+0x4c/0x54
[   51.572475] Caller[00000000004b42bc]: do_idle+0x13c/0x1a0
[   51.572480]  [00000000004b455c] cpu_startup_entry+0x1c/0x40
[   51.572483] Caller[00000000000277a4]: 0x277a4
[   51.572487] Caller[00000000004b4564]: cpu_startup_entry+0x24/0x40
[   51.572500]  [000000000043fbc0] smp_callin+0x100/0x140
[   51.572502] Instruction DUMP:
[   51.572507] Caller[000000000043fbc0]: smp_callin+0x100/0x140
[   51.572512]  [0000000000c0ddb4] 0xc0ddb4
[   51.572515]  9210232f
[   51.572518] Caller[0000000000c0ddb4]: 0xc0ddb4
[   51.572521]  [0000000040000000] 0x40000000
[   51.572523]  7ffee5dc
[   51.572527] Caller[0000000040000000]: 0x40000000
[   51.572530] Caller[00000000004b42bc]: do_idle+0x13c/0x1a0
[   51.572532]  901223a0
[   51.572534] Instruction DUMP:
[   51.572539] Caller[00000000004b455c]: cpu_startup_entry+0x1c/0x40
[   51.572540] <91d02005>
[   51.572543]  9210232f
[   51.572548] Caller[000000000043fbc0]: smp_callin+0x100/0x140
[   51.572550]  01000000
[   51.572552]  7ffee5dc
[   51.572556] Caller[0000000000c0ddb4]: 0xc0ddb4
[   51.572557]  9de3bf50
[   51.572560]  901223a0
[   51.572563] Caller[0000000040000000]: 0x40000000
[   51.572565]  01000000
[   51.572567] <91d02005>
[   51.572569] Instruction DUMP:
[   51.572572]  3b0034c3
[   51.572574]  01000000
[   51.572577]  9210232f
[   51.572580]  b8102082
[   51.572582]  9de3bf50
[   51.572584]  7ffee5dc
[   51.572587]
[   51.572588]  01000000
[   51.572590]  901223a0
[   51.572593]  3b0034c3
[   51.572595] <91d02005>
[   51.572597]  b8102082
[   51.572599]  01000000
[   51.572601]
[   51.572602]  9de3bf50
[   51.572604]  01000000
[   51.572605]  3b0034c3
[   51.572607]  b8102082
[   51.572608]
[   61.226356] ---[ end Kernel panic - not syncing: Attempted to kill=20
init! exitcode=3D0x0000000b
[   61.226356]
sc> poweroff -y -f
```

Ultra 80:
```
[    0.000087] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:35'
[    0.000103] PROMLIB: Root node compatible:
[    0.000357] Linux version 4.14.0-2-sparc64-smp=20
(debian-kernel@lists.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18))=20
#1 SMP Debian 4.14.7-1 (2017-12-22)
[...]
[   28.393357] floppy: error 10 while reading block 0
[   28.450663] Kernel unaligned access at TPC[4b2f20]=20
__wake_up_common+0x40/0x1a0
[   28.537074] Unable to handle kernel NULL pointer dereference in mna=20
handler
[   28.537082]  at virtual address 0000000000000001
[   28.675556] current->{active_,}mm->context =3D 0000000000000032
[   28.744296] current->{active_,}mm->pgd =3D fffff800f220c000
[   28.808862]               \|/ ____ \|/
[   28.808862]               "@'/ .. \`@"
[   28.808862]               /_| \__/ |_\
[   28.808862]                  \__U_/
[   28.984889] systemd-udevd(96): Oops [#1]
[   29.031737] CPU: 1 PID: 96 Comm: systemd-udevd Not tainted=20
4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   29.139009] task: fffff800f2271400 task.stack: fffff800f2280000
[   29.209820] TSTATE: 0000008811e01602 TPC: 00000000004b2f20 TNPC:=20
00000000004b2f24 Y: 00000000    Not tainted
[   29.327515] TPC: <__wake_up_common+0x40/0x1a0>
[   29.380614] g0: 0000000000000025 g1: 0000000000000001 g2:=20
0000000000000006 g3: 0000000000000000
[   29.484767] g4: fffff800f2271400 g5: fffff800febd0000 g6:=20
fffff800f2280000 g7: 0000000000000006
[   29.588908] o0: 0000000000000026 o1: 0000000000000006 o2:=20
0000000000000000 o3: 0000000000000000
[   29.693054] o4: 0000000000000026 o5: 0000000000d63332 sp:=20
fffff800f2282551 ret_pc: 00000000004cd660
[   29.801380] RPC: <vprintk_default+0x20/0x40>
[   29.852386] l0: ffffffffffffffe9 l1: 0000000000000000 l2:=20
0000000000000000 l3: 0000000000000006
[   29.956538] l4: fffff800f2283418 l5: fffffffffffffffe l6:=20
0000000000000001 l7: 0000000000000002
[   30.060679] i0: 0000000000000001 i1: 0000000000000003 i2:=20
0000000000000001 i3: 0000000000000000
[   30.164824] i4: 0000000000000000 i5: 0000000000000000 i6:=20
fffff800f2282601 i7: 00000000004b31a0
[   30.268973] I7: <__wake_up_locked+0x20/0x40>
[   30.319984] Call Trace:
[   30.349151]  [00000000004b31a0] __wake_up_locked+0x20/0x40
[   30.414766]  [00000000004b3e94] complete+0x34/0x60
[   30.472056]  [000000000087615c] floppy_rb0_cb+0x1c/0x80
[   30.534531]  [0000000000748abc] bio_endio+0x11c/0x1a0
[   30.594941]  [000000000074e66c] generic_make_request_checks+0x14c/0x5a0
[   30.674089]  [000000000075106c] generic_make_request+0xc/0x280
[   30.743862]  [0000000000751334] submit_bio+0x54/0x180
[   30.804264]  [0000000000876258] __floppy_read_block_0+0x98/0x120
[   30.806746] scsi 0:0:0:0: Direct-Access     SEAGATE  ST336607LSUN36G=20
0507 PQ: 0 ANSI: 3
[   30.806777] scsi target0:0:0: tagged command queuing enabled, command=20
queue depth 16.
[   30.806812] scsi target0:0:0: Beginning Domain Validation
[   30.812483] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns,=20
offset 16)
[   30.815424] scsi target0:0:0: Domain Validation skipping write tests
[   30.815434] scsi target0:0:0: Ending Domain Validation
[   31.356223]  [000000000087657c] floppy_revalidate+0x29c/0x3a0
[   31.424959]  [0000000000666e8c] check_disk_change+0x4c/0x60
[   31.491612]  [0000000000877030] floppy_open+0x2f0/0x3c0
[   31.554094]  [000000000066748c] __blkdev_get+0xac/0x420
[   31.616582]  [0000000000667c10] blkdev_get+0x150/0x3a0
[   31.678025]  [00000000006682d8] blkdev_open+0x98/0xc0
[   31.738438]  [000000000061fe68] do_dentry_open+0x208/0x3a0
[   31.804042]  [0000000000620fac] vfs_open+0x4c/0x80
[   31.861312] Disabling lock debugging due to kernel taint
[   31.924849] Caller[00000000004b31a0]: __wake_up_locked+0x20/0x40
[   31.996708] Caller[00000000004b3e94]: complete+0x34/0x60
[   32.060238] Caller[000000000087615c]: floppy_rb0_cb+0x1c/0x80
[   32.128968] Caller[0000000000748abc]: bio_endio+0x11c/0x1a0
[   32.195623] Caller[000000000074e66c]:=20
generic_make_request_checks+0x14c/0x5a0
[   32.281024] Caller[000000000075106c]: generic_make_request+0xc/0x280
[   32.311855] scsi 0:0:6:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1401=20
1007 PQ: 0 ANSI: 2
[   32.311889] scsi target0:0:6: Beginning Domain Validation
[   32.322890] scsi target0:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns,=20
offset 16)
[   32.331441] scsi target0:0:6: Domain Validation skipping write tests
[   32.331449] scsi target0:0:6: Ending Domain Validation
[   32.738210] Caller[0000000000751334]: submit_bio+0x54/0x180
[   32.804865] Caller[0000000000876258]: __floppy_read_block_0+0x98/0x120
[   32.882972] Caller[000000000087657c]: floppy_revalidate+0x29c/0x3a0
[   32.957953] Caller[0000000000666e8c]: check_disk_change+0x4c/0x60
[   33.030854] Caller[0000000000877030]: floppy_open+0x2f0/0x3c0
[   33.099587] Caller[000000000066748c]: __blkdev_get+0xac/0x420
[   33.168322] Caller[0000000000667c10]: blkdev_get+0x150/0x3a0
[   33.236015] Caller[00000000006682d8]: blkdev_open+0x98/0xc0
[   33.302668] Caller[000000000061fe68]: do_dentry_open+0x208/0x3a0
[   33.374528] Caller[0000000000620fac]: vfs_open+0x4c/0x80
[   33.438056] Caller[0000000000633d2c]: path_openat+0x5ec/0x14a0
[   33.507831] Caller[0000000000635cec]: do_filp_open+0x4c/0xc0
[   33.575525] Caller[0000000000621438]: do_sys_open+0x178/0x220
[   33.644260] Caller[0000000000621500]: SyS_open+0x20/0x40
[   33.707794] Caller[0000000000406214]: linux_sparc_syscall+0x34/0x44
[   33.782769] Caller[000001000005307c]: 0x1000005307c
[   33.841079] Instruction DUMP:
[   33.841086]  80a50001
[   33.876488]  02600023
[   33.904605]  b13ea000
[   33.932725] <e25c2018>
[   33.960844]  a6102000
[   33.988963]  a2047fe8
[   34.017081]  e4040000
[   34.045199]  90100010
[   34.073317]  9610001c
[   34.101436]
[   34.147598]
[   34.165065] floppy driver state
[   34.202552] -------------------
[   34.240009] nowB94899691 last interruptB94897865 diff=1826 last=20
called handler=3Dreset_interrupt
[   34.347254] timeout_message=3Dlock fdc
[   34.389973] last output bytes:
[   34.426392]  0  0 0
[   34.451383]  0  0 0
[   34.476378]  0  0 0
[   34.501373]  8 80 4294897705
[   34.535742]  8 80 4294897705
[   34.570110]  8 80 4294897705
[   34.604477]  8 80 4294897705
[   34.638845]  e 80 4294897705
[   34.673212] 13 80 4294897705
[   34.707581]  0 90 4294897705
[   34.741947] 1a 90 4294897705
[   34.776331]  0 90 4294897705
[   34.810682] 12 80 4294897705
[   34.845049]  0 90 4294897705
[   34.879416] 14 80 4294897705
[   34.913785] 18 80 4294897705
[   34.948152]  8 80 4294897865
[   34.982520]  8 80 4294897865
[   35.016887]  8 80 4294897865
[   35.051253]  8 80 4294897865
[   35.085619] last result at 4294897865
[   35.129361] last redo_fd_request at 4294897865
[   35.182482] status=80
[   35.209548] fdc_busy=3D1
[   35.237669] cont=3D          (null)
[   35.277244] current_req=3D          (null)
[   35.324108] command_status=3D-1
[   35.359515]
[   35.377276] floppy0: floppy timeout called
[   35.426204] no cont in shutdown!
[   35.464728] floppy0: floppy_shutdown: timeout handler died.
[   35.713257] sd 0:0:0:0: [sda] 71132959 512-byte logical blocks: (36.4=20
GB/33.9 GiB)
[   35.722847] sr 0:0:6:0: [sr0] scsi3-mmc drive: 40x/40x cd/rw xa/form2=20
cdda tray
[   35.722856] cdrom: Uniform CD-ROM driver Revision: 3.20
[   35.954690] sd 0:0:0:0: [sda] Write Protect is off
[   36.013415] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, supports DPO and FUA
[   36.131024]  sda: sda1 sda2 sda3 sda4
[   36.181658] sd 0:0:0:0: [sda] Attached SCSI disk
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mo[   36.821139] PM: Starting manual resume from disk
unting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /s[   36.970850] aes_sparc64: sparc64 aes opcodes not=20
available.
cripts/local-premount ... done.
[   37.080728] crc32c_sparc64: sparc64 crc32c opcode not available.
Begin: Will now check root file system ... fsck from util-linux 2.30.2
[/sbin/fsck.ext4 (1) -- /dev/sda2] fsck.ext4 -a -C0 /dev/sda2
/dev/sda2: clean, 36349/1458176 files, 425140/5831594 bloc[   37.463551]=20
EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ks
done.
done.
```
