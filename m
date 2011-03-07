From: Marcel van Nies <morcles@gmail.com>
Date: Mon, 07 Mar 2011 06:59:22 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq support]
Message-Id: <AANLkTikhSikPVgLkY8WGGGMXf6w_1HLR4WGr7jh-iAft@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

sparcSTATION 5 (microSPARC-II) works fine ...

~ # uname -a
Linux ss5 2.6.38-rc2-up #4 Sat Mar 5 22:15:54 CET 2011 sparc sun4m
Fujitsu MB86904 GNU/Linux



screen not found.
Can't open input device.
Keyboard not present.  Using tty for input and output.

SPARCstation 5, No Keyboard
ROM Rev. 2.24, 256 MB memory installed, Serial #8625209.
Ethernet address 8:0:20:83:9c:39, Host ID: 80839c39.

Rebooting with command:
Boot device: /iommu/sbus/espdma@5,8400000/esp@5,8800000/sd@3,0  File and ar=
gs:
SILO Version 1.4.14
boot:
Loaded kernel version 2.6.38
PROMLIB: obio_ranges 1
OF stdout device is: /obio/zs@0,100000:a
Booting Linux...
[    0.000000] PROMLIB: Sun Boot Prom Version 3 Revision 2
[    0.000000] Linux version 2.6.38-rc2-up (root@jalapeno) (gcc
version 4.4.4 (Gentoo 4.4.4-r2 p1.3, pie-0.4.5) ) #4 Sat Mar 5
22:15:54 CET 2011
[    0.000000] ARCH: SUN4M
[    0.000000] TYPE: SPARCstation 5
[    0.000000] Ethernet address: 08:00:20:83:9c:39
[    0.000000] Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek
(jj@ultra.linux.cz). Patching kernel for srmmu[Fujitsu Swift]/iommu
[    0.000000] 63MB HIGHMEM available.
[    0.000000] OF stdout device is: /obio/zs@0,100000:a
[    0.000000] PROM: Built device tree with 19644 bytes of memory.
[    0.000000] Power off control detected.
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 64296
[    0.000000] Kernel command line: root=3D/dev/sda6
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 253844k/261840k available (1872k kernel code,
7996k reserved, 484k data, 108k init, 65232k highmem)
[    0.000000] SLUB: Genslabs=15, HWalign2, Order=3D0-3, MinObjects=3D0,
CPUs=3D1, Nodes=3D1
[    0.000000] NR_IRQS:64
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Calibrating delay loop... 107.32 BogoMIPS (lpj=179712)
[    0.059999] pid_max: default: 32768 minimum: 301
[    0.059999] Mount-cache hash table entries: 512
[    0.069999] NET: Registered protocol family 16
[    0.089999] IOMMU: impl 0 vers 4 table 0xfbc80000[262144 B] map [65536 b]
[    0.106666] bio: create slab <bio-0> at 0
[    0.113333] SCSI subsystem initialized
[    0.169999] NET: Registered protocol family 2
[    0.169999] IP route cache hash table entries: 2048 (order: 1, 8192 byte=
s)
[    0.173333] TCP established hash table entries: 8192 (order: 4, 65536 by=
tes)
[    0.173333] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.176666] TCP: Hash tables configured (established 8192 bind 8192)
[    0.176666] TCP reno registered
[    0.176666] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.176666] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.179999] apc: power management initialized
[    0.183333] highmem bounce pool size: 64 pages
[    0.279999] msgmni has been set to 368
[    0.286666] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[    0.286666] io scheduler noop registered
[    0.286666] io scheduler deadline registered (default)
[    0.289999] ffd2c580: ttyS0 at MMIO 0x71100000 (irq =3D 6) is a zs
[    0.289999] Console: ttyS0 (SunZilog zs0)
[    0.293333] console [ttyS0] enabled
[    0.296666] ffd2c580: ttyS1 at MMIO 0x71100004 (irq =3D 6) is a zs
[    0.299999] ffd2c634: Keyboard at MMIO 0x71000000 (irq =3D 6) is a zs
[    0.303333] ffd2c634: Mouse at MMIO 0x71000004 (irq =3D 6) is a zs
[    0.313333] esp: esp0, regs[fd00b000:fd00a000] irq[2]
[    0.316666] esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
[    3.326666] scsi0 : esp
[    4.049999] scsi 0:0:3:0: Direct-Access     FUJITSU  MAP3735N
SUN72G  0401 PQ: 0 ANSI: 4
[    4.053332] scsi target0:0:3: Beginning Domain Validation
[    4.069999] scsi target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset =
15)
[    4.083332] scsi target0:0:3: Domain Validation skipping write tests
[    4.086666] scsi target0:0:3: Ending Domain Validation
[    4.583332] scsi 0:0:6:0: CD-ROM            PLEXTOR  CD-R
PX-W4220T 1.04 PQ: 0 ANSI: 2
[    4.586666] scsi target0:0:6: Beginning Domain Validation
[    4.603332] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset =
8)
[    4.616666] scsi target0:0:6: Domain Validation skipping write tests
[    4.619999] scsi target0:0:6: Ending Domain Validation
[    4.633332] mousedev: PS/2 mouse device common for all mice
[    4.639999] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t08 as rtc0
[    4.646666] TCP cubic registered
[    4.653332] rtc-m48t59 rtc-m48t59.0: setting system clock to
2011-03-07 06:46:37 UTC (1299480397)
[    4.673332] sd 0:0:3:0: [sda] 143374738 512-byte logical blocks:
(73.4 GB/68.3 GiB)
[    4.683332] sd 0:0:3:0: [sda] Write Protect is off
[    4.696666] sd 0:0:3:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    4.729999]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
[    4.756666] sd 0:0:3:0: [sda] Attached SCSI disk
[    4.779999] EXT3-fs: barriers not enabled
[    4.793332] kjournald starting.  Commit interval 5 seconds
[    4.796666] EXT3-fs (sda6): mounted filesystem with ordered data mode
[    4.799999] VFS: Mounted root (ext3 filesystem) readonly on device 8:6.
[    4.803332] Freeing unused kernel memory: 108k freed
INIT: version 2.86 booting
[    6.569999] NET: Registered protocol family 1

Gentoo Linux; http://www.gentoo.org/
 Copyright 1999-2007 Gentoo Foundation; Distributed under the GPLv2

...
INIT: Entering runlevel: 3
...
login:

Marcel


On Sun, Mar 6, 2011 at 10:11 PM, Bob Breuer <breuerr@mc.net> wrote:
> Josip Rodin wrote:
>> On Sun, Mar 06, 2011 at 10:13:56AM +0100, Marcel van Nies wrote:
>>> The hyperSPARC gives the same error without the final genirq patch.
>>>
>>> On Sun, Mar 6, 2011 at 8:23 AM, Marcel van Nies <morcles@gmail.com> wro=
te:
>>>> The hyperSPARC boots, but fails when starting init. It runs fine on 2.=
6.17.
>>
>> I realize that it may be a difficult proposition, but you could try to
>> git bisect it.
>>
>> Did you try it on anything after 2.6.17, maybe that narrows it down furt=
her?
>>
>
> You shouldn't have to go back that far... =A0I was last running 2.6.22 on
> hyperSPARC successfully. =A0Ok, maybe that's not so helpful as it looks
> like it's been a while since I've built a sparc kernel. =A0Probably time
> for me to also try out a new kernel.
>
> Bob
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
