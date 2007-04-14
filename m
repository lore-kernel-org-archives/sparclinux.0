From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 14 Apr 2007 04:10:46 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <1176523846.3970.238.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-K0Pb92eRPxeEtpNcQ74W"
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--=-K0Pb92eRPxeEtpNcQ74W
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2007-04-13 at 16:10 -0700, David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Fri, 13 Apr 2007 15:18:59 -0500
> 
> > Tried the new esp driver on an SparcStation 4, with not much luck.
> > 
> > If you are willing to tackle this, and want esp_debug, please let me
> > know.
> 
> I need esp_debug info, the very first command fails :)
> I bet no interrupts are arriving, or something like that.
> 
> Please just enable everything with esp.esp_debug=1023

Here you go. Doesn't seem to make much difference. The only difference I
see is this:

ESP: tgt[0] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]

Full log of the boot attempt is attached.

~spot

--=-K0Pb92eRPxeEtpNcQ74W
Content-Disposition: attachment; filename=screenlog.0
Content-Type: text/plain; name=screenlog.0; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


SPARCstation 4, No Keyboard
ROM Rev. 2.24, 160 MB memory installed, Serial #7966051.
Ethernet address 8:0:20:79:8d:63, Host ID: 80798d63.



Testing Memory -=08=0D                                                     =
                =20=0DInitializing Memory |=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08=0D                                                         =
            =20=0DBoot device: /iommu/sbus/espdma/esp/sd@3,0:c  File and ar=
gs:=20
SILO Version 1.4.11
\=08
Welcome to Aurora SPARC Linux!
Hit <TAB> for boot options

boot:=20
1.3062.1                 2.6.20-1.3062.a          1.2986                  =20
1.2906.4                 1.2906                   spot1                   =20
debian                  =20
boot: 1.3062.1 esp.esp_debug=3D1023
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
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08Loa=
ded kernel version 2.6.20
Loading initial ramdisk (3719106 bytes at 0x3000000 phys, 0x60000000 virt).=
..
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
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08PROMLIB: obio_ranges 1
Booting Linux...
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.6.20-1.3062.al3.1 (root@odyssey) (gcc version 4.1.1 2006062=
9 (Red Hat 4.1.1-6)) #1 Fri Apr 13 23:27:30 EDT 2007
ARCH: SUN4M
TYPE: SPARCstation 4
Ethernet address: 8:0:20:79:8d:63
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching =
kernel for srmmu[Fujitsu Swift]/iommu
PROM: Built device tree with 20056 bytes of memory.
Power off control detected.
Built 1 zonelists.  Total pages: 39006
Kernel command line: ro root=3DLABEL=3D/ stop-a=3D1 esp.esp_debug=3D1023
PID hash table entries: 1024 (order: 10, 4096 bytes)
start_kernel(): bug: interrupts were enabled early
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 153428k/163508k available (1776k kernel code, 9924k reserved, 492k =
data, 148k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
SCSI subsystem initialized
IOMMU: impl 0 vers 4 table 0xf9f00000[262144 B] map [65536 b]
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
Freeing initrd memory: 3631k freed
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
ffd35134: Keyboard at MMIO 71000000 (irq =3D 44) is a zs
ffd35134: Mouse at MMIO 71000004 (irq =3D 44) is a zs
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
scsi0 : esp
esp: esp0 found at /iommu@0,10000000/sbus@0,10001000/espdma@4,8400000/esp@4=
,8800000, regs[fd117000:fd00f000] irq[36]
esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
ESP: tgt[0] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
esp: esp0: Aborting command [f946ecc0:12]
esp: esp0: Current command [f946ecc0:12]
esp: esp0: Active command [f946ecc0:12]
esp: esp0: Dumping command log
esp: esp0: ent[5] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[0=
0] event[00]
esp: esp0: ent[6] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[0=
0] event[00]
esp: esp0: ent[7] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[0=
0] event[00]
esp: esp0: ent[8] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[0=
0] event[00]
esp: esp0: ent[9] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[0=
0] event[00]
esp: esp0: ent[10] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[11] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[12] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[13] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[14] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[15] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[16] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[17] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[18] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[19] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[20] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[21] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[22] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[23] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[24] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[25] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[26] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[27] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[28] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[29] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[30] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[31] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[0] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[1] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[2] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[3] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[4] CMD val[c2] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: Aborting command [f946ecc0:00]
esp: esp0: Queued command [f946ecc0:00]
esp: esp0: Dumping command log
esp: esp0: ent[11] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[12] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[13] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[14] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[15] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[16] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[17] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[18] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[19] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[20] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[21] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[22] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[23] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[24] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[25] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[26] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[27] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[28] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[29] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[30] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[31] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[0] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[1] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[2] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[3] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[4] CMD val[c2] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[5] CMD val[1a] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[6] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[7] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[8] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[9] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[10] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
scsi 0:0:0:0: scsi: Device offlined - not ready after error recovery
esp: esp0: Aborting command [f946ecc0:12]
esp: esp0: Queued command [f946ecc0:12]
esp: esp0: Dumping command log
esp: esp0: ent[11] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[12] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[13] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[14] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[15] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[16] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[17] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[18] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[19] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[20] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[21] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[22] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[23] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[24] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[25] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[26] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[27] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[28] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[29] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[30] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[31] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[0] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[1] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[2] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[3] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[4] CMD val[c2] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[5] CMD val[1a] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[6] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[7] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[8] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[9] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[10] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: Aborting command [f946ecc0:00]
esp: esp0: Queued command [f946ecc0:00]
esp: esp0: Dumping command log
esp: esp0: ent[11] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[12] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[13] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[14] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[15] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[16] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[17] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[18] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[19] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[20] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[21] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[22] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[23] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[24] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[25] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[26] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[27] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[28] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[29] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[30] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[31] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[0] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[1] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[2] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[3] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[4] CMD val[c2] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[5] CMD val[1a] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[6] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[7] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[8] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[9] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[10] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: Aborting command [f946ecc0:00]
esp: esp0: Queued command [f946ecc0:00]
esp: esp0: Dumping command log
esp: esp0: ent[16] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[17] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[18] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[19] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[20] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[21] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[22] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[23] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[24] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[25] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[26] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[27] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[28] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[29] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[30] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[31] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[0] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[1] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[2] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[3] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[4] CMD val[c2] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[5] CMD val[1a] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[6] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[7] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[8] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[9] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[10] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[11] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[12] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[13] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[14] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[15] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
scsi 0:0:1:0: scsi: Device offlined - not ready after error recovery
esp: esp0: Aborting command [f946ecc0:12]
esp: esp0: Queued command [f946ecc0:12]
esp: esp0: Dumping command log
esp: esp0: ent[16] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[17] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[18] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[19] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[20] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[21] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[22] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[23] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[24] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[25] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[26] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[27] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[28] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[29] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[30] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[31] EVENT val[00] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[=
00] event[00]
esp: esp0: ent[0] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[1] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[2] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[3] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[00]=
 event[00]
esp: esp0: ent[4] CMD val[c2] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[5] CMD val[1a] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[6] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[7] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[8] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[9] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01]=
 event[00]
esp: esp0: ent[10] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[11] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[12] CMD val[02] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[13] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[14] CMD val[80] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]
esp: esp0: ent[15] CMD val[03] sreg[00] seqreg[00] sreg2[00] ireg[00] ss[01=
] event[00]

Type  'go' to resume
Type  help  for more information
ok boot
Resetting ...=20

--=-K0Pb92eRPxeEtpNcQ74W--

