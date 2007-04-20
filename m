From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Fri, 20 Apr 2007 12:22:18 +0000
Subject: Soft Lockup on sun4c
Message-Id: <Pine.LNX.4.61.0704201311280.15999@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Can any one advise me on what boot options I can set to identify what is 
going on during boot on my sun4c.

The crash requires a power up reset (L1-A does not work).
The crash also occours when using the CG3 console.

The boot log is:
--------------------------------------------------------------------
ok boot vml -p
Booting from: sd(0,0,0)vml -p 
root on sd0a fstype 4.2
Size: 2736448+0+142708 bytes
Booting Linux...
PROMLIB: Sun Boot Prom Version 0 Revision 0
Linux version 2.6.20.7-p01 (root@a64) (gcc version 4.1.2) #1 Fri Apr 20 07:36:11 BST 2007
ARCH: SUN4C
TYPE: Sun4c SparcStation 1
Ethernet address: 0:80:f1:0:5:89
Loading sun4c MMU routines
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for sun4c
SUN4C: 79 mmu entries for the kernel
PROM: Built device tree with 12437 bytes of memory.
Built 1 zonelists.  Total pages: 9415
Kernel command line: root=/dev/nfs nfsroot.1.1.4:/cross/sparc/sys-root,rsize 48,wsize 48 ip=dhcp init=/sbin/bash.static 
PID hash table entries: 256 (order: 8, 1024 bytes)
start_kernel(): bug: interrupts were enabled early
Console: mono PROM 80x34
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 37568k/40908k available (1832k kernel code, 3372k reserved, 688k data, 140k init, 0k highmem)
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
zs (FFEC01EC): ttyS0 at MMIO 0xf1000000 (irq = 12) is a zs
Console: ttyS0 (SunZilog zs0)
zs (FFEC01EC): ttyS1 at MMIO 0xf1000004 (irq = 12) is a zs
zs (FFEC02A4): Keyboard at MMIO f0000000 (irq = 12) is a zs
zs (FFEC02A4): Mouse at MMIO f0000004 (irq = 12) is a zs
Floppy drive(s): fd0 is 1.44M
ioremap: done with statics, switching to malloc
FDC 0 is a pre-1991 82077
RAMDISK driver initialized: 2 RAM disks of 4096K size 1024 blocksize
sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 00:80:f1:00:05:89 
esp0: IRQ 3 SCSI ID 7 Clk 20MHz CCYCP000 CCF=4 TOut 167 NCR53C90A(esp100a)
scsi0 : Sparc ESP100A (NCR53C90A)
scsi 0:0:3:0: Direct-Access     IBM      DORS-32160       S82C PQ: 0 ANSI: 2
qpti0: IRQ 3 SCSI ID 7 <6>scsi1 : PTI Qlogic,ISP SBUS SCSI irq 3 regs at fe10a000
(Firmware v1.31.32)(Firmware 1.21 95/05/18) [Fast Wide, using single ended interface]
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sda: sda1 sda2 sda3 sda4 sda5 sda7 sda8
sd 0:0:3:0: Attached scsi disk sda
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
input: Sun Mouse as /class/input/input0
TCP cubic registered
/L64/src/linux-2.6/linux-2.6.20.7-p01/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.1.1.24
IP-Config: Complete:
       device=eth0, addr.1.1.24, mask%5.255.255.0, gw.1.1.32,
      host.1.1.24, domain=, nis-domain=(none),
      bootserver=0.0.0.0, rootserver.1.1.4, rootpathLooking up port of RPC 100003/2 on 10.1.1.4
Looking up port of RPC 100005/1 on 10.1.1.4
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 140k freed
BUG: soft lockup detected on CPU#0!
[f001847c : timer_interrupt+0x54/0x26c ] [f00136a0 : handler_irq+0x9c/0xe8 ] [f0010b78 : patch_handler_irq+0x8/0x24 ] [f00616a8 : __handle_mm_fault+0x90/0xa00 ] [f001ead4 : window_ret_fault+0x1c4/0x24c ] [f00124d0 : ret_trap_user_stack_is_bolixed+0x1c/0x24 ] [000bb27c : 0xbb284 ]

----------------------------------------------------------------

Regards
 	Mark Fortescue.
