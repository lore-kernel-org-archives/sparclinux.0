From: Marcel van Nies <morcles@gmail.com>
Date: Sun, 06 Mar 2011 07:23:38 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq support]
Message-Id: <AANLkTik0S=HzcVQAy=gzMgtRC7P9ZZoON0SWyPw5jNFv@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

The hyperSPARC boots, but fails when starting init. It runs fine on 2.6.17.

[   11.116665] VFS: Mounted root (ext3 filesystem) readonly on device 8:20.

[   11.123332] Freeing unused kernel memory: 108k freed

[   11.186665] init[1]: segfault at 0 ip 5000dac8 (rpc f000eea8) sp
efe738a0 error 30001 in ld-2.3.5.so[50000000+1a000]

[   12.029998] Kernel panic - not syncing: Attempted to kill init!

[   12.033332] [f002ed74 : do_group_exit+0x84/0xb4 ] [f0039a24 :
get_signal_to_deliver+0x338/0x35c ] [f0011fbc : do_signal+0x30/0x914 ]
[f00128b4 : do_notify_resume+0x14/0x38 ] [f000fd50 :
signal_p+0x14/0x24 ] [f000eea8 : srmmu_fault+0x58/0x68 ]

[   12.079998] Press Stop-A (L1-A) to return to the boot prom

The superSPARC is running ...

# uname -a
Linux viking 2.6.38-rc2-up #4 Sat Mar 5 22:15:54 CET 2011 sparc sun4m
Texas Instruments, Inc. - SuperSparc-(II) GNU/Linux

SPARCstation 20 MP (2 X SuperSPARC-II), No Keyboard

ROM Rev. 2.25, 448 MB memory installed, Serial #8021487.

Ethernet address 8:0:20:7a:65:ef, Host ID: 727a65ef.







Boot device: /iommu/sbus/espdma@f,400000/esp@f,800000/sd@3,0  File and args:

SILO Version 1.4.13

boot:

Loaded kernel version 2.6.38

PROMLIB: obio_ranges 5

OF stdout device is: /obio/zs@0,100000:a

Booting Linux...

[    0.000000] PROMLIB: Sun Boot Prom Version 3 Revision 2

[    0.000000] Linux version 2.6.38-rc2-up (root@jalapeno) (gcc
version 4.4.4 (Gentoo 4.4.4-r2 p1.3, pie-0.4.5) ) #4 Sat Mar 5
22:15:54 CET 2011

[    0.000000] ARCH: SUN4M

[    0.000000] TYPE: Sun4m SparcStation10/20

[    0.000000] Ethernet address: 08:00:20:7a:65:ef

[    0.000000] Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek
(jj@ultra.linux.cz). Patching kernel for srmmu[TI Viking/MXCC]/iommu

[    0.000000] 255MB HIGHMEM available.

[    0.000000] OF stdout device is: /obio/zs@0,100000:a

[    0.000000] PROM: Built device tree with 26777 bytes of memory.

[    0.000000] Power off control detected.

[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 112944

[    0.000000] Kernel command line: root=3D/dev/sda4

[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)

[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)

[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)

[    0.000000] Memory: 445352k/457964k available (1872k kernel code,
12612k reserved, 484k data, 108k init, 261356k highmem)

[    0.000000] SLUB: Genslabs=15, HWalign2, Order=3D0-3, MinObjects=3D0,
CPUs=3D1, Nodes=3D1

[    0.000000] NR_IRQS:64

[    0.000000] Console: colour dummy device 80x25

[    0.000000] console [tty0] enabled

[    0.000000] Calibrating delay loop... 74.60 BogoMIPS (lpj=124160)

[    0.059999] pid_max: default: 32768 minimum: 301

[    0.059999] Mount-cache hash table entries: 512

[    0.066666] NET: Registered protocol family 16

[    0.089999] IOMMU: impl 1 vers 3 table 0xfbc80000[262144 B] map [65536 b]

[    0.099999] bio: create slab <bio-0> at 0

[    0.106666] SCSI subsystem initialized

[    0.146666] NET: Registered protocol family 2

[    0.146666] IP route cache hash table entries: 2048 (order: 1, 8192 byte=
s)

[    0.149999] TCP established hash table entries: 8192 (order: 4, 65536 by=
tes)

[    0.149999] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)

[    0.153333] TCP: Hash tables configured (established 8192 bind 8192)

[    0.153333] TCP reno registered

[    0.153333] UDP hash table entries: 256 (order: 0, 4096 bytes)

[    0.153333] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)

[    0.156666] highmem bounce pool size: 64 pages

[    0.233333] msgmni has been set to 359

[    0.236666] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)

