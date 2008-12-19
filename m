From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 19 Dec 2008 15:46:52 +0000
Subject: Ultra 10 X failures
Message-Id: <1229701612.3432.105.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm not having any luck getting X to work on my Ultra 10 (onboard ATI
Mach64).

When I try, I get:

(EE) Unable to map mmio aperture. Invalid argument (22)
(EE) Screen(s) found, but none have a usable configuration.

In the Xorg.0.log, I see:

(**) MACH64(0): Depth 24, (--) framebuffer bpp 32
(=) MACH64(0): Using XAA acceleration architecture
(EE) Unable to map mmio aperture. Invalid argument (22)
(WW) MACH64: Mach64 in slot 1:2:0 could not be detected!
(II) UnloadModule: "mach64"
(EE) Screen(s) found, but none have a usable configuration.

Fatal server error:
no screens found

dmesg shows:
------------[ cut here ]------------
WARNING: at drivers/pci/pci-sysfs.c:499 pci_mmap_resource+0xf4/0x150()
process "X" tried to map 0x00000000-0x00000001 on 0000:01:02.0 BAR 2
(size 0x00000000)
Modules linked in: bridge stp bnep rfcomm l2cap bluetooth sunrpc
nf_conntrack_ipv4 ipt_REJECT iptable_filter ip_tables nf_conntrack_ipv6
ip6t_REJECT xt_tcpudp xt_state nf_conntrack ip6table_filter ip6_tables
x_tables ipv6 dm_multipath scsi_dh sr_mod cdrom sunhme sermouse sg
dm_snapshot dm_zero dm_mirror dm_log dm_mod pata_cmd64x ata_generic
libata sd_mod scsi_mod crc_t10dif ext3 jbd mbcache uhci_hcd ohci_hcd
ehci_hcd [last unloaded: scsi_wait_scan]
Call Trace:
 [000000000057cb84] pci_mmap_resource+0xf4/0x150
 [00000000005169d8] mmap+0x48/0x94
 [00000000004b1918] mmap_region+0x25c/0x4a4
 [00000000004b1eac] do_mmap_pgoff+0x34c/0x39c
 [0000000000432854] sys_mmap+0x84/0xb4
 [0000000000406154] linux_sparc_syscall+0x34/0x44
---[ end trace 539489bc773a85f7 ]---

This seemed similar to some traffic on debian-sparc, but none of their
fixes resolves this failure. I've tried 2.6.27.9, 2.6.27.10, and
2.6.27.10 with a patch from debian-sparc, none of them resolve the
failure.

(Patch attempted is here:
http://www.nabble.com/Fix-found-p20330550.html )

lspci says:

01:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro
215GP (rev 5c) (prog-if 00 [VGA controller])
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 13
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [sizeM]
	Region 1: I/O ports at fffffe0100000000 [disabled] [size=1]
	Region 2: Memory at e2000000 (32-bit, non-prefetchable) [size=4K]
	Region 3: [virtual] Memory at fffffe0100000000 (32-bit,
non-prefetchable) [size=1]
	Region 4: [virtual] Memory at fffffe0100000000 (32-bit,
non-prefetchable) [size=1]
	Region 5: [virtual] Memory at fffffe0100000000 (32-bit,
non-prefetchable) [size=1]
	Expansion ROM at fffffe0100000000 [disabled] [size=1]
	Kernel driver in use: atyfb

Versions of related components:
libpciaccess: 0.10.3
libX11: 1.1.4
xorg-x11-drv-ati: 6.8.0
xorg-x11-server-Xorg: 1.5.2 (I tried 1.5.3, it did not change anything)
glibc: 2.8
OBP 3.15.2 1998/11/10 10:35

Base OS is Fedora 9 SPARC (optimized sparcv9).

Any and all help would be greatly appreciated.

~spot

