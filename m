From: Balint Cristian <rezso@rdsor.ro>
Date: Sun, 09 May 2004 17:20:00 +0000
Subject: Re: sun4c (SS IPX) serial console patch [worked !]
Message-Id: <200405092020.00597.rezso@rdsor.ro>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sunday 09 May 2004 18:30, Keith M Wesolowski wrote:
 
>> boot: test console=ttyS0,9600 video=sbus:off
>
> I have no idea what that argument is supposed to do, but it doesn't
> matter.

	I take it from this, in a search how to disable totaly video console/framebuffer,
but I am think this is obsoleted :)

http://www.tux.org/hypermail/linux-sparc/1998-Jul/0162.html



Anyway this one worked at last without any problem,
thanks for your effort !

 
> === include/asm-sparc/vaddrs.h 1.5 vs edited ==> --- 1.5/include/asm-sparc/vaddrs.h	Mon Jan  5 20:26:21 2004
> +++ edited/include/asm-sparc/vaddrs.h	Sun May  9 08:30:01 2004
> @@ -33,9 +33,9 @@
>  
>  #define SUN4M_IOBASE_VADDR	0xfd000000 /* Base for mapping pages */
>  #define IOBASE_VADDR		0xfe000000
> -#define IOBASE_END		0xfe300000
> +#define IOBASE_END		0xfe600000
>  
> -#define VMALLOC_START		0xfe300000
> +#define VMALLOC_START		0xfe600000
>  
>  /* XXX Alter this when I get around to fixing sun4c - Anton */
>  #define VMALLOC_END		0xffc00000

Now, here is what i am catched from serial line (without keyboard and in all off other combinations from PROM env):
 
WARNING: Unable to determine keyboard type
SPARCstation IPX, No Keyboard
ROM Rev. 2.9, 64 MB memory installed, Serial #12648430.
Ethernet address 8:0:20:13:de:ad, Host ID: 57c0ffee.

Boot device: /sbus/esp@0,800000/sd@3,0   File and args:
SILO Version 1.4.4
boot:
Loaded kernel version 2.6.6
Booting Linux...
PROMLIB: Sun Boot Prom Version 2 Revision 2
Linux version 2.6.6-rc3-bk11 (root@sun.rdsor.ro) (gcc version 3.3.3 20040216 (Red Hat Linux 3.3.3-2)) #2 Sun May 9 13:31:35 EDT 2004
ARCH: SUN4C
TYPE: Sun4c SparcStation IPX
Ethernet address: 8:0:20:13:de:ad
Loading sun4c MMU routines
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for sun4c
SS2 cache bug detected, uncaching trap table page
On node 0 totalpages: 15864
  DMA zone: 15864 pages, LIFO batch:3
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
SUN4C: 74 mmu entries for the kernel
Built 1 zonelists
Kernel command line: root=/dev/sda3 ro console=ttyS0,9600
PID hash table entries: 256 (order 8: 2048 bytes)
Console: colour dummy device 80x25
Memory: 62868k/65428k available (1424k kernel code, 2596k reserved, 280k data, 108k init, 0k highmem)
Calibrating delay loop... 39.83 BogoMIPS
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
SCSI subsystem initialized
sbus0: Clock 20.0 MHz
dma0: Revision 1 PLUS
ioremap: done with statics, switching to malloc
cg6: CGsix [GX+ 68020] at 1:fe000000
Console: switching to colour frame buffer device 144x56
zs2 at 0xfe403004 (irq = 12) is a SunZilog
zs3 at 0xfe403000 (irq = 12) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 12) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 12) is a SunZilog
Console: ttyS0 (SunZilog zs0)
sunlance.c:v2.02 24/Aug/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 08:00:20:13:de:ad
eth1: LANCE 08:00:20:13:de:ad
esp0: IRQ 3 SCSI ID 7 Clk 25MHz CCYC@000 CCF=5 TOut 167 NCR53C90A(esp100a)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A (NCR53C90A)
Using anticipatory io scheduler
  Vendor: COMPAQPC  Model: DCAS-32160        Rev: S6CA
  Type:   Direct-Access                      ANSI SCSI revision: 02
esp0: target 3 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sda: 4110000 512-byte hdwr sectors (2104 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 0
mice: PS/2 mouse device common for all mice
input: Sun Mouse on zs/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 108k freed
INIT: version 2.84 booting
                Welcome to Aurora SPARC Linux 1.0 (Ansel)
                Press 'I' to enter interactive startup.