[    0.236666] io scheduler noop registered

[    0.236666] io scheduler deadline registered (default)

[    0.246666] ffd5c3c0: ttyS0 at MMIO 0xf1100000 (irq =3D 8) is a zs (ESCC)

[    0.246666] Console: ttyS0 (SunZilog zs0)

[    0.253333] console [ttyS0] enabled

[    0.256666] ffd5c3c0: ttyS1 at MMIO 0xf1100004 (irq =3D 8) is a zs (ESCC)

[    0.266666] ffd5c4a0: Keyboard at MMIO 0xf1000000 (irq =3D 8) is a zs

[    0.273333] ffd5c4a0: Mouse at MMIO 0xf1000004 (irq =3D 8) is a zs

[    0.283333] esp: esp0, regs[fd00a000:fd009000] irq[2]

[    0.286666] esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7

[    3.293333] scsi0 : esp

[    4.003332] scsi 0:0:3:0: Direct-Access     FUJITSU  MAP3735N
SUN72G  0401 PQ: 0 ANSI: 4

[    4.006666] scsi target0:0:3: Beginning Domain Validation

[    4.013332] scsi target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset =
15)

[    4.016666] scsi target0:0:3: Domain Validation skipping write tests

[    4.019999] scsi target0:0:3: Ending Domain Validation

[    4.503332] scsi 0:0:6:0: CD-ROM            PLEXTOR  CD-R
PX-W4220T 1.04 PQ: 0 ANSI: 2

[    4.509999] scsi target0:0:6: Beginning Domain Validation

[    4.516666] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset =
8)

[    4.523332] scsi target0:0:6: Domain Validation skipping write tests

[    4.526666] scsi target0:0:6: Ending Domain Validation

[    4.536666] esp: esp1, regs[fd00c000:fd00b000] irq[7]

[    4.539999] esp: esp1 is a FASHME, 40 MHz (ccf=3D0), SCSI ID 7

[    7.546665] scsi1 : esp

[   11.069998] mousedev: PS/2 mouse device common for all mice

[   11.073332] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t08 as rtc0

[   11.076665] TCP cubic registered

[   11.083332] rtc-m48t59 rtc-m48t59.0: setting system clock to
2007-04-29 05:49:08 UTC (1177825748)

[   11.093332] sd 0:0:3:0: [sda] 143374738 512-byte logical blocks:
(73.4 GB/68.3 GiB)

[   11.099998] sd 0:0:3:0: [sda] Write Protect is off

[   11.106665] sd 0:0:3:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA

[   11.126665]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7

[   11.139998] sd 0:0:3:0: [sda] Attached SCSI disk

[   11.156665] EXT3-fs: barriers not enabled

[   11.166665] kjournald starting.  Commit interval 5 seconds

[   11.169998] EXT3-fs (sda4): mounted filesystem with ordered data mode

[   11.173332] VFS: Mounted root (ext3 filesystem) readonly on device 8:4.

[   11.179998] Freeing unused kernel memory: 108k freed

INIT: version 2.86 booting

[   12.723332] NET: Registered protocol family 1



Gentoo Linux; http://www.gentoo.org/

 Copyright 1999-2007 Gentoo Foundation; Distributed under the GPLv2



blahblah...

INIT: Entering runlevel: 3
blahblah...
login:

Marcel


On Sat, Mar 5, 2011 at 5:25 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sat, Mar 05, 2011 at 03:49:08PM +0100, Marcel van Nies wrote:
>> Hi Sam,
>>
>> > The patchset will likely not see testing on:
>> > - =A0Javastation (the pcic changes)
>> > - sun4m with multiple CPUs
>> > - sun4c
>> >
>> > I have checked the nearby ebay's for relevant boxes - no luck.
>> > On the other hand there is also a limit for the size of
>> > my SUN museum :-)
>>
>> I've got a small "SUN museum" ...
>> sun4c: SPARCstation IPX
>> sun4m: SPARCstation5 (microSPARC II)
>> sun4m: SPARCstation20 (two-way superSPARC II)
>> sun4m: SPARCstation20 (four-way hyperSPARC Colorado-3)
>>
>> Never got the IPX running on 2.6, but the others are spinning just
>> fine on some 2.6.1x UP (x=3Dlow).
>> I'm looking forward to give your patchset a try.
>
> Great!
>
> If you fetch sparc-next-2.6.git:
>
> =A0 git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next-2.6.git
>
> then you only need to apply the patch from this mail:
>
> =A0 =A0http://marc.info/?l=3Dlinux-sparc&m=129823440700712&w=3D2
>
> I'm looking forward for the result of the tests.
>
> =A0 =A0 =A0 =A0Sam
>
