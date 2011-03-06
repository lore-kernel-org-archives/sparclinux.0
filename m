From: Marcel van Nies <morcles@gmail.com>
Date: Sun, 06 Mar 2011 09:13:56 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq support]
Message-Id: <AANLkTinwJi+FOcbFS=2UEbfFYcJUmDeuhgoinJ1PkR5P@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

The hyperSPARC gives the same error without the final genirq patch.

Marcel



On Sun, Mar 6, 2011 at 8:23 AM, Marcel van Nies <morcles@gmail.com> wrote:
> The hyperSPARC boots, but fails when starting init. It runs fine on 2.6.1=
7.
>
> [ =A0 11.116665] VFS: Mounted root (ext3 filesystem) readonly on device 8=
:20.
>
> [ =A0 11.123332] Freeing unused kernel memory: 108k freed
>
> [ =A0 11.186665] init[1]: segfault at 0 ip 5000dac8 (rpc f000eea8) sp
> efe738a0 error 30001 in ld-2.3.5.so[50000000+1a000]
>
> [ =A0 12.029998] Kernel panic - not syncing: Attempted to kill init!
>
> [ =A0 12.033332] [f002ed74 : do_group_exit+0x84/0xb4 ] [f0039a24 :
> get_signal_to_deliver+0x338/0x35c ] [f0011fbc : do_signal+0x30/0x914 ]
> [f00128b4 : do_notify_resume+0x14/0x38 ] [f000fd50 :
> signal_p+0x14/0x24 ] [f000eea8 : srmmu_fault+0x58/0x68 ]
>
> [ =A0 12.079998] Press Stop-A (L1-A) to return to the boot prom
>
> The superSPARC is running ...
>
> # uname -a
> Linux viking 2.6.38-rc2-up #4 Sat Mar 5 22:15:54 CET 2011 sparc sun4m
> Texas Instruments, Inc. - SuperSparc-(II) GNU/Linux
>
> SPARCstation 20 MP (2 X SuperSPARC-II), No Keyboard
>
> ROM Rev. 2.25, 448 MB memory installed, Serial #8021487.
>
> Ethernet address 8:0:20:7a:65:ef, Host ID: 727a65ef.
>
>
>
>
>
>
>
> Boot device: /iommu/sbus/espdma@f,400000/esp@f,800000/sd@3,0 =A0File and =
args:
>
> SILO Version 1.4.13
>
> boot:
>
> Loaded kernel version 2.6.38
>
> PROMLIB: obio_ranges 5
>
> OF stdout device is: /obio/zs@0,100000:a
>
> Booting Linux...
>
> [ =A0 =A00.000000] PROMLIB: Sun Boot Prom Version 3 Revision 2
>
> [ =A0 =A00.000000] Linux version 2.6.38-rc2-up (root@jalapeno) (gcc
> version 4.4.4 (Gentoo 4.4.4-r2 p1.3, pie-0.4.5) ) #4 Sat Mar 5
> 22:15:54 CET 2011
>
> [ =A0 =A00.000000] ARCH: SUN4M
>
> [ =A0 =A00.000000] TYPE: Sun4m SparcStation10/20
>
> [ =A0 =A00.000000] Ethernet address: 08:00:20:7a:65:ef
>
> [ =A0 =A00.000000] Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek
> (jj@ultra.linux.cz). Patching kernel for srmmu[TI Viking/MXCC]/iommu
>
> [ =A0 =A00.000000] 255MB HIGHMEM available.
>
> [ =A0 =A00.000000] OF stdout device is: /obio/zs@0,100000:a
>
> [ =A0 =A00.000000] PROM: Built device tree with 26777 bytes of memory.
>
> [ =A0 =A00.000000] Power off control detected.
>
> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 112944
>
> [ =A0 =A00.000000] Kernel command line: root=3D/dev/sda4
>
> [ =A0 =A00.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
>
> [ =A0 =A00.000000] Dentry cache hash table entries: 32768 (order: 5, 1310=
72 bytes)
>
> [ =A0 =A00.000000] Inode-cache hash table entries: 16384 (order: 4, 65536=
 bytes)
>
> [ =A0 =A00.000000] Memory: 445352k/457964k available (1872k kernel code,
> 12612k reserved, 484k data, 108k init, 261356k highmem)
>
> [ =A0 =A00.000000] SLUB: Genslabs=15, HWalign2, Order=3D0-3, MinObjects=
=3D0,
> CPUs=3D1, Nodes=3D1
>
> [ =A0 =A00.000000] NR_IRQS:64
>
> [ =A0 =A00.000000] Console: colour dummy device 80x25
>
> [ =A0 =A00.000000] console [tty0] enabled
>
> [ =A0 =A00.000000] Calibrating delay loop... 74.60 BogoMIPS (lpj=124160)
>
> [ =A0 =A00.059999] pid_max: default: 32768 minimum: 301
>
> [ =A0 =A00.059999] Mount-cache hash table entries: 512
>
> [ =A0 =A00.066666] NET: Registered protocol family 16
>
> [ =A0 =A00.089999] IOMMU: impl 1 vers 3 table 0xfbc80000[262144 B] map [6=
5536 b]
>
> [ =A0 =A00.099999] bio: create slab <bio-0> at 0
>
> [ =A0 =A00.106666] SCSI subsystem initialized
>
> [ =A0 =A00.146666] NET: Registered protocol family 2
>
> [ =A0 =A00.146666] IP route cache hash table entries: 2048 (order: 1, 819=
2 bytes)
>
> [ =A0 =A00.149999] TCP established hash table entries: 8192 (order: 4, 65=
536 bytes)
>
> [ =A0 =A00.149999] TCP bind hash table entries: 8192 (order: 3, 32768 byt=
es)
>
> [ =A0 =A00.153333] TCP: Hash tables configured (established 8192 bind 819=
2)
>
> [ =A0 =A00.153333] TCP reno registered
>
> [ =A0 =A00.153333] UDP hash table entries: 256 (order: 0, 4096 bytes)
>
> [ =A0 =A00.153333] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>
> [ =A0 =A00.156666] highmem bounce pool size: 64 pages
>
> [ =A0 =A00.233333] msgmni has been set to 359
>
> [ =A0 =A00.236666] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 253)
>
> [ =A0 =A00.236666] io scheduler noop registered
>
> [ =A0 =A00.236666] io scheduler deadline registered (default)
>
> [ =A0 =A00.246666] ffd5c3c0: ttyS0 at MMIO 0xf1100000 (irq =3D 8) is a zs=
 (ESCC)
