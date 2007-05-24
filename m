From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Thu, 24 May 2007 13:12:58 +0000
Subject: Re: [PATCH]: Better serial console identification
Message-Id: <1180012378.6254.364.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-ysb4X2YZ2fChyVU4vlvZ"
List-Id: <sparclinux.vger.kernel.org>
References: <20070520.140354.92582888.davem@davemloft.net>
In-Reply-To: <20070520.140354.92582888.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--=-ysb4X2YZ2fChyVU4vlvZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-05-24 at 00:35 -0700, David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Wed, 23 May 2007 16:56:59 -0500
> 
> > On Wed, 2007-05-23 at 14:27 -0700, David Miller wrote:
> > > From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> > > Date: Wed, 23 May 2007 14:04:02 -0500
> > > 
> > > > Just for kicks, I tried passing esp_bus_reset_settle=10, but it doesn't
> > > > change the result at all.
> > > > 
> > > > I also grabbed a log with esp_debug=2047, that log is attached.
> > > 
> > > Does this fix the problem?
> > 
> > Nope. No change. Do you want the esp_debug=2047 from that?
> 
> Tom, can you double check that you ran with my fix applied?
> I'm not doubting you, I'll explain why I'm asking this, and
> your hunch to mess around with esp_bus_reset_settle was a
> good one.

I double checked it this morning, and that fix was definitely applied.

I made a new kernel anyways, simply to be thorough. The new kernel,
which DEFINITELY has the patch applied shows the same esp symptoms.

I took a log of it booting with esp_debug=2047 and the esp debugging was
identical.

So, while I certainly don't disagree with your findings, this is not the
resolution to the problem.

~spot

--=-ysb4X2YZ2fChyVU4vlvZ
Content-Disposition: attachment; filename=bootlog-with-serial-patch-davemfix-and-esp-debug.txt
Content-Type: text/plain; name=bootlog-with-serial-patch-davemfix-and-esp-debug.txt; charset=utf-8
Content-Transfer-Encoding: quoted-printable

SPARCstation 4, No Keyboard
ROM Rev. 2.24, 160 MB memory installed, Serial #7966051.
Ethernet address 8:0:20:79:8d:63, Host ID: 80798d63.



Initializing Memory |=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08
                                                                     =20
Rebooting with command:=20
Boot device: /iommu/sbus/espdma/esp/sd@3,0:c  File and args:=20
SILO Version 1.4.11
\=08
Welcome to Aurora SPARC Linux!
Hit <TAB> for boot options

boot:=20
1.3149.6                 1.3149.3                 1.3149.2                =20
1.3062.9                 1.2986                   1.2906.4                =20
spot1                    debian                  =20
boot: 1.3149.6
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08Loaded kernel versi=
on 2.6.21
Loading initial ramdisk (3774750 bytes at 0x3000000 phys, 0x60000000 virt).=
..
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08PROMLIB: obi=
o_ranges 1
OF stdout device is: /obio/zs@0,100000:aBooting Linux...
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.6.21-1.3149.al3.6 (root@odyssey) (gcc version 4.1.1 2006062=
9 (Red Hat 4.1.1-6)) #1 Thu May 24 08:17:08 EDT 2007
ARCH: SUN4M
TYPE: SPARCstation 4
Ethernet address: 8:0:20:79:8d:63
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching =
kernel for srmmu[Fujitsu Swift]/iommu
OF stdout device is: /obio/zs@0,100000:aPROM: Built device tree with 20312 =
bytes of memory.
Power off control detected.
Built 1 zonelists.  Total pages: 39033
Kernel command line: ro root=3DLABEL=3D/ stop-a=3D1
PID hash table entries: 1024 (order: 10, 4096 bytes)
start_kernel(): bug: interrupts were enabled early
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 153528k/163508k available (1676k kernel code, 9816k reserved, 428k =
data, 144k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
IOMMU: impl 0 vers 4 table 0xf0640000[262144 B] map [65536 b]
sbus0: Clock 22.0 MHz
dma0: Revision 2=20
dma1: Revision 2=20
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3686k freed
ioremap: done with statics, switching to malloc
apc: power management initialized
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Console: switching to colour frame buffer device 144x56
/iommu@0,10000000/sbus@0,10001000/SUNW,tcx@2,800000: TCX at 0:50800000, 8-b=
it only
ffd35080: ttyS0 at MMIO 0x71100000 (irq =3D 44) is a zs
Console: ttyS0 (SunZilog zs0)
ffd35080: ttyS1 at MMIO 0x71100004 (irq =3D 44) is a zs
ffd35134: Keyboard at MMIO 0x71000000 (irq =3D 44) is a zs
ffd35134: Mouse at MMIO 0x71000004 (irq =3D 44) is a zs
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 144k freed
input: Sun Mouse as /class/input/input0
Red Hat nash version 6.0.9 starting
Mounting proc filesystem
Mounting sysfs filesystem
Creating /dev
Creating initial device nodes
Setting up hotplug.
Creating block device nodes.
Loading jbd.ko module
Loading ext3.ko module
Loading scsi_mod.ko module
SCSI subsystem initialized
Loading sd_mod.ko module
Loading scsi_transport_spi.ko module
Loading esp.ko module
scsi0 : esp
esp: esp0 found at /iommu@0,10000000/sbus@0,10001000/espdma@4,8400000/esp@4=
,8800000, regs[fd117000:fd00f000] irq[36]
esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
ESP: tgt[0] lun[0] scsi_cmd [ 12 00 00 00 24 da ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 24 da ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[2] lun[0] scsi_cmd [ 12 00 00 00 24 da ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[3] lun[0] scsi_cmd [ 12 00 00 00 24 da ]
ESP: intr sreg[93] seqreg[00] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[2] message[0]
esp0: Doing auto-sense for tgt[3] lun[0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[f0005d40] len[96] write(1)
ESP: intr sreg[83] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[5] sent[18]
ESP: intr sreg[87] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[80] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
esp0: tgt[3] lun[0] AUTO SENSE[ 70 00 06 00 00 00 00 0a 00 00 00 00 29 02 0=
2 00 00 00 ]
ESP: tgt[4] lun[0] scsi_cmd [ 12 00 00 00 24 da ]
ESP: intr sreg[80] seqreg[04] sreg2[00] ireg[20]
ESP: tgt[5] lun[0] scsi_cmd [ 12 00 00 00 24 da ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[6] lun[0] scsi_cmd [ 12 00 00 00 24 da ]
ESP: intr sreg[93] seqreg[00] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[2] message[0]
esp0: Doing auto-sense for tgt[6] lun[0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[f0009d40] len[96] write(1)
ESP: intr sreg[83] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[5] sent[18]
ESP: intr sreg[87] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[80] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
esp0: tgt[6] lun[0] AUTO SENSE[ 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 0=
0 c9 00 05 ]
Creating root device.
Mounting root filesystem.
mount: could not find filesystem '/dev/root'
Setting up other filesystems.
Setting up new root fs
Kernel panic - not syncing: Attempted to kill init!
sePress Stop-A (L1-A) to return to the boot prom
tuproot: moving /dev failed: No such file or directory
no fstab.sys, mounting internal defaults
setuproot: error mounting /proc: No such file or directory
setuproot: error mounting /sys: No such file or directory
Switching to new root and running init.
unmounting old /dev
unmounting old /proc
unmounting old /sys
switchroot: mount failed: No such file or directory
Booting has failed.

--=-ysb4X2YZ2fChyVU4vlvZ--

