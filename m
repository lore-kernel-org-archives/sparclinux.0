From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 18 Apr 2007 19:24:48 +0000
Subject: zs Interrupt during boot
Message-Id: <Pine.LNX.4.61.0704181956120.12028@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi David,

I am having problems with interrupts. The problem exists both when using=20
the cgthree console and when using a serial console.

Is it possible to change the kernel to just ignore interrupts from=20
devices that have not yet installed interrupt handlers?
(I have modified my kernel to have a preset command line to save on=20
typing).

ok boot vmlinuz -p
Booting from: sd(0,0,0)vmlinuz -p
root on sd0a fstype 4.2
Size: 2675008+0+142756 bytes
Booting Linux...
PROMLIB: Sun Boot Prom Version 0 Revision 0
Linux version 2.6.20.7-p01 (mark@a64) (gcc version 4.0.4) #1 Wed Apr 18 15:=
30:37 BST 2007
ARCH: SUN4C
TYPE: Sun4c SparcStation 1
Ethernet address: 0:80:f1:0:5:89
Loading sun4c MMU routines
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching =
kernel for sun4c
SUN4C: 79 mmu entries for the kernel
PROM: Built device tree with 12437 bytes of memory.
Built 1 zonelists.  Total pages: 9430
Kernel command line: root=3D/dev/nfs nfsroot=3Dx.x.x.x:/sys-root,rsize 48,w=
size 48 ip=3Ddhcp init=3D/sbin/bash.static
PID hash table entries: 256 (order: 8, 1024 bytes)
start_kernel(): bug: interrupts were enabled early
Console: mono PROM 80x34
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 37628k/40908k available (1780k kernel code, 3312k reserved, 680k da=
ta, 140k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
SCSI subsystem initialized
sbus0: Clock 20.0 MHz
dma0: Revision 1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 3, 32768 bytes)
TCP bind hash table entries: 1024 (order: 2, 20480 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
Console: switching to colour frame buffer device 80x34
/sbus@1,f8000000/cgthree@1,fe000000: cg3 at 1:fe000000
ffec01ec: ttyS0 at MMIO 0xf1000000 (irq =3D 12) is a zs
Console: ttyS0 (SunZilog zs0)
ffec01ec: ttyS1 at MMIO 0xf1000004 (irq =3D 12) is a zs
IO device interrupt, irq =3D 12
PC =3D f0012e80 NPC =3D f0012e84 FP=FF0018e0
AIEEE
Kernel panic - not syncing: bogus interrupt received

Press Stop-A (L1-A) to return to the boot prom
IO device interrupt, irq =3D 12
PC =3D f00118d4 NPC =3D f00118d8 FP=FF001690
AIEEE
Kernel panic - not syncing: bogus interrupt received
....

It eventually hangs requiring a powerup reset.

Regards
 	Mark Fortescue.