>
> [ =A0 =A00.246666] Console: ttyS0 (SunZilog zs0)
>
> [ =A0 =A00.253333] console [ttyS0] enabled
>
> [ =A0 =A00.256666] ffd5c3c0: ttyS1 at MMIO 0xf1100004 (irq =3D 8) is a zs=
 (ESCC)
>
> [ =A0 =A00.266666] ffd5c4a0: Keyboard at MMIO 0xf1000000 (irq =3D 8) is a=
 zs
>
> [ =A0 =A00.273333] ffd5c4a0: Mouse at MMIO 0xf1000004 (irq =3D 8) is a zs
>
> [ =A0 =A00.283333] esp: esp0, regs[fd00a000:fd009000] irq[2]
>
> [ =A0 =A00.286666] esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
>
> [ =A0 =A03.293333] scsi0 : esp
>
> [ =A0 =A04.003332] scsi 0:0:3:0: Direct-Access =A0 =A0 FUJITSU =A0MAP3735N
> SUN72G =A00401 PQ: 0 ANSI: 4
>
> [ =A0 =A04.006666] scsi target0:0:3: Beginning Domain Validation
>
> [ =A0 =A04.013332] scsi target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, o=
ffset 15)
>
> [ =A0 =A04.016666] scsi target0:0:3: Domain Validation skipping write tes=
ts
>
> [ =A0 =A04.019999] scsi target0:0:3: Ending Domain Validation
>
> [ =A0 =A04.503332] scsi 0:0:6:0: CD-ROM =A0 =A0 =A0 =A0 =A0 =A0PLEXTOR =
=A0CD-R
> PX-W4220T 1.04 PQ: 0 ANSI: 2
>
> [ =A0 =A04.509999] scsi target0:0:6: Beginning Domain Validation
>
> [ =A0 =A04.516666] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, o=
ffset 8)
>
> [ =A0 =A04.523332] scsi target0:0:6: Domain Validation skipping write tes=
ts
>
> [ =A0 =A04.526666] scsi target0:0:6: Ending Domain Validation
>
> [ =A0 =A04.536666] esp: esp1, regs[fd00c000:fd00b000] irq[7]
>
> [ =A0 =A04.539999] esp: esp1 is a FASHME, 40 MHz (ccf=3D0), SCSI ID 7
>
> [ =A0 =A07.546665] scsi1 : esp
>
> [ =A0 11.069998] mousedev: PS/2 mouse device common for all mice
>
> [ =A0 11.073332] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t08 as =
rtc0
>
> [ =A0 11.076665] TCP cubic registered
>
> [ =A0 11.083332] rtc-m48t59 rtc-m48t59.0: setting system clock to
> 2007-04-29 05:49:08 UTC (1177825748)
>
> [ =A0 11.093332] sd 0:0:3:0: [sda] 143374738 512-byte logical blocks:
> (73.4 GB/68.3 GiB)
>
> [ =A0 11.099998] sd 0:0:3:0: [sda] Write Protect is off
>
> [ =A0 11.106665] sd 0:0:3:0: [sda] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
>
> [ =A0 11.126665] =A0sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
>
> [ =A0 11.139998] sd 0:0:3:0: [sda] Attached SCSI disk
>
> [ =A0 11.156665] EXT3-fs: barriers not enabled
>
> [ =A0 11.166665] kjournald starting. =A0Commit interval 5 seconds
>
> [ =A0 11.169998] EXT3-fs (sda4): mounted filesystem with ordered data mode
>
> [ =A0 11.173332] VFS: Mounted root (ext3 filesystem) readonly on device 8=
:4.
>
> [ =A0 11.179998] Freeing unused kernel memory: 108k freed
>
> INIT: version 2.86 booting
>
> [ =A0 12.723332] NET: Registered protocol family 1
>
>
>
> Gentoo Linux; http://www.gentoo.org/
>
> =A0Copyright 1999-2007 Gentoo Foundation; Distributed under the GPLv2
>
>
>
> blahblah...
>
> INIT: Entering runlevel: 3
> blahblah...
> login:
>
> Marcel
>
>
> On Sat, Mar 5, 2011 at 5:25 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> On Sat, Mar 05, 2011 at 03:49:08PM +0100, Marcel van Nies wrote:
>>> Hi Sam,
>>>
>>> > The patchset will likely not see testing on:
>>> > - =A0Javastation (the pcic changes)
>>> > - sun4m with multiple CPUs
>>> > - sun4c
>>> >
>>> > I have checked the nearby ebay's for relevant boxes - no luck.
>>> > On the other hand there is also a limit for the size of
>>> > my SUN museum :-)
>>>
>>> I've got a small "SUN museum" ...
>>> sun4c: SPARCstation IPX
>>> sun4m: SPARCstation5 (microSPARC II)
>>> sun4m: SPARCstation20 (two-way superSPARC II)
>>> sun4m: SPARCstation20 (four-way hyperSPARC Colorado-3)
>>>
>>> Never got the IPX running on 2.6, but the others are spinning just
>>> fine on some 2.6.1x UP (x=3Dlow).
>>> I'm looking forward to give your patchset a try.
>>
>> Great!
>>
>> If you fetch sparc-next-2.6.git:
>>
>> =A0 git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next-2.6.g=
it
>>
>> then you only need to apply the patch from this mail:
>>
>> =A0 =A0http://marc.info/?l=3Dlinux-sparc&m=129823440700712&w=3D2
>>
>> I'm looking forward for the result of the tests.
>>
>> =A0 =A0 =A0 =A0Sam
>>
>
